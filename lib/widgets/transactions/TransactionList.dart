import 'package:flutter/material.dart';
import './TransactionCard.dart';
import '../../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;
  final Function delData;
  TransactionList(this._transaction, this.delData);

  @override
  Widget build(BuildContext context) {

    
    return Container(
        height: 300,
        child: _transaction.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraint) {
                  return Column(
                    children: <Widget>[
                      Text(
                        "No Transactions",
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(
                        height:constraint.maxHeight*0.2,
                      ),
                      Image.asset(
                        'image/waiting.png',
                        height: constraint.maxHeight*0.6,
                      ),
                    ],
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (ctx, index) =>
                    TransactionCard(_transaction[index], delData),
                itemCount: _transaction.length,
              ));
  }
}
