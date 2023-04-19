import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  // last 7 days transactions
  final List<Transaction> recentTrans;

  const Chart({super.key, required this.recentTrans});

  List<Map<String, Object>> get groupedTransValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          totalSum += recentTrans[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransValues.fold(0.0, (sum, item) {
      return sum + (item["amount"] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: (data["day"] as String),
                    spendingAmount: (data["amount"] as double),
                    spendingPctOfTotal: totalSpending == 0.0
                        ? 0.0
                        : (data["amount"] as double) / totalSpending),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
