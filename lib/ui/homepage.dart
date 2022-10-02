import 'dart:typed_data';

import 'package:budget_tracking/ui/budget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import './transactionCard.dart';
import './budget_dialog.dart';



import 'package:percent_indicator/circular_percent_indicator.dart';



// class homepage extends StatefulWidget {
//   const homepage({Key? key}) : super(key: key);

//   @override
//   State<homepage> createState() => _homepageState();
// }

// class _homepageState extends State<homepage> {
//   //List<transactionItem> items = [];
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final budgetService = Provider.of<budget_service>(context);
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AddTransaction(
//                     itemtoadd: (transactionItem) {
//                       final budgetService =
//                           Provider.of<budget_service>(context, listen: false);
//                       budgetService.addItem(transactionItem);
//                     },
//                   );
//                 });
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: SizedBox(
//                   // width:screenSize.size,
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: Consumer<budget_service>(
//                         builder: ((context, value, child) {
//                       return CircularPercentIndicator(
//                         radius: screenSize.width / 2,
//                         lineWidth: 10,
//                         percent: 0.5 / value.budget,
//                         backgroundColor: Colors.white,
//                         center: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               "\$0",
//                               style: TextStyle(
//                                   fontSize: 48, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "Balance",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             Text("Budget \$" + budgetService.budget.toString(),
//                                 style: TextStyle(
//                                     fontSize: 10, fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         progressColor: Theme.of(context).colorScheme.primary,
//                       );
//                     })),
//                   ),
//                   const SizedBox(
//                     height: 35,
//                   ),
//                   const Text(
//                     "Items",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),

//                   //  final list1 = [1, 2, 3];
//                   //   final list2 = [...list1, 4, 5, 6]
//                   // list -> [1, 2, 3, 4, 5, 6]

//                   ...List.generate(
//                       items.length,
//                       (index) => transactionCard(
//                             item: items[index],
//                           )),
//                 ],
//               ))),
//         ));
//   }
// }

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
   // final budgetService = Provider.of<budget_service>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddTransaction(
                    itemtoadd: (transactionItem) {
                      final budgetService =
                          Provider.of<budget_service>(context, listen: false);
                      budgetService.addItem(transactionItem);
                    },
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                  // width:screenSize.size,
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Consumer<budget_service>(
                        builder: ((context, value, child) {
                      return CircularPercentIndicator(
                        radius: screenSize.width / 2,
                        lineWidth: 10.0,
                        percent: value.balance / value.budget,
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "\$" +value.balance.toString().split(".")[0],
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                           const Text(
                              "Balance",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text("Budget \$" + value.budget.toString(),
                                style:const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    })),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    "Items",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //  final list1 = [1, 2, 3];
                  //   final list2 = [...list1, 4, 5, 6]
                  // list -> [1, 2, 3, 4, 5, 6]

                  //  ... List.generate(
                  //       items.length,
                  //       (index) => transactionCard(
                  //             item: items[index],
                  //           )),
                 
    
Consumer<budget_service>(
    builder: ((context, value, child) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: value.items.length,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return transactionCard(
              item: value.items[index],
            );
          });

      //  List.generate(
      // items.length,
      // (index) => TransactionCard(
      //       item: items[index],
      //     )),
    }),
  )



                ],
              ))),
        ));
  }
}

//Class

class AddTransaction extends StatefulWidget {
  final Function(transactionItem) itemtoadd;
  AddTransaction({required this.itemtoadd, Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController itemnamecontroller = TextEditingController();
  final TextEditingController amountcontroller = TextEditingController();
  bool isExpensecontroller = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 300,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Text(
                      "Add Expense",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: itemnamecontroller,
                      decoration: InputDecoration(hintText: "Name of Expense"),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      controller: amountcontroller,
                      decoration: InputDecoration(hintText: "Amount in \$"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("is Expense?"),
                        Switch.adaptive(
                            value: isExpensecontroller,
                            onChanged: (b) {
                              setState(() {
                                isExpensecontroller = b;
                              });
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (itemnamecontroller.text.isNotEmpty &&
                              amountcontroller.text.isNotEmpty) {
                            widget.itemtoadd(transactionItem(
                              amount: double.parse(amountcontroller.text),
                              itemname: itemnamecontroller.text,
                              isExpense: isExpensecontroller,
                            ));
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Add"))
                  ],
                ))));
  }
}
