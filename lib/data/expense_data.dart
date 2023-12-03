import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpenseData extends ChangeNotifier{


  //list of all expenses
  List<Expense> expenses = [];

  //get all expenses
  List<Expense> getExpenses(){
    return expenses;
  }

  //add expense
void addExpense(Expense expense){
  expenses.add(expense);
  notifyListeners();
}
//remove expense
void removeExpense(Expense expense){
  expenses.remove(expense);
  notifyListeners();
}
//create a map for icon and and category
 Map<Category, IconData> categoryIcon = {
  Category.food : Icons.lunch_dining,
   Category.travel: Icons.flight_takeoff,
   Category.leisure: Icons.movie,
   Category.work: Icons.work,
};

}