import 'package:flutter/material.dart';
import 'package:stock_management/Barang/documents.dart';

class AddInventory extends StatefulWidget {
  final Function(ReceiptData) onSubmit;

  const AddInventory({super.key, required this.onSubmit});

  @override
  _AddInventoryState createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  late TextEditingController _doNumberController;
  late TextEditingController _grnNumberController;
  late TextEditingController _quantityController;
  late TextEditingController _boxController;
  late TextEditingController _supplierController;

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String? _selectedMaterial;

  @override
  void initState() {
    super.initState();
    _doNumberController = TextEditingController();
    _grnNumberController = TextEditingController();
    _quantityController = TextEditingController();
    _boxController = TextEditingController();
    _supplierController = TextEditingController();
  }

  @override
  void dispose() {
    _doNumberController.dispose();
    _grnNumberController.dispose();
    _quantityController.dispose();
    _boxController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Inventory',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 41, 61),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Adjusted to stretch widgets horizontally
          children: [
            Text(
              'To Receive',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _doNumberController,
              decoration: const InputDecoration(
                labelText: 'D.O Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _grnNumberController,
              decoration: const InputDecoration(
                labelText: 'GRN Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedMaterial,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMaterial = newValue;
                });
              },
              items: <String>[
                'Paper',
                'Plastic',
                'Metal'
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
              decoration: const InputDecoration(
                labelText: 'Material',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _boxController,
                    decoration: const InputDecoration(
                      labelText: 'Box',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _supplierController,
              decoration: const InputDecoration(
                labelText: 'Supplier',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _selectDate(context);
              },
              icon: const Icon(Icons.calendar_today),
              label: const Text('Receive Date'),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                _selectTime(context);
              },
              icon: const Icon(Icons.access_time),
              label: const Text('Receive Time'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _submitForm();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    final receiveDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    final newReceiptData = ReceiptData(
      doNumber: _doNumberController.text,
      grnNumber: _grnNumberController.text,
      quantity: int.parse(_quantityController.text),
      box: int.parse(_boxController.text),
      material: _selectedMaterial ?? '',
      supplier: _supplierController.text,
      receiveDate: receiveDate,
      submissionDate: DateTime.now(),
      poNumber: '',
    );
    widget.onSubmit(newReceiptData);
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}
