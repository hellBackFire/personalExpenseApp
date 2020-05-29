import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingamt;
  final double spendingper;

  ChartBar(this.label, this.spendingamt, this.spendingper);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          children: <Widget>[
            Container(
              child: FittedBox(
                child: Text("$spendingamt"),
              ),
              height: constraint.maxHeight*0.15,
            ),
            SizedBox(
              height: constraint.maxHeight*0.05,
            ),
            Container(
              height: constraint.maxHeight*0.60,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        color: Color.fromARGB(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingper,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight*0.05,
            ),
            Container(height: constraint.maxHeight*0.15, child: FittedBox(child: Text(label)))
          ],
        );
      },
    );
  }
}
