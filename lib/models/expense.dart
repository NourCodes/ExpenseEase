
enum Category { food, travel, leisure, work }

class Expense {
  final String name;
  final double amount;
  final DateTime date;
  final Category category;
  Expense(
      {required this.category,
        required this.amount,
        required this.name,
        required this.date});
}
