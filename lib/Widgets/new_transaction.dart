import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _currentDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _currentDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, _currentDate);
    Navigator.of(context).pop();
  }

  void _pickCurrentDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2050))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _currentDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (String _) {
                _submitData();
              },
            ),
            TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (String _) {
                  _submitData();
                }
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(_currentDate == null
                        ? 'No date Chosen!'
                        : DateFormat.yMMMEd()
                        .format(_currentDate ?? DateTime.now())),
                  ),
                  TextButton(
                      onPressed: _pickCurrentDate,
                      child: Text('Choose Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .primaryColor),
                          textAlign: TextAlign.right)),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                child: const Text(
                  "Add Transactions",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
