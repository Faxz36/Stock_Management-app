import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  _PlaceholderScreenState createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: () {}, child: const Text("Monthly")),
                  TextButton(onPressed: () {}, child: const Text("Weekly")),
                  TextButton(onPressed: () {}, child: const Text("Daily")),
                  TextButton(onPressed: () {}, child: const Text("Range")),
                ],
              ),
              CustomBox(
                title: "Profit",
                value: "\$900.00",
                subItems: [
                  SubItem(title: "Revenue", value: "\$3600.00"),
                  SubItem(title: "Cost", value: "\$2700.00"),
                ],
              ),
              CustomBox(
                title: "Stock price",
                value: "\$32140.00",
                subItems: [
                  SubItem(title: "Stock cost", value: "\$22000.00"),
                  SubItem(title: "Unique product", value: "5"),
                  SubItem(title: "Expired product", value: "0"),
                ],
              ),
              const SectionTitle(title: "Revenue Chart"),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300, // Increase the height to accommodate the legend
                  child: RevenuePieChart(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBox extends StatelessWidget {
  final String title;
  final String value;
  final List<SubItem> subItems;

  const CustomBox({super.key, required this.title, required this.value, required this.subItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Divider(color: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: subItems.map((subItem) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subItem.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    subItem.value,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SubItem {
  final String title;
  final String value;

  SubItem({required this.title, required this.value});
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RevenuePieChart extends StatelessWidget {
  const RevenuePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Profit', 38),
      ChartData('Revenue', 50),
      ChartData('Cost', 13),
      ChartData('Expenses', -1), // Add the 'Expenses' category
    ];

    return SfCircularChart(
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        textStyle: TextStyle(fontSize: 14),
      ),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          dataLabelMapper: (ChartData data, _) => '${data.value}%',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 14),
          ),
          pointColorMapper: (ChartData data, _) {
            switch (data.category) {
              case 'Profit':
                return Colors.blue;
              case 'Revenue':
                return Colors.orange;
              case 'Cost':
                return Colors.purple;
              case 'Expenses':
                return Colors.green;
              default:
                return Colors.grey;
            }
          },
        )
      ],
    );
  }
}

class ChartData {
  final String category;
  final int value;

  ChartData(this.category, this.value);
}
