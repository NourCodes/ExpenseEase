import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

//This widget displays a visual chart representation of expenses
//grouped by specific categories. It utilizes the ExpenseCategoryGroup
//class to organize and calculate total expenses for each category.
class ChartPage extends StatefulWidget {
  // List of expenses to be visualized in the chart
  final List<Expense> expenses;

  const ChartPage({Key? key, required this.expenses}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  // Method to create a list of ExpenseCategoryGroup objects for specific categories.
  List<ExpenseCategoryGroup> get categoryGroups {
    return [
      ExpenseCategoryGroup.forCategory(Category.food, widget.expenses),
      ExpenseCategoryGroup.forCategory(Category.work, widget.expenses),
      ExpenseCategoryGroup.forCategory(Category.leisure, widget.expenses),
      ExpenseCategoryGroup.forCategory(Category.travel, widget.expenses),
    ];
  }

  // Method to calculate the maximum total expense across all groups
  double get maxTotal {
    double maxTotalExpense = 0;
    // Iterate through each group to find the maximum total expense
    for (final expense in categoryGroups) {
      if (expense.totalExpense > maxTotalExpense) {
        maxTotalExpense = expense.totalExpense;
      }
    }
    // Return the calculated maximum total expense.

    return maxTotalExpense;
  }

  // method to retrieve the Icon widget for a specific category.
  Widget getIconWidget(Category category) {
    Icon icon = getIcon(category);
    return icon;
  }

  Icon getIcon(Category category) {
    return Icon(ExpenseCategoryGroup.categoryIcon[category]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Colors.grey,
            Colors.black,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Iterate through each group
                for (final expense in categoryGroups)
                  ChartBar(
                    // If the total expense of a group is 0, set fill to 0, else
                    // set it to total expense of the specific group divided by the maxTotal of all groups.
                    fill: expense.totalExpense == 0
                        ? 0
                        : expense.totalExpense / maxTotal,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: categoryGroups
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: getIconWidget(e.category),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
