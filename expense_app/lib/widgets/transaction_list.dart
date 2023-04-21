import 'dart:math';

import 'package:expense_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';


import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final Function deleteTransaction;
  final List<Transaction> userTransaction;
  const TransactionList({
    super.key,
    required this.userTransaction,
    required this.deleteTransaction,
  });

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return widget.userTransaction.isEmpty
          ? Column(
              children: [
                const Text("No transaction added yet!"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: widget.userTransaction.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  amount: widget.userTransaction[index].amount,
                  title: widget.userTransaction[index].title,
                  date: widget.userTransaction[index].date,
                  id: widget.userTransaction[index].id,
                  deleteTransaction: widget.deleteTransaction,
                  bgColor: _colors[Random().nextInt(_colors.length)],
                );
              },
            );
    });
  }
}
