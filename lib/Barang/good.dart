import 'package:flutter/material.dart';
import 'package:stock_management/Barang/documents.dart';
import 'package:stock_management/Barang/issues.dart';
import 'package:stock_management/Barang/itemCategories.dart';

class GoodsScreen extends StatefulWidget {
  const GoodsScreen({super.key});

  @override
  _GoodsScreenState createState() => _GoodsScreenState();
}

class _GoodsScreenState extends State<GoodsScreen> {
  List<GoodsItem> goodsList = [];
  double revenue = 0;
  double profit = 0;
  double losses = 0;
  double cogs = 0;

  @override
  void initState() {
    super.initState();
    _calculateFinancials();
  }

  void _calculateFinancials() {
    revenue = goodsList.fold<double>(
        0, (previousValue, element) => previousValue + element.quantity * element.price);
    profit = _calculateProfit();
    losses = _calculateLosses();
    cogs = _calculateCOGS();

    setState(() {});
  }

  double _calculateProfit() {
    // Implement profit calculation logic
    return revenue - cogs;
  }

  double _calculateLosses() {
    // Implement losses calculation logic
    return 0; // Placeholder
  }

  double _calculateCOGS() {
    // Implement COGS calculation logic
    return 0; // Placeholder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barangan', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 240, 41, 61),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFinancialCard(title: 'Revenue', value: revenue, color: Colors.green),
            const SizedBox(height: 20),
            _buildFinancialCard(title: 'Profit', value: profit, color: Colors.blue),
            const SizedBox(height: 20),
            _buildFinancialCard(title: 'Losses', value: losses, color: Colors.orange),
            const SizedBox(height: 20),
            _buildFinancialCard(title: 'COGS', value: cogs, color: Colors.deepPurple),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: goodsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(goodsList[index].name),
                      subtitle: Text('Quantity: ${goodsList[index].quantity}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoodsDetailScreen(good: goodsList[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemsWithCategoriesScreen()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Receipts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Issues',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DocumentsForm()),
              ).then((value) {
                setState(() {
                  // Handle value from DocumentsForm
                });
              });
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IssuesScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  Widget _buildFinancialCard({required String title, required double value, required Color color}) {
    return Card(
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${value.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class GoodsDetailScreen extends StatelessWidget {
  final GoodsItem good;

  const GoodsDetailScreen({super.key, required this.good});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goods Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${good.name}'),
            Text('Quantity: ${good.quantity}'),
          ],
        ),
      ),
    );
  }
}

class GoodsItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String material;

  GoodsItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.material,
  });
}


