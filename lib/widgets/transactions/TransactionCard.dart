import "package:flutter/material.dart";
import "../../models/Transaction.dart";
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function delData;
  TransactionCard(this.tx, this.delData);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 40,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FittedBox(
              child: Text(
                '₹${tx.amount.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
        ),
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMd("en_US").format(tx.date),
        ),
        trailing: MediaQuery.of(context).size.width > 412
            ? FlatButton.icon(
              color: Colors.red,
                onPressed: () {
                  delData(tx.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                
                color: Theme.of(context).errorColor,
                onPressed: () {
                  delData(tx.id);
                }),
      ),
    );
  }
}

// Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               style: BorderStyle.solid,
//                               color: Theme.of(context).primaryColor,
//                               width: 2),
//                         ),
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           '₹${tx.amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               color: Theme.of(context).primaryColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             tx.title,
//                             style: Theme.of(context).textTheme.title,
//                           ),
//                           Text(
//                             DateFormat.yMMMMd("en_US").format(tx.date),
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );
