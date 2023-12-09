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
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.white24,
        ),
      ),
      tileColor: Colors.grey.shade400,
      title: Text(expense.name, style: const TextStyle(color: Colors.black)),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$${expense.amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            DateFormat.yMd().format(expense.date).toString(),
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
