import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Input extends StatefulWidget {
  final Function tx;
  Input(this.tx);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final titlecontrol = TextEditingController(),
      pricecontrol = TextEditingController();
  DateTime _selDate;

  void submitdata() {
    var title = titlecontrol.text, price = pricecontrol.text;

    if (title.length <= 0 || price.length <= 0 || _selDate == null) return;
    widget.tx(title, double.parse(price), _selDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime.now())
        .then((t) {
      if (t == null) return;
      setState(() {
        _selDate = t;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "title"),
              onSubmitted: (_) {
                submitdata();
              },
              controller: titlecontrol,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(labelText: "price"),
              onSubmitted: (_) {
                submitdata();
              },
              controller: pricecontrol,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  _selDate == null
                      ? Text("No Date Chosen")
                      : Expanded(
                          child: Text(
                          "Date Choosen:${DateFormat.yMMMd().format(_selDate)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  FlatButton(
                    onPressed: () {
                      return _presentDatePicker();
                    },
                    child: Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: submitdata,
              child: Text("Add Transaction"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
