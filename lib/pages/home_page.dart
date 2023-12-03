import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void addExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a new Expense"),
        content: Column(
          children: [
            TextField(
              controller: _controller,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
            )
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: save,
            child: const Text("Save"),
          ),
          ElevatedButton(
            onPressed: cancel,
            child: const Text("cancel"),
          ),
        ],
      ),
    );
  }

  void save() {
    Expense newExpense = Expense(
      category: Category.work,
      amount: double.parse(_amountController.text),
      name: _controller.text,
      date: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    Navigator.of(context).pop();
    clearControllers();
  }
  void cancel() {
    Navigator.of(context).pop();
    clearControllers();
  }

  void clearControllers() {
    _controller.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        body: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: value.expenses.length,
            itemBuilder: (context, index) => ExpenseTile(
                amount: value.getExpenses()[index].amount,
                date: DateFormat.yMd().format(value.getExpenses()[index].date),
                title: value.getExpenses()[index].name,
                iconD: Icon(
                    value.categoryIcon[value.getExpenses()[index].category]),),
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
