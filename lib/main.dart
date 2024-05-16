import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// For Cupertino icons and widgets
import 'package:stock_management/Barang/add.dart';
import 'package:stock_management/Barang/good.dart';
import 'package:stock_management/pembekal/vendor.dart';
// Replace with the correct path to your DocumentsForm file
import 'package:stock_management/Material/material.dart';

import 'package:stock_management/Home/analytic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const StockManagerApp());
}

class StockManagerApp extends StatefulWidget {
  const StockManagerApp({super.key});

  @override
  _StockManagerAppState createState() => _StockManagerAppState();
}

class _StockManagerAppState extends State<StockManagerApp> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const PlaceholderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Manager',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        hintColor: Colors.indigoAccent,
        scaffoldBackgroundColor: Colors.grey[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto', // Using Roboto as the default font
      ),
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Removes shadow
        title: Image.asset(
          'lib/images/logo.png', // Path to your logo image in your project's asset folder
          height: 20, // Adjust the size as needed
          fit: BoxFit.cover, // Ensures the entire logo is shown
        ),
      ),
      body: Stack(
        children: <Widget>[
          // Background image part
          Container(
            height: 300, // Adjust the height as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/bg.jpg"), // Your image path
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black
                        .withOpacity(0.7), // Adjust opacity for text visibility
                  ],
                ),
              ),
              alignment: Alignment.bottomLeft,
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18, // Base font size, adjust as needed
                    color: Colors.white, // Default text color
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Flexible & affordable "),
                    TextSpan(
                      text: "storage, ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: "collected "),
                    TextSpan(
                      text: "from your door",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Main content with padding at the top
          Padding(
            padding: const EdgeInsets.only(top: 300), // Adjust padding to fit
            child: ListView(
              children: <Widget>[
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.all(10),
                  children: <Widget>[
                    DashboardIconTile(
                      title: 'Barang',
                      imagePath: 'lib/images/boxes.png',
                      onTap: () => navigateTo(context, const GoodsScreen()),
                    ),
                    DashboardIconTile(
                      title: 'Pembekal',
                      imagePath: 'lib/images/supllier.png',
                      onTap: () => navigateTo(context, const VendorList()),
                    ),
                    DashboardIconTile(
                      title: 'Dokumen',
                      imagePath: 'lib/images/dokument.png',
                      onTap: () => navigateTo(
                          context,
                          AddInventory(
                            onSubmit: (ReceiptData) {},
                          )), // Updated this line
                    ),
                    DashboardIconTile(
                      title: 'Material List',
                      imagePath: 'lib/images/list.png',
                      onTap: () => navigateTo(context,  MaterialList()),
                    ),
                  ],
                ),
              ],
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

  const DashboardIconTile({super.key, 
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
              offset: const Offset(0, 3),
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
            const SizedBox(height: 8),
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

  const DashboardValueTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 240, 41, 61),
            Color.fromARGB(255, 240, 41, 61)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
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
