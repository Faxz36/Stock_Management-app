// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart'; // For Cupertino icons and widgets
// import 'package:stock_management/Barang/add.dart';
// import 'package:stock_management/goods/addItems.dart';
// import 'package:stock_management/Barang/documents.dart';
// import 'package:stock_management/Barang/good.dart';
// import 'package:stock_management/pembekal/vendor.dart';
// import 'package:stock_management/setting/settings.dart'; // Replace with the correct path to your DocumentsForm file
// import 'package:stock_management/inventory/sMasuk.dart';
// import 'package:stock_management/Material/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(StockManagerApp());
// }

// class StockManagerApp extends StatefulWidget {
//   @override
//   _StockManagerAppState createState() => _StockManagerAppState();
// }

// class _StockManagerAppState extends State<StockManagerApp> {
//   int _selectedIndex = 0;

//   static  List<Widget> _widgetOptions = <Widget>[
//     DashboardScreen(),
//     PlaceholderScreen(title: 'Home'),
//     SettingsScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Stock Manager',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         fontFamily: 'Roboto', // Using Roboto as the default font
//       ),
//       home: Scaffold(
//         body: _widgetOptions.elementAt(_selectedIndex),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.dashboard),
//               label: 'Dashboard',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.indigo,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   void navigateTo(BuildContext context, Widget screen) {
//     Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 222, 230, 238), // Light grey background
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color.fromARGB(255, 240, 41, 61), Color.fromARGB(255, 240, 41, 61)], 
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: Text('Stock Manager', style: TextStyle(color: Colors.white)),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.info_outline),
//             color: Colors.white,
//             onPressed: () {
//               showAboutDialog(
//                 context: context,
//                 applicationName: 'Stock Manager',
//                 applicationVersion: '1.0.0',
//                 applicationLegalese: '© 2024 Stock Manager Corp',
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.settings),
//             color: Colors.white,
//             onPressed: () {
//               navigateTo(context, SettingsScreen());
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 Expanded(
//                   child: DashboardValueTile(
//                     title: 'Stok Semasa',
//                     value: '0.00',
//                   ),
//                 ),
//                 Expanded(
//                   child: DashboardValueTile(
//                     title: 'Nilai Saham',
//                     value: '\$0.00',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           GridView.count(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             crossAxisCount: 2,
//             childAspectRatio: 1.5,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             padding: EdgeInsets.all(10),
//             children: <Widget>[
//               DashboardIconTile(
//                 title: 'Barang',
//                 imagePath: 'lib/images/boxes.png',
//                 onTap: () => navigateTo(context, GoodsScreen()),
//               ),
//               DashboardIconTile(
//                 title: 'Pembekal',
//                 imagePath: 'lib/images/supllier.png',
//                 onTap: () => navigateTo(context, VendorList()),
//               ),
//               // DashboardIconTile(
//               //   title: 'Pelanggan',
//               //   imagePath: 'lib/images/customer.png',
//               //   onTap: () =>
//               //       navigateTo(context, PlaceholderScreen(title: 'Pelanggan')),
//               // ),
//               DashboardIconTile(
//                 title: 'Dokumen',
//                 imagePath: 'lib/images/dokument.png',
//                 onTap: () => navigateTo(
//                     context,
//                     AddInventory(
//                       onSubmit: (ReceiptData) {},
//                     )), // Updated this line
//               ),
//               DashboardIconTile(
//                 title: 'Material List',
//                 imagePath: 'lib/images/list.png',
//                 onTap: () => navigateTo(context, MaterialList()),
//               ),
//             ],
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ListTile(
//               title: Text('Laporan Inventori'),
//               trailing: Icon(CupertinoIcons.forward),
//               onTap: () => navigateTo(
//                   context, PlaceholderScreen(title: 'Laporan Inventori')),
//             ),
//           ),

//           // Gap between the boxes
//           SizedBox(
//               height:
//                   1), // Adjust the height value to create a bigger or smaller gap

//           // Container for 'Expenses'
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromRGBO(158, 158, 158, 1).withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ListTile(
//               title: Text('Perbelanjaan'),
//               trailing: Text('\$0.00'),
//               onTap: () =>
//                   navigateTo(context, PlaceholderScreen(title: 'Perbelanjaan')),
//             ),
//           ),
//         ],
//       ),
      
//     );
//   }
// }

// class DashboardIconTile extends StatelessWidget {
//   final String title;
//   final IconData? iconData;
//   final String? imagePath;
//   final Function onTap;

//   DashboardIconTile({
//     required this.title,
//     this.iconData,
//     this.imagePath,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onTap(),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (imagePath != null)
//               Image.asset(
//                 imagePath!,
//                 width: 60, // Adjust width as needed
//                 height: 60, // Adjust height as needed
//               )
//             else if (iconData != null)
//               Icon(iconData, size: 40, color: Colors.indigo.shade400),
//             SizedBox(height: 8),
//             Text(title, style: TextStyle(color: Colors.indigo.shade600)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardValueTile extends StatelessWidget {
//   final String title;
//   final String value;

//   DashboardValueTile({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(4),
//       padding: EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color.fromARGB(255, 240, 41, 61), Color.fromARGB(255, 240, 41, 61)], 
//         ),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PlaceholderScreen extends StatelessWidget {
//   final String title;

//   PlaceholderScreen({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Text('This is the $title screen'),
//       ),
//     );
//   }
// }



// untuk letak text DataPos

 // Align(
          //   alignment: AlignmentDirectional.center,
          //   child: Padding(
          //     padding: EdgeInsetsDirectional.fromSTEB(20, 60, 20, 0),
          //     child: Column(
          //       mainAxisSize: MainAxisSize.max,
          //       children: [
          //         Padding(
          //           padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 17),
          //           child: Image.asset(
          //             'lib/images/we.png',
          //             width: 120,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         Text(
          //           'Your place for searching ART.',
          //           style: TextStyle(
          //             fontFamily: 'Playfair Display',
          //             color: Colors.white,
          //             fontSize: 16,
          //             letterSpacing: 0,
          //             fontStyle: FontStyle.italic,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),