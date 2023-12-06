import 'package:expense_app/chart/chart_page.dart';
import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/pages/newExpense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/expenseList.dart';
import '../models/expense.dart';

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
        child: const NewExpense(),
      ),
    );
  }

  void removeExpense(Expense expense) {
    int index = Provider.of<ExpenseData>(context, listen: false)
        .expenses
        .indexOf(expense);
    Provider.of<ExpenseData>(context, listen: false).removeExpense(expense);

    setState(() {});
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          onPressed: () {
            setState(() {
              Provider.of<ExpenseData>(context, listen: false)
                  .expenses
                  .insert(index, expense);
            });
          },
          label: "Undo",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expense Found"),
    );

    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        if (value.expenses.isNotEmpty) {
          mainContent = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChartPage(expenses: value.expenses),
              Expanded(
                child: ExpenseList(
                  onRemove: removeExpense,
                  expenses: value.expenses,
                ),
              ),
            ],
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Expense Tracker"),
          ),
          body:mainContent,
          floatingActionButton: FloatingActionButton(
            onPressed: addExpense,
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}
