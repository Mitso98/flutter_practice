import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final double amount;
  final String title;
  final DateTime date;
  final String id;
  final Function deleteTransaction;
  final Color bgColor;

  const TransactionItem({
    super.key,
    required this.amount,
    required this.title,
    required this.date,
    required this.id,
    required this.deleteTransaction,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
                child: Text(
              "\$$amount",
            )),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(
            date,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                label: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteTransaction(
                  id,
                ),
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => deleteTransaction(
                  id,
                ),
              ),
      ),
    );
  }
}
