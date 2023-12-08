import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Category { food, travel, leisure, work }

class Expense {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final String category;

  Expense(
      {required this.category,
      required this.amount,
      required this.name,
      required this.date})
      : id = const Uuid().v4();
}

//this class is responsible for grouping expenses based on categories and calculating total expenses for each category
class ExpenseCategoryGroup {
  final Category category;
  final List<Expense> expenses;
  ExpenseCategoryGroup({required this.category, required this.expenses});

  ExpenseCategoryGroup.forCategory(this.category, List<Expense> allExpenses)
      : expenses = allExpenses
            .where((element) => element.category == category.name)
            .toList();

// Method to calculate the total expenses
  double get totalExpense {
    double sum = 0;
    // Iterate through each expense
    for (final expense in expenses) {
      // Add the amount of each expense to the total sum
      sum += expense.amount;
    }
    // Return the calculated total sum of expenses that belong to a specific category
    return sum;
  }

//create a map for icon and and category
  static const Map<Category, IconData> categoryIcon = {
    Category.food: Icons.lunch_dining,
    Category.travel: Icons.flight_takeoff,
    Category.leisure: Icons.movie,
    Category.work: Icons.work,
  };
}
