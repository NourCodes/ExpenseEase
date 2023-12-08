import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'hive_DB.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expenses
  List<Expense> expenses = [];

  //reference box
  var box = Hive.box("expense");

  //load data to display
  final hDB = HiveDB();
  void loadData() {
    //if there is data get it
    if (hDB.readData().isNotEmpty) {
      expenses = hDB.readData();
    }
  }

  //get all expenses
  List<Expense> getExpenses() {
    return expenses;
  }

  //add expense
  void addExpense(Expense expense) {
    expenses.add(expense);
    hDB.saveData(expenses);
    notifyListeners();
  }

//remove expense
  void removeExpense(Expense expense) {
    expenses.remove(expense);
    hDB.saveData(expenses);
    notifyListeners();
  }
}
