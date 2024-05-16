// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // Add intl package to your pubspec.yaml

// class ReceivePage extends StatefulWidget {
//   @override
//   _ReceivePageState createState() => _ReceivePageState();
// }

// class _ReceivePageState extends State<ReceivePage> {
//   final TextEditingController _dateController = TextEditingController();
//   DateTime selectedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     _updateDateController(selectedDate);
//   }

//   void _updateDateController(DateTime date) {
//     _dateController.text = DateFormat('dd/MM/yyyy').format(date);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//       _updateDateController(selectedDate); // Update text field with selected date
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Receive Goods',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blueAccent,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.check),
//             color: Colors.white,
//             onPressed: () {
//               // TODO: Save received goods info
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Quantity',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               controller: _dateController,
//               decoration: InputDecoration(
//                 labelText: "Document's date",
//                 border: OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () {
//                     _selectDate(context);
//                   },
//                 ),
//               ),
//               readOnly: true,
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Supplier',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Comment',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     super.dispose();
//   }
// }
