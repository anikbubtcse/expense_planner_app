import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'There are no Transactions!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    "assets/images/question.png",
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (BuildContext ctx, int index) {
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.all(6),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      child: FittedBox(
                          child: Text("\$${transactions[index].amount}")),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "QuickSand",
                          fontSize: 20),
                    ),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () =>
                          deleteTransaction(transactions[index].id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
