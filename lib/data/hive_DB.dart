import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense.dart';

class HiveDB {
  //reference box
  var box = Hive.box("expense");

   //read data
  List<Expense> readData() {

    // list that will be returned
    List<Expense> allExpense = [];
    //if there is expenses return it else return empty list
        if(box.get("ALL_EXPENSES")!= null){
          List savedExpense = box.get("ALL_EXPENSES");

          for (int i = 0; i < savedExpense.length; i++) {
        //create a new expense object
        Expense newExpense = Expense(
          category: savedExpense[i][3],
          amount: savedExpense[i][2],
          name: savedExpense[i][0],
          date: savedExpense[i][1],
        );
        //add expense object to list that will be returned
        allExpense.add(newExpense);
      }
    }
    return allExpense;
  }

  //  save data
  void saveData(List<Expense> allExpenses) {
    List<List<dynamic>> allData = [];
    // [........,[ date, title, amount, category],..]
    for (var expense in allExpenses) {
      String title = expense.name;
      DateTime date = expense.date;
      double amount = expense.amount;
      String category = expense.category;

      allData.add([title, date, amount, category]);
    }
    //store in our database
    box.put("ALL_EXPENSES", allData);
  }
}
