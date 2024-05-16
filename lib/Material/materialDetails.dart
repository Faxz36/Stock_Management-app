import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialDetails extends StatefulWidget {
  final Map<String, dynamic> material;

  const MaterialDetails({super.key, required this.material});

  @override
  _MaterialDetailsState createState() => _MaterialDetailsState();
}

class _MaterialDetailsState extends State<MaterialDetails> {
  late TextEditingController _materialController;
  late TextEditingController _plantController;
  late TextEditingController _valuationTypeController;
  late TextEditingController _lastChangeController;
  late TextEditingController _materialDescriptionController;
  late TextEditingController _materialTypeController;
  late TextEditingController _materialGroupController;
  late TextEditingController _baseUnitController;
  late TextEditingController _purchasingGroupController;
  late TextEditingController _abcIndicatorController;
  late TextEditingController _mrpTypeController;
  late TextEditingController _valuationClassController;
  late TextEditingController _priceControlController;
  late TextEditingController _priceController;
  late TextEditingController _currencyController;
  late TextEditingController _priceUnitController;
  late TextEditingController _createdByController;

  @override
  void initState() {
    super.initState();
    _materialController = TextEditingController(
      text: widget.material['Material']?.toString() ?? '',
    );

    _plantController = TextEditingController(
      text: widget.material['Plant']?.toString() ?? '',
    );
    _valuationTypeController = TextEditingController(
      text: widget.material['Valuation Type']?.toString() ?? '',
    );
    _materialDescriptionController = TextEditingController(
      text: widget.material['Material Description']?.toString() ?? '',
    );
    _lastChangeController = TextEditingController(
      text: widget.material['Last Change']?.toString() ?? '',
    );

    _materialTypeController = TextEditingController(
      text: widget.material['Material Type']?.toString() ?? '',
    );
    _materialGroupController = TextEditingController(
      text: widget.material['Material Group']?.toString() ?? '',
    );
    _baseUnitController = TextEditingController(
      text: widget.material['Base Unit of Measure']?.toString() ?? '',
    );
    _purchasingGroupController = TextEditingController(
      text: widget.material['Purchasing Group']?.toString() ?? '',
    );
    _abcIndicatorController = TextEditingController(
      text: widget.material['ABC Indicator']?.toString() ?? '',
    );
    _mrpTypeController = TextEditingController(
      text: widget.material['MRP Type']?.toString() ?? '',
    );
    _valuationClassController = TextEditingController(
      text: widget.material['Valuation Class']?.toString() ?? '',
    );
    _priceControlController = TextEditingController(
      text: widget.material['Price Control']?.toString() ?? '',
    );
    _priceController = TextEditingController(
      text: widget.material['Price']?.toString() ?? '',
    );
    _currencyController = TextEditingController(
      text: widget.material['Currency']?.toString() ?? '',
    );
    _priceUnitController = TextEditingController(
      text: widget.material['Price unit']?.toString() ?? '',
    );
    _createdByController = TextEditingController(
      text: widget.material['Created By']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _materialController.dispose();
    _plantController.dispose();
    _valuationTypeController.dispose();
    _materialDescriptionController.dispose();
    _lastChangeController.dispose();
    _materialTypeController.dispose();
    _materialGroupController.dispose();
    _baseUnitController.dispose();
    _purchasingGroupController.dispose();
    _abcIndicatorController.dispose();
    _mrpTypeController.dispose();
    _valuationClassController.dispose();
    _priceControlController.dispose();
    _priceController.dispose();
    _currencyController.dispose();
    _priceUnitController.dispose();
    _createdByController.dispose();
    super.dispose();
  }

  void _updateMaterialDetails() {
    // Your update logic goes here
    // Example:
    String materialId = widget.material['Material']?.toString() ?? '';
    FirebaseFirestore.instance
        .collection('materials')
        .where('Material', isEqualTo: materialId)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        String docId = querySnapshot.docs.first.id;
        FirebaseFirestore.instance.collection('materials').doc(docId).update({
          'Material': _materialController.text,
          'Plant': _plantController.text,
          'Valuation Type': _valuationTypeController.text,
          'Material Description': _materialDescriptionController.text,
          'Last Change': _lastChangeController.text,
          'Material Type': _materialTypeController.text,
          'Material Group': _materialGroupController.text,
          'Base Unit of Measure': _baseUnitController.text,
          'Purchasing Group': _purchasingGroupController.text,
          'ABC Indicator': _abcIndicatorController.text,
          'MRP Type': _mrpTypeController.text,
          'Valuation Class': _valuationClassController.text,
          'Price Control': _priceControlController.text,
          'Price': _priceController.text,
          'Currency': _currencyController.text,
          'Price unit': _priceUnitController.text,
          'Created By': _createdByController.text,
          // Add other fields as needed
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Material details updated successfully')),
          );
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to update material details: $error')),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Material not found')),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  void _deleteMaterialDetails() {
    FirebaseFirestore.instance
        .collection('materials')
        .doc(widget.material['id'])
        .delete()
        .then((value) {
      Navigator.of(context).pop();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete material: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Material Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            buildDetailField('Material', _materialController),
            buildDetailField('Plant', _plantController),
            buildDetailField('Valuation Type', _valuationTypeController),
            buildDetailField('Material Description', _materialDescriptionController),
            buildDetailField('Last Change', _lastChangeController),
            buildDetailField('Material Type', _materialTypeController),
            buildDetailField('Material Group', _materialGroupController),
            buildDetailField('Base Unit of Measure', _baseUnitController),
            buildDetailField('Purchasing Group', _purchasingGroupController),
            buildDetailField('ABC Indicator', _abcIndicatorController),
            buildDetailField('MRP Type', _mrpTypeController),
            buildDetailField('Valuation Class', _valuationClassController),
            buildDetailField('Price Control', _priceControlController),
            buildDetailField('Price', _priceController),
            buildDetailField('Currency', _currencyController),
            buildDetailField('Price Unit', _priceUnitController),
            buildDetailField('Created By', _createdByController),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: _updateMaterialDetails,
            icon: const Icon(Icons.edit),
            label: const Text('Save'),
            heroTag: 'save',  // Unique hero tag
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: _deleteMaterialDetails,
            icon: const Icon(Icons.delete),
            label: const Text('Delete'),
            heroTag: 'delete',  // Unique hero tag
          ),
        ],
      ),
    );
  }

  Widget buildDetailField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter $label',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
