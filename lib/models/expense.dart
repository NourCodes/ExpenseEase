import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
enum Category { food, travel, leisure, work }

class Expense {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.category,
      required this.amount,
      required this.name,
      required this.date}): id = const Uuid().v4() ;
}

//create a map for icon and and category
Map<Category, IconData> categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};
