import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management/Material/jsonFile.dart';
import 'package:stock_management/Material/materialDetails.dart';
import 'dart:async';

class MaterialList extends StatefulWidget {
  @override
  _MaterialListState createState() => _MaterialListState();
}

class _MaterialListState extends State<MaterialList> {
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  void _showAddMaterialDialog(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController materialIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Material Description'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: materialIdController,
                decoration: InputDecoration(labelText: 'Material'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text('Add'),
              onPressed: () {
                FirebaseFirestore.instance.collection('materials').add({
                  'Material Description': descriptionController.text,
                  'Material': materialIdController.text,
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Material added successfully')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteMaterial(String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this material?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                FirebaseFirestore.instance.collection('materials').doc(docId).delete();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Material deleted successfully'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Add undo functionality here if needed
                      },
                    ),
                  ),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateMaterialDialog(BuildContext context, DocumentSnapshot material) {
    TextEditingController descriptionController =
        TextEditingController(text: material['Material Description']?.toString() ?? '');
    TextEditingController materialIdController =
        TextEditingController(text: material['Material']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Material Description'),
              ),
              TextField(
                controller: materialIdController,
                decoration: InputDecoration(labelText: 'Material'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                FirebaseFirestore.instance.collection('materials').doc(material.id).update({
                  'Material Description': descriptionController.text,
                  'Material': materialIdController.text,
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Material updated successfully')),
                );
              },
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Materials List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JSON()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMaterialDialog(context),
        label: Text('Add Material'),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.blueAccent.withOpacity(0.1),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Material',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('materials').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                var materials = snapshot.data!.docs.where((doc) {
                  String searchStr = _searchController.text.toLowerCase();
                  String materialDesc = (doc['Material Description'] ?? '').toString().toLowerCase();
                  return materialDesc.contains(searchStr);
                }).toList();

                if (materials.isEmpty) {
                  return Center(child: Text('No materials found matching your search.'));
                }

                materials.sort((a, b) {
                  String materialAId = (a['Material Description'] ?? '').toString();
                  String materialBId = (b['Material Description'] ?? '').toString();
                  return materialAId.compareTo(materialBId);
                });

                return ListView.builder(
                  itemCount: materials.length,
                  itemBuilder: (context, index) {
                    var material = materials[index].data() as Map<String, dynamic>;
                    String materialId = material['Material'].toString();
                    String description = material['Material Description'] ?? 'No Description';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MaterialDetails(material: material),
                              ),
                            );
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            // leading: CircleAvatar(
                            //   backgroundColor: Colors.blueAccent,
                            //   child: Icon(Icons.library_books, color: Colors.white),
                            // ),
                            title: Text(
                              description,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Material: $materialId'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green),
                                  onPressed: () => _showUpdateMaterialDialog(context, materials[index]),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteMaterial(materials[index].id),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
