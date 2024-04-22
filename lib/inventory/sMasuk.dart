import 'package:flutter/material.dart';

class StockItem {
  TextEditingController stockCodeController;
  TextEditingController descriptionController;
  TextEditingController boxesController;
  TextEditingController piecesController;

  StockItem({
    required this.stockCodeController,
    required this.descriptionController,
    required this.boxesController,
    required this.piecesController,
  });
}

class StockRequestForm extends StatefulWidget {
  @override
  _StockRequestFormState createState() => _StockRequestFormState();
}

class _StockRequestFormState extends State<StockRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _taskCodeController = TextEditingController();
  final TextEditingController _transferNumberController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();

  List<StockItem> stockItems = [];

  @override
  void initState() {
    super.initState();
    addStockItem();
  }

  void addStockItem() {
    stockItems.add(
      StockItem(
        stockCodeController: TextEditingController(),
        descriptionController: TextEditingController(),
        boxesController: TextEditingController(),
        piecesController: TextEditingController(),
      ),
    );
  }

  void removeStockItem(int index) {
    if (stockItems.length > 1) {
      stockItems[index].stockCodeController.dispose();
      stockItems[index].descriptionController.dispose();
      stockItems[index].boxesController.dispose();
      stockItems[index].piecesController.dispose();
      stockItems.removeAt(index);
      setState(() {});
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      for (var stockItem in stockItems) {
        print('Stock Code: ${stockItem.stockCodeController.text}');
        print('Description: ${stockItem.descriptionController.text}');
        print('Boxes: ${stockItem.boxesController.text}');
        print('Pieces: ${stockItem.piecesController.text}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _shiftController.dispose();
    _taskCodeController.dispose();
    _transferNumberController.dispose();
    _customerNameController.dispose();
    for (var stockItem in stockItems) {
      stockItem.stockCodeController.dispose();
      stockItem.descriptionController.dispose();
      stockItem.boxesController.dispose();
      stockItem.piecesController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Request Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _shiftController,
                decoration: InputDecoration(labelText: 'Shift'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the shift';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _taskCodeController,
                decoration: InputDecoration(labelText: 'Task Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the task code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _transferNumberController,
                decoration: InputDecoration(labelText: 'Transfer Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the transfer number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the customer name';
                  }
                  return null;
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: stockItems.length,
                itemBuilder: (context, index) {
                  return StockItemCard(
                    item: stockItems[index],
                    onRemove: () => removeStockItem(index),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addStockItem,
        child: Icon(Icons.add),
      ),
    );
  }
}

class StockItemCard extends StatelessWidget {
  final StockItem item;
  final VoidCallback onRemove;

  const StockItemCard({
    Key? key,
    required this.item,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: item.stockCodeController,
              decoration: InputDecoration(labelText: 'Stock Code'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter stock code';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.boxesController,
              decoration: InputDecoration(labelText: 'Boxes'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number of boxes';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.piecesController,
              decoration: InputDecoration(labelText: 'Pieces'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number of pieces';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: onRemove,
              child: Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: StockRequestForm()));
