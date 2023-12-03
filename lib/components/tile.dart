import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  String title;
  double amount;
  Icon iconD;
  String date;

  ExpenseTile({Key? key,required this.amount, required this.date, required this.title,required this.iconD}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("\$${amount.toString()}"),
          const SizedBox(
            width: 5,
          ),
          Row(
              children: [
                iconD,

                const SizedBox(
                  width: 8,
                ),
                Text(date.toString()),
              ]),
        ],
      ),
    );
  }
}
