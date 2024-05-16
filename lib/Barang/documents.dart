import 'package:flutter/material.dart';
import 'package:stock_management/Barang/add.dart';

class ReceiptData {
  final String doNumber;
  final String grnNumber;
  final String poNumber;
  final int quantity;
  final int box;
  final String material;
  final String supplier;
  final DateTime receiveDate;
  final DateTime submissionDate;

  ReceiptData({
    required this.doNumber,
    required this.grnNumber,
    required this.poNumber,
    required this.quantity,
    required this.box,
    required this.material,
    required this.supplier,
    required this.receiveDate,
    required this.submissionDate,
  });
}

class DocumentsForm extends StatefulWidget {
  const DocumentsForm({super.key});

  @override
  _DocumentsFormState createState() => _DocumentsFormState();
}

class _DocumentsFormState extends State<DocumentsForm> {
  List<ReceiptData> inventoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Receipt',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 41, 61),
      ),
      body: _buildInventoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddInventory(context);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInventoryList() {
    return ListView.builder(
      itemCount: inventoryList.length,
      itemBuilder: (context, index) {
        final item = inventoryList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text('Material: ${item.material}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Supplier: ${item.supplier}'),
                Text('Quantity: ${item.quantity}'),
                Text('Received Date: ${item.receiveDate.toString()}'),
                Text('Submitted on: ${item.submissionDate.toString()}'),
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteItem(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _editItem(index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () {
                    _showDetailsDialog(context, item);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      inventoryList.removeAt(index);
    });
  }

  void _editItem(int index) async {
    final editedInventory = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditInventoryDialog(
          initialInventory: inventoryList[index],
        );
      },
    );

    if (editedInventory != null) {
      setState(() {
        inventoryList[index] = editedInventory;
      });
    }
  }

  void _navigateToAddInventory(BuildContext context) async {
    final newInventory = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddInventory(onSubmit: _handleSubmit)),
    );
    if (newInventory != null) {
      setState(() {
        inventoryList.add(newInventory);
      });
    }
  }

  void _handleSubmit(ReceiptData newInventory) {
    setState(() {
      inventoryList.add(newInventory);
    });
  }

  void _showDetailsDialog(BuildContext context, ReceiptData item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inventory Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('D.O Number: ${item.doNumber}'),
                Text('GRN Number: ${item.grnNumber}'),
                Text('P.O Number: ${item.poNumber}'),
                Text('Quantity: ${item.quantity}'),
                Text('Box: ${item.box}'),
                Text('Material: ${item.material}'),
                Text('Supplier: ${item.supplier}'),
                Text('Received Date: ${item.receiveDate}'),
                Text('Submitted on: ${item.submissionDate}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class EditInventoryDialog extends StatefulWidget {
  final ReceiptData initialInventory;

  const EditInventoryDialog({super.key, required this.initialInventory});

  @override
  _EditInventoryDialogState createState() => _EditInventoryDialogState();
}

class _EditInventoryDialogState extends State<EditInventoryDialog> {
  late TextEditingController _doNumberController;
  late TextEditingController _grnNumberController;
  late TextEditingController _poNumberController;
  late TextEditingController _quantityController;
  late TextEditingController _boxController;
  late TextEditingController _supplierController;

  @override
  void initState() {
    super.initState();
    _doNumberController = TextEditingController(text: widget.initialInventory.doNumber);
    _grnNumberController = TextEditingController(text: widget.initialInventory.grnNumber);
    _poNumberController = TextEditingController(text: widget.initialInventory.poNumber);
    _quantityController = TextEditingController(text: widget.initialInventory.quantity.toString());
    _boxController = TextEditingController(text: widget.initialInventory.box.toString());
    _supplierController = TextEditingController(text: widget.initialInventory.supplier);
  }

  @override
  void dispose() {
    _doNumberController.dispose();
    _grnNumberController.dispose();
    _poNumberController.dispose();
    _quantityController.dispose();
    _boxController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Inventory'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _doNumberController,
              decoration: const InputDecoration(labelText: 'D.O Number'),
            ),
            TextField(
              controller: _grnNumberController,
              decoration: const InputDecoration(labelText: 'GRN Number'),
            ),
            TextField(
              controller: _poNumberController,
              decoration: const InputDecoration(labelText: 'P.O Number'),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _boxController,
              decoration: const InputDecoration(labelText: 'Box'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _supplierController,
              decoration: const InputDecoration(labelText: 'Supplier'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _submitForm();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _submitForm() {
    final editedInventory = ReceiptData(
      doNumber: _doNumberController.text,
      grnNumber: _grnNumberController.text,
      poNumber: _poNumberController.text,
      quantity: int.parse(_quantityController.text),
      box: int.parse(_boxController.text),
      material: widget.initialInventory.material,
      supplier: _supplierController.text,
      receiveDate: widget.initialInventory.receiveDate,
      submissionDate: widget.initialInventory.submissionDate,
    );

    Navigator.pop(context, editedInventory);
  }
}
