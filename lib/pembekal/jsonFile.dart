import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;

class VendorJSON extends StatelessWidget {
  const VendorJSON({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore JSON Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Firestore JSON Manager',
            style:
                TextStyle(color: Colors.white), // Set the title color to white
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: const Color.fromARGB(
              255, 43, 134, 224), // Set the background color of the app bar
        ),
        backgroundColor: Colors.blue.shade300,
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UploadJsonButton(),
              SizedBox(height: 20),
              DeleteJsonButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadJsonButton extends StatelessWidget {
  const UploadJsonButton({super.key});

  Future<void> uploadJsonToFirestore(BuildContext context) async {
    final jsonString =
        await rootBundle.loadString('lib/images/Datapos_Vendors.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);

    final CollectionReference users =
        FirebaseFirestore.instance.collection('vendors');

    for (var user in jsonData) {
      await users.add({
        'ID': user['ID'],
        'Vendor': user['Vendor'],
        
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('JSON uploaded to Firestore'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => uploadJsonToFirestore(context),
      icon: const Icon(Icons.cloud_upload),
      label: const Text("Upload JSON to Firestore"),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class DeleteJsonButton extends StatelessWidget {
  const DeleteJsonButton({super.key});

  Future<void> deleteJsonFromFirestore(BuildContext context) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('vendors');

    final querySnapshot = await users.get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All documents in "vendors" collection deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => deleteJsonFromFirestore(context),
      icon: const Icon(Icons.delete_forever),
      label: const Text("Delete JSON Data from Firestore"),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
