import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late String label;
  late double totalSpendingAmount;
  late double percentOfSpendingAmount;

  ChartBar(this.label, this.totalSpendingAmount, this.percentOfSpendingAmount);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              height: 20,
              child: FittedBox(
                  child: Text(
                "\$${totalSpendingAmount}",
                style: TextStyle(fontSize: 15),
              ))),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: percentOfSpendingAmount,
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
            height: 4,
          ),
          Text(label),
        ],
      ),
    );
  }
}
