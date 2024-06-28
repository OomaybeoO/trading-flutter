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
  int _selectedIndex = 0;

  static List<Transaction> transactions = [
    Transaction('2024-06-25', 100, 'USD'),
    Transaction('2024-06-24', 50, 'EUR'),
    Transaction('2024-06-23', 80, 'JPY'),
  ];

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
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomePage(),
          _buildStrategyPage(),
          _buildInformationPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '策略',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: '資訊',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('收益曲線圖'),
              SizedBox(height: 16.0),
              Container(
                height: 200.0,
                color: Colors.grey[300],
                child: Center(child: Text('圖表區域')),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('以實現收益'),
                      Text('+\$5,000'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('未實現收益'),
                      Text('+\$3,000'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('收益率'),
                      Text('8%'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('年化收益率'),
                      Text('12%'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStrategyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('基本策略設定'),
          Slider(
            value: 10,
            min: 0,
            max: 100,
            divisions: 10,
            label: '10%',
            onChanged: (value) {},
          ),
          Slider(
            value: 1,
            min: 0,
            max: 10,
            divisions: 10,
            label: '1',
            onChanged: (value) {},
          ),
          SizedBox(height: 16.0),
          Text('額外策略設定'),
          Slider(
            value: 30,
            min: 0,
            max: 100,
            divisions: 10,
            label: '30%',
            onChanged: (value) {},
          ),
          Slider(
            value: -50,
            min: -100,
            max: 0,
            divisions: 10,
            label: '-50%',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildInformationPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BTC/USDT 交易信息'),
          _buildTransactionInfo('2024-04-29 18:54', '1200', '+10%', '10'),
          SizedBox(height: 16.0),
          Text('2330 交易信息'),
          _buildTransactionInfo('2024-06-26 18:54', '12345', '+10%', '10'),
        ],
      ),
    );
  }

  Widget _buildTransactionInfo(
      String date, String price, String change, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('交易時間: $date'),
        Text('交易價格: $price'),
        Text('漲跌幅: $change'),
        Text('交易量: $amount'),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {},
          child: Text('詳情'),
        ),
      ],
    );
  }
}

class Transaction {
  final String date;
  final int price;
  final String unit;

  Transaction(this.date, this.price, this.unit);
}
