import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For Cupertino icons and widgets
import 'package:stock_management/inventory/documents.dart';
import 'package:stock_management/goods/good.dart';
import 'package:stock_management/setting/settings.dart'; // Replace with the correct path to your DocumentsForm file
import 'package:stock_management/inventory/sMasuk.dart';


void main() {
  runApp(StockManagerApp());
}

class StockManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Manager',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Using Roboto as the default font
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200, // Light grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Stock Manager', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Colors.white,
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Stock Manager',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 Stock Manager Corp',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              navigateTo(context, SettingsScreen());
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: DashboardValueTile(
                    title: 'Current Stock',
                    value: '0.00',
                  ),
                ),
                Expanded(
                  child: DashboardValueTile(
                    title: 'Stock Value',
                    value: '\$0.00',
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: EdgeInsets.all(10),
            children: <Widget>[
              DashboardIconTile(
                title: 'Barang',
                imagePath: 'lib/images/packages.png',
                onTap: () =>
                    navigateTo(context, GoodsScreen()),
              ),
              DashboardIconTile(
                title: 'Stock Masuk',
                imagePath:
                    'lib/images/in-stock.png', // Replace with your actual image path
                onTap: () =>
                    navigateTo(context, StockRequestForm()), // Updated this line
              ),
              DashboardIconTile(
                title: 'Stock Keluar',
                imagePath: 'lib/images/out-of-stock.png',
                onTap: () => navigateTo(
                    context, PlaceholderScreen(title: 'Outgoing New')),
              ),
              DashboardIconTile(
                title: 'Suppliers',
                imagePath: 'lib/images/supplier.png',
                onTap: () =>
                    navigateTo(context, PlaceholderScreen(title: 'Suppliers')),
              ),
              DashboardIconTile(
                title: 'Customers',
                imagePath: 'lib/images/customer.png',
                onTap: () =>
                    navigateTo(context, PlaceholderScreen(title: 'Customers')),
              ),
              DashboardIconTile(
                title: 'Documents',
                imagePath: 'lib/images/folder.png',
                onTap: () =>
                    navigateTo(context, DocumentsForm()), // Updated this line
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text('Inventory Reports'),
              trailing: Icon(CupertinoIcons.forward),
              onTap: () => navigateTo(
                  context, PlaceholderScreen(title: 'Inventory Reports')),
            ),
          ),

          // Gap between the boxes
          SizedBox(
              height:
                  1), // Adjust the height value to create a bigger or smaller gap

          // Container for 'Expenses'
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text('Expenses'),
              trailing: Text('\$0.00'),
              onTap: () =>
                  navigateTo(context, PlaceholderScreen(title: 'Expenses')),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardIconTile extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final String? imagePath;
  final Function onTap;

  DashboardIconTile({
    required this.title,
    this.iconData,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 60, // Adjust width as needed
                height: 60, // Adjust height as needed
              )
            else if (iconData != null)
              Icon(iconData, size: 40, color: Colors.indigo.shade400),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: Colors.indigo.shade600)),
          ],
        ),
      ),
    );
  }
}

class DashboardValueTile extends StatelessWidget {
  final String title;
  final String value;

  DashboardValueTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.indigo.shade400, Colors.purple.shade400],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the $title screen'),
      ),
    );
  }
}
