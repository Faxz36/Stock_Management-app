import 'package:flutter/material.dart';
import 'package:stock_management/goods/addItems.dart';

class GoodsScreen extends StatefulWidget {
  @override
  _GoodsScreenState createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  List<GoodsItem> goodsList = [];
  TextEditingController _searchController = TextEditingController();
  List<GoodsItem> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(goodsList); // Initialize filtered list with all items initially
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredList = goodsList.where((item) {
        return item.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _searchController.clear();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      'QTY: 0.00',
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ),
                  ],
                ),
                Text(
                  'TOTAL: \$0.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? EmptyStateWidget()
                : ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(
                          filteredList[index].id,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        title: Text(
                          filteredList[index].name,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${filteredList[index].quantity}',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                _showDeleteConfirmationDialog(index);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          _showUpdateDialog(index);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItems()),
          );

          if (result != null && result is GoodsItem) {
            setState(() {
              goodsList.add(result);
              filteredList = List.from(goodsList); // Update filtered list when new item is added
            });
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        // TODO: Set up navigation logic for BottomNavigationBar
      ),
    );
  }

  void _showUpdateDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = filteredList[index].name;
        return AlertDialog(
          title: Text('Update Item'),
          content: TextFormField(
            initialValue: newName,
            onChanged: (value) {
              newName = value;
            },
            decoration: InputDecoration(
              labelText: 'New Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  goodsList[index] = goodsList[index].copyWith(name: newName);
                  filteredList = List.from(goodsList); // Update filtered list
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String itemIdToDelete = filteredList[index].id;
                  goodsList.removeWhere((item) => item.id == itemIdToDelete);
                  filteredList.removeAt(index);
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'lib/images/package.png',
            width: 100,
            height: 100,
          ),
          Text(
            'No Data',
            style: TextStyle(fontSize: 24, color: Colors.black54),
          ),
          Text(
            'Add your goods',
            style: TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

class GoodsItem {
  final String id;
  final String name;
  final int quantity;

  GoodsItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  GoodsItem copyWith({
    String? id,
    String? name,
    int? quantity,
  }) {
    return GoodsItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}
