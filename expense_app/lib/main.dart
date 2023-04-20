import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // allow only portrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses App",
      theme: ThemeData(
        textTheme: const TextTheme(
          labelMedium: TextStyle(
              color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        primarySwatch: Colors.amber,
        colorScheme: const ColorScheme.light(secondary: Colors.amber),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
              fontFamily: "OpenSans", fontSize: 22, color: Colors.amber),
        ),
        fontFamily: "Quicksand",
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final TextEditingController titleController = TextEditingController();
  // final TextEditingController amountController = TextEditingController();

  final List<Transaction> _userTransaction = [
    Transaction(
      id: "t1",
      title: "New shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 99.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(
      {required String title, required double amount, required DateTime date}) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  List<Transaction> get _recentTrans {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _startAddNewTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(
            addNewTransaction: _addNewTransaction,
            userTransaction: _userTransaction,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final myMediaQuery = MediaQuery.of(context);
    final isLandScape = myMediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text("Expenses App"),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTrans(context),
          icon: const Icon(
            Icons.add,
            color: Colors.amber,
          ),
        ),
      ],
    );

    final txListWidget = SizedBox(
      height: (myMediaQuery.size.height -
              appBar.preferredSize.height -
              myMediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        userTransaction: _userTransaction,
        deleteTransaction: _deleteTransaction,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: [
          if (isLandScape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Show Chart"),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
          if (!isLandScape)
            SizedBox(
              height: (myMediaQuery.size.height -
                      appBar.preferredSize.height -
                      myMediaQuery.padding.top) *
                  0.3,
              child: Chart(recentTrans: _recentTrans),
            ),
          if (!isLandScape) txListWidget,
          if (isLandScape)
            _showChart
                ? SizedBox(
                    height: (myMediaQuery.size.height -
                            appBar.preferredSize.height -
                            myMediaQuery.padding.top) *
                        0.65,
                    child: Chart(recentTrans: _recentTrans),
                  )
                : txListWidget,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _startAddNewTrans(context),
        child: const Icon(
          Icons.add,
          color: Colors.amber,
        ),
      ),
    );
  }
}
