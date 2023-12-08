import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/expense_data.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? selectedDate;
  Category selectedC = Category.work;

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void save() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedC.name.isNotEmpty) {
      Expense newExpense = Expense(
        category: selectedC.name,
        amount: double.parse(_amountController.text),
        name: _controller.text,
        date: DateTime.now(),
      );
      Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
      Navigator.pop(context, selectedC);
      clearControllers();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please recheck your data and make sure you filled it all and the data is valid"),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void cancel() {
    Navigator.pop(context, selectedC);
    clearControllers();
  }

  void clearControllers() {
    _controller.clear();
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 15),
        child: Column(
          children: [

            const Text(
              "Add a new Expense",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill the data";
                }
                return null;
              },
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                label: Text("Title"),
              ),
              controller: _controller,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please fill the data";
                      } else if (double.parse(value) <= 0) {
                        return "Amount must be greater than 0";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        prefixText: "\$ ",
                        label: Text("Amount")),
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(selectedDate == null
                          ? "Not Selected"
                          : DateFormat.yMd().format(selectedDate!)),
                      IconButton(
                          onPressed: pickDate,
                          icon: const Icon(Icons.calendar_month)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: selectedC,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedC = value;
                      });
                    }
                  },
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: save,
                      child: const Text("Save"),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: cancel,
                      child: const Text("cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
