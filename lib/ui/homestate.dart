import 'package:budget_tracking/services/themeservice.dart';
import 'package:budget_tracking/ui/transactionCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './profile.dart';
import './homepage.dart';
import 'budget_dialog.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<BottomNavigationBarItem> _bottomitems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  List<Widget> pages = [
    homepage(),
    profile(),
  ];
  ch(int i) {
    setState(() {
      _currentpageindex = i;
    });
  }

  int _currentpageindex = 0;
  @override
  Widget build(BuildContext context) {
    final themeservice = Provider.of<ThemeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget App"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              themeservice.darkTheme = !themeservice.darkTheme;
            },
            icon: Icon(themeservice.darkTheme ? Icons.sunny : Icons.dark_mode)),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Add_budget_dialog(budget_to_add: (budget) {
                        // setState(() {});
                        final budgetService =
                            Provider.of<budget_service>(context, listen: false);
                        budgetService.budget = budget;
                      });
                    });
              },
              icon: Icon(Icons.attach_money)),
        ],
      ),
      body: pages[_currentpageindex],
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: const Text(" "),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              ch(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(Icons.person),
            onTap: () {
              ch(1);
              Navigator.pop(context);
            },
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentpageindex,
          items: _bottomitems,
          onTap: (index) {
            setState(() {
              _currentpageindex = index;
            });
          }),
    );
  }
}
