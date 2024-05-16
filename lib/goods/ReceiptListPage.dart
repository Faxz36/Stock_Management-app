// import 'package:flutter/material.dart';
// import 'package:stock_management/goods/documents.dart';

// class ReceiptListPage extends StatelessWidget {
//   final ReceiptData receiptData;

//   ReceiptListPage({required this.receiptData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Receipt List'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Submitted Data:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Text('Do Number: ${receiptData.doNumber}'),
//             Text('GRN Number: ${receiptData.grnNumber}'),
//             Text('PO Number: ${receiptData.poNumber}'),
//             Text('Quantity: ${receiptData.quantity}'),
//             Text('Box: ${receiptData.box}'),
//             Text('Material: ${receiptData.material}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
