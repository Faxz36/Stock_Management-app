import 'package:flutter/material.dart';



// ... (Other imports and classes remain unchanged)

class DocumentsForm extends StatefulWidget {
  @override
  _DocumentsFormState createState() => _DocumentsFormState();
}

class _DocumentsFormState extends State<DocumentsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _doNumberController = TextEditingController();
  final TextEditingController _grnNumberController = TextEditingController();
  final TextEditingController _poNumberController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _boxController = TextEditingController();

  @override
  void dispose() {
    _doNumberController.dispose();
    _grnNumberController.dispose();
    _poNumberController.dispose();
    _quantityController.dispose();
    _boxController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // You should replace the print statements with actual database save operations.
      print('Do Number: ${_doNumberController.text}');
      print('GRN Number: ${_grnNumberController.text}');
      print('PO Number: ${_poNumberController.text}');
      print('Quantity: ${_quantityController.text}');
      print('Box: ${_boxController.text}');
      
      // Clear the form fields after saving the data
      _doNumberController.clear();
      _grnNumberController.clear();
      _poNumberController.clear();
      _quantityController.clear();
      _boxController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ledger Entry'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _doNumberController,
                decoration: InputDecoration(labelText: 'Do Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Do number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _grnNumberController,
                decoration: InputDecoration(labelText: 'GRN Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter GRN number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _poNumberController,
                decoration: InputDecoration(labelText: 'PO Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PO number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity (pcs)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _boxController,
                decoration: InputDecoration(labelText: 'Box'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter box';
                  }
                  return null;
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
    );
  }
}

// ... (The rest of your application code)
