import 'package:expense_app/components/tile.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;
  const ExpenseList({
    Key? key,
    required this.expenses,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Colors.red.shade900,
          child: const Center(
            child: Icon(
              Icons.delete,
            ),
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onRemove(expenses[index]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: ExpenseTile(
            expense: expenses[index],
          ),
        ),
      ),
    );
  }
}
