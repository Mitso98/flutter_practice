import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final Function deleteTransaction;
  final List<Transaction> userTransaction;
  const TransactionList({
    super.key,
    required this.userTransaction,
    required this.deleteTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return userTransaction.isEmpty
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
              itemCount: userTransaction.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                            child: Text(
                          "\$${userTransaction[index].amount}",
                        )),
                      ),
                    ),
                    title: Text(
                      userTransaction[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        userTransaction[index].date,
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
                              userTransaction[index].id,
                            ),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => deleteTransaction(
                              userTransaction[index].id,
                            ),
                          ),
                  ),
                );
              },
            );
    });
  }
}
