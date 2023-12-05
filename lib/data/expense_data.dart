import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseData extends ChangeNotifier {
  //list of all expenses
  List<Expense> expenses = [];

  //get all expenses
  List<Expense> getExpenses() {
    return expenses;
  }

  //add expense
  void addExpense(Expense expense) {
    expenses.add(expense);
    notifyListeners();
  }

//remove expense
  void removeExpense(Expense expense) {
    expenses.remove(expense);
    notifyListeners();
  }

  }


