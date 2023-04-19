import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // final Function addNewTransaction;
  // final TextEditingController titleController;
  // final TextEditingController amountController;
  final List<Transaction> userTransaction;
  final Function addNewTransaction;
  const NewTransaction({
    super.key,
    required this.userTransaction,
    required this.addNewTransaction,
  });

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  var _isDatePicked = false;
  DateTime _datePicked = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void _submitData(BuildContext context) {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || !_isDatePicked) {
      return;
    }

    widget.addNewTransaction(
      title: enteredTitle,
      amount: enteredAmount,
      date: _datePicked,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }

      setState(() {
        _isDatePicked = true;
        _datePicked = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => _submitData(context),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(context),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(!_isDatePicked
                        ? "No date chosen"
                        : "Date picked: ${DateFormat.yMd().format(_datePicked)}"),
                  ),
                  TextButton(
                      onPressed: () => _presentDatePicker(context),
                      child: Text(
                        "Choose date",
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () => _submitData(context),
              child: Text(
                "Add Transaction",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
