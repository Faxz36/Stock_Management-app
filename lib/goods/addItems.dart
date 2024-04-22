import 'package:flutter/material.dart';
import 'package:stock_management/goods/good.dart';
import 'package:stock_management/goods/receive.dart';

class AddItems extends StatefulWidget {
  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  TextEditingController nameController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Items',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            color: Colors.white,
            onPressed: () {
              // Create a new GoodsItem object with the entered data
              GoodsItem newItem = GoodsItem(
                id: barcodeController.text, // Use barcode as the id
                name: nameController.text,
                quantity: 0, // Set an initial quantity
              );

              // Pass the new item back to the previous screen
              Navigator.pop(context, newItem);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: barcodeController,
              decoration: InputDecoration(
                labelText: 'Barcode',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.qr_code_scanner),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReceivePage()),
                    ); // TODO: Implement receive goods logic
                  },
                  icon: Icon(Icons.add),
                  label: Text('Receive Goods'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement issue goods logic
                  },
                  icon: Icon(Icons.remove),
                  label: Text('Issue Goods'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            Text(
              'Stores Quantities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '0.00',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Your additional widgets go here
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    nameController.dispose();
    barcodeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
