import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Trading Machine Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Counter variable added here

  List<Transaction> transactions = [];

  TextEditingController _priceController = TextEditingController();
  TextEditingController _unitController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initial dummy data (optional)
    transactions = [
      Transaction('2024-06-25', 100, 'USD'),
      Transaction('2024-06-24', 50, 'EUR'),
      Transaction('2024-06-23', 80, 'JPY'),
    ];
  }

  void _incrementCounter() {
    setState(() {
      String price = _priceController.text;
      String unit = _unitController.text;

      // Validate input (optional)
      if (price.isEmpty || unit.isEmpty) {
        return;
      }

      // Simulate a new transaction with date, price, and unit
      transactions.insert(
          0, Transaction(DateTime.now().toString(), int.parse(price), unit));
      _counter++;

      // Clear input fields
      _priceController.clear();
      _unitController.clear();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _selectedIndex == 0 ? _buildTransactionList() : WebViewPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextField(
                  controller: _unitController,
                  decoration: InputDecoration(labelText: 'Unit'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text('Transaction Date: ${transactions[index].date}'),
                  subtitle: Text(
                      'Price: ${transactions[index].price} ${transactions[index].unit}'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _priceController.dispose();
    _unitController.dispose();
    super.dispose();
  }
}

class Transaction {
  final String date;
  final int price;
  final String unit;

  Transaction(this.date, this.price, this.unit);
}

class WebViewPage extends StatelessWidget {
  final String url = 'http://127.0.0.1:8000/charts/kk/';

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
