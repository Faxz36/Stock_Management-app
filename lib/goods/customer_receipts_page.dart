// import 'package:flutter/material.dart';

// class CustomerReceiptsPage extends StatefulWidget {
//   @override
//   _CustomerReceiptsPageState createState() => _CustomerReceiptsPageState();
// }

// class _CustomerReceiptsPageState extends State<CustomerReceiptsPage> {
//   List<CustomerReceipt> customerReceipts = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer Receipts'),
//       ),
//       body: ListView.builder(
//         itemCount: customerReceipts.length,
//         itemBuilder: (context, index) {
//           final receipt = customerReceipts[index];
//           return ListTile(
//             title: Text(receipt.material),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('DO Number: ${receipt.doNumber}'),
//                 Text('GRN Number: ${receipt.grnNumber}'),
//                 Text('PO Number: ${receipt.poNumber}'),
//                 Text('Quantity: ${receipt.quantity}'),
//                 Text('Box: ${receipt.box}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _addReceiptFromForm();
//   }

//   void _addReceiptFromForm() {
//     final Map<String, String>? formData =
//         ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
//     if (formData != null) {
//       setState(() {
//         customerReceipts.add(CustomerReceipt(
//           material: formData['material']!,
//           doNumber: formData['doNumber']!,
//           grnNumber: formData['grnNumber']!,
//           poNumber: formData['poNumber']!,
//           quantity: formData['quantity']!,
//           box: formData['box']!,
//         ));
//       });
//     }
//   }
// }

// class CustomerReceipt {
//   final String material;
//   final String doNumber;
//   final String grnNumber;
//   final String poNumber;
//   final String quantity;
//   final String box;

//   CustomerReceipt({
//     required this.material,
//     required this.doNumber,
//     required this.grnNumber,
//     required this.poNumber,
//     required this.quantity,
//     required this.box,
//   });
// }
