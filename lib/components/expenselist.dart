import 'package:expense_app/components/tile.dart';
import 'package:flutter/cupertino.dart';

import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  const ExpenseList({Key? key, required this.expenses,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: expenses.length,
      itemBuilder: (context, index) =>
          ExpenseTile(
            expense: expenses[index],
          )
    );
  }
}