import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './transactionCard.dart';

class Add_budget_dialog extends StatefulWidget {
  final Function(double) budget_to_add;
  Add_budget_dialog({required this.budget_to_add, Key? key}) : super(key: key);

  @override
  State<Add_budget_dialog> createState() => _Add_budget_dialogState();
}

class _Add_budget_dialogState extends State<Add_budget_dialog> {
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 200,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add Budget",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration:
                          const InputDecoration(hintText: "Budget in \$"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (amountController.text.isNotEmpty) {
                          widget.budget_to_add(
                              double.parse(amountController.text));
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add"),
                    )
                  ],
                ))));
  }
}

class budget_service extends ChangeNotifier {
  double _budget = 2000.0;
  double get budget => _budget;
  double balance = 0.0;

  List<transactionItem> _items = [];
  List<transactionItem> get items => _items;

  set budget(double value) {
    _budget = value;
    notifyListeners();
  }

  void addItem(transactionItem item) {
    _items.add(item);
    updateBalance(item);
    notifyListeners();
  }

  void updateBalance(transactionItem item) {
    if (item.isExpense) {
      balance += item.amount;
    } else {
      balance -= item.amount;
    }
  }
}
