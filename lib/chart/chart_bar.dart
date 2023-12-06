import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChartBar  extends StatelessWidget {
  final double fill;
   ChartBar ({Key? key,required this.fill}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, top: 5),
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
           borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            color: Colors.white,
          ),
          child: FractionallySizedBox(
            heightFactor: fill,
            child: Container(
              width: 50,
            ),
          ),
        ),
      ),
    );
  }
}
