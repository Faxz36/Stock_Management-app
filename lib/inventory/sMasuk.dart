import 'package:flutter/material.dart';

class StockItem {
  TextEditingController stockCodeController;
  TextEditingController descriptionController;
  TextEditingController boxesController;
  TextEditingController piecesController;
  TextEditingController receiptsController; // New field for receipts
  TextEditingController issuesController; // New field for issues
  TextEditingController stockController; // New field for stock

  StockItem({
    required this.stockCodeController,
    required this.descriptionController,
    required this.boxesController,
    required this.piecesController,
    required this.receiptsController, // Initialize new controllers
    required this.issuesController, // Initialize new controllers
    required this.stockController, // Initialize new controllers
  });
}

class StockRequestForm extends StatefulWidget {
  const StockRequestForm({super.key});

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
        receiptsController: TextEditingController(), // Initialize new controllers
        issuesController: TextEditingController(), // Initialize new controllers
        stockController: TextEditingController(), // Initialize new controllers
      ),
    );
  }

  void removeStockItem(int index) {
    if (stockItems.length > 1) {
      stockItems[index].stockCodeController.dispose();
      stockItems[index].descriptionController.dispose();
      stockItems[index].boxesController.dispose();
      stockItems[index].piecesController.dispose();
      stockItems[index].receiptsController.dispose(); // Dispose new controllers
      stockItems[index].issuesController.dispose(); // Dispose new controllers
      stockItems[index].stockController.dispose(); // Dispose new controllers
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
        print('Receipts: ${stockItem.receiptsController.text}'); // Print new field
        print('Issues: ${stockItem.issuesController.text}'); // Print new field
        print('Stock: ${stockItem.stockController.text}'); // Print new field
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
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
      stockItem.receiptsController.dispose(); // Dispose new controllers
      stockItem.issuesController.dispose(); // Dispose new controllers
      stockItem.stockController.dispose(); // Dispose new controllers
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Request Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _shiftController,
                decoration: const InputDecoration(labelText: 'Shift'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the shift';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _taskCodeController,
                decoration: const InputDecoration(labelText: 'Task Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the task code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _transferNumberController,
                decoration: const InputDecoration(labelText: 'Transfer Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the transfer number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the customer name';
                  }
                  return null;
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stockItems.length,
                itemBuilder: (context, index) {
                  return StockItemCard(
                    item: stockItems[index],
                    onRemove: () => removeStockItem(index),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addStockItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StockItemCard extends StatelessWidget {
  final StockItem item;
  final VoidCallback onRemove;

  const StockItemCard({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: item.stockCodeController,
              decoration: const InputDecoration(labelText: 'Stock Code'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter stock code';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.boxesController,
              decoration: const InputDecoration(labelText: 'Boxes'),
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
              decoration: const InputDecoration(labelText: 'Pieces'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter number of pieces';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.receiptsController,
              decoration: const InputDecoration(labelText: 'Receipts'), // Add new field
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter receipts';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.issuesController,
              decoration: const InputDecoration(labelText: 'Issues'), // Add new field
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter issues';
                }
                return null;
              },
            ),
            TextFormField(
              controller: item.stockController,
              decoration: const InputDecoration(labelText: 'Stock'), // Add new field
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter stock';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: onRemove,
              child: const Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: StockRequestForm()));
