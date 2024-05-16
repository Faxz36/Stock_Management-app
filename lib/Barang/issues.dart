import 'package:flutter/material.dart';

class IssuesScreen extends StatefulWidget {
  const IssuesScreen({super.key});

  @override
  _IssuesScreenState createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _storesRequestController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _boxController = TextEditingController();
  final TextEditingController _jobNoController = TextEditingController();
  String? _selectedMaterial;

  @override
  void dispose() {
    _storesRequestController.dispose();
    _quantityController.dispose();
    _boxController.dispose();
    _jobNoController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Replace the print statements with actual database save operations.
      print('Stores Request: ${_storesRequestController.text}');
      print('Quantity: ${_quantityController.text}');
      print('Box: ${_boxController.text}');
      print('Job No: ${_jobNoController.text}');
      print('Material: $_selectedMaterial');

      // Clear the form fields after saving the data
      _storesRequestController.clear();
      _quantityController.clear();
      _boxController.clear();
      _jobNoController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Issues',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 240, 41, 61),
      ),
      // appBar: AppBar(
      //   title: Text('Issues'),
      //   backgroundColor: Colors.blue, // Set app bar color
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Material',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedMaterial,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMaterial = newValue;
                    });
                  },
                  items: <String>[
                    'Envelope',
                    'Paper Box'
                  ] // Define the dropdown items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    hintText: 'Select material',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Material';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _storesRequestController,
                  decoration: const InputDecoration(
                    labelText: 'Stores Request',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter stores request';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity (pcs)',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter quantity (pcs)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _boxController,
                  decoration: const InputDecoration(
                    labelText: 'Box',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter box';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _jobNoController,
                  decoration: const InputDecoration(
                    labelText: 'Job No',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter job number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 240, 41, 61), // Button color
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white, // Change text color to white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
