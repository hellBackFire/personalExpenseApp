import 'package:flutter/material.dart';
import './widgets/inputtransaction/Input.dart';
import './widgets/transactions/TransactionList.dart';
import './models/Transaction.dart';
import './widgets/chart.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

final List<Transaction> _transaction = [];
var switchVal = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Expenditure app",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'QuickSand',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
          ),
        ),
        home: MyHomePage());
  }
}

List<Transaction> get _recentransaction {
  return _transaction
      .where(
        (tx) => tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        ),
      )
      .toList();
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Input(_newTransaction),
          ));
        },
        context: context);
  }

  void _newTransaction(String title, double amount, DateTime selDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: selDate);
    setState(() {
      _transaction.add(newTx);
    });
  }

  void _deleteData(String id) {
    setState(() {
      _transaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("My Expense App"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            })
      ],
    );

    final percentHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return SafeArea(
          child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Show Chart",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Switch(
                        value: switchVal,
                        onChanged: (val) {
                          setState(() {
                            switchVal = val;
                          });
                        }),
                  ],
                ),
              if (isLandscape)
                switchVal
                    ? Container(
                        height: percentHeight * 0.7,
                        child: Card(
                          elevation: 10,
                          child: Chart(_recentransaction),
                        ),
                      )
                    : Container(
                        height: percentHeight * 0.7,
                        child: TransactionList(_transaction, _deleteData)),
              if (!isLandscape)
                Container(
                  height: percentHeight * 0.3,
                  child: Card(
                    elevation: 10,
                    child: Chart(_recentransaction),
                  ),
                ),
              if (!isLandscape)
                Container(
                    height: percentHeight * 0.7,
                    child: TransactionList(_transaction, _deleteData))
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            startAddNewTransaction(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
