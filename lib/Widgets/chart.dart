import 'package:flutter/material.dart';
import './chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (weekDay.day == recentTransactions[i].date.day &&
            weekDay.month == recentTransactions[i].date.month &&
            weekDay.year == recentTransactions[i].date.year) {
          totalAmount = totalAmount + recentTransactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpendingOfWeek {
    return groupedTransactionValue.fold(0.0, (Sum, element) {
      return Sum + element["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValue.map((data) {
            return ChartBar(
                data["day"],
                data["amount"],
                totalSpendingOfWeek == 0.0
                    ? 0.0
                    : data["amount"] / totalSpendingOfWeek);
          }).toList(),
        ),
      ),
    );
  }
}
