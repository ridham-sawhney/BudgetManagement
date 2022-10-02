import 'package:flutter/material.dart';

class transactionItem {
  String itemname;
  double amount;
  bool isExpense;
  transactionItem({required this.amount,required this.itemname,this.isExpense=true});
}


class transactionCard extends StatelessWidget {
  final transactionItem item;

  const transactionCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 25),
                  blurRadius: 50,
                )
              ],
            ),
            padding: const EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  item.itemname,
                  style: TextStyle(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  (!item.isExpense ? " + \$ " : " - \$ ") +
                      item.amount.toString(),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            )));
  }
}