import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade300,
      title: Text(expense.name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("\$${expense.amount.toStringAsFixed(2)}"),
          Row(
            children: [
              Icon(categoryIcon[expense.category]),
              const SizedBox(
                width: 10,
              ),
              Text(DateFormat.yMd().format(expense.date).toString()),
            ],
          ),
        ],
      ),
    );
  }
}
