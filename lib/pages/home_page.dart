import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/pages/newexpense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/expenselist.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: NewExpense(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        body: ExpenseList(
          expenses: value.expenses,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addExpense,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
