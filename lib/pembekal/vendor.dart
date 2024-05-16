import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:stock_management/pembekal/jsonFile.dart';

class VendorList extends StatefulWidget {
  const VendorList({super.key});

  @override
  _VendorListState createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  final TextEditingController _searchController = TextEditingController();
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
    TextEditingController vendorController = TextEditingController();
    TextEditingController IdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Vendor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              TextField(
                controller: vendorController,
                decoration: const InputDecoration(labelText: 'Vendor'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: IdController,
                decoration: const InputDecoration(labelText: 'ID'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: const Text('Add'),
              onPressed: () {
                FirebaseFirestore.instance.collection('vendors').add({
                  'Vendor': vendorController.text,
                  'ID': IdController.text,
                });
                Navigator.of(context).pop();
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
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this vendor?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('vendors')
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Delete',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateMaterialDialog(
      BuildContext context, DocumentSnapshot material) {
    // Ensure that the values are converted to strings, regardless of their actual types in Firestore
    TextEditingController vendorController =
        TextEditingController(text: material['Vendor']?.toString() ?? '');
    TextEditingController IdController =
        TextEditingController(text: material['ID']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Material'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: vendorController,
                decoration: const InputDecoration(labelText: 'Vendor'),
              ),
              TextField(
                controller: IdController,
                decoration: const InputDecoration(labelText: 'ID'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('vendors')
                    .doc(material.id)
                    .update({
                  'Vendor': vendorController.text,
                  'ID': IdController.text,
                });
                Navigator.of(context).pop();
              },
               child: const Text(
                'Update',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
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
        title: const Text(
          'Vendors List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          //  Untuk letakkan data material list

          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VendorJSON()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMaterialDialog(context),
        backgroundColor: Colors.blueAccent,
       child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.blueAccent.withOpacity(0.1),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search Vendor',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onChanged: (_) => _onSearchChanged(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('vendors').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                var vendors = snapshot.data!.docs.where((doc) {
                  String searchStr = _searchController.text.toLowerCase();
                  String materialDesc =
                      (doc['Vendor'] ?? '').toString().toLowerCase();
                  return materialDesc.contains(searchStr);
                }).toList();

                if (vendors.isEmpty) {
                  return const Center(
                      child: Text('No vendors found matching your search.'));
                }

                vendors.sort((a, b) {
                  String materialAId = (a['Vendor'] ?? '').toString();
                  String materialBId = (b['Vendor'] ?? '').toString();
                  return materialAId.compareTo(materialBId);
                });

                return ListView.builder(
                  itemCount: vendors.length,
                  itemBuilder: (context, index) {
                    var material =
                        vendors[index].data() as Map<String, dynamic>;
                    String vendorID = material['ID'].toString();
                    String vendor = material['Vendor'] ?? 'No vendor';

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          // onTap: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           MaterialDetails(material: material),
                          //     ),
                          //   );
                          // },
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            // leading: const CircleAvatar(
                            //   backgroundColor: Colors.blueAccent,
                            //   child: Icon(Icons.library_books,
                            //       color: Colors.white),
                            // ),
                            title: Text(
                              vendor,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('ID: $vendorID'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.green),
                                  onPressed: () => _showUpdateMaterialDialog(
                                      context, vendors[index]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      _deleteMaterial(vendors[index].id),
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
