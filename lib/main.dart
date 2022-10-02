import 'package:budget_tracking/services/themeservice.dart';
import 'package:budget_tracking/ui/budget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ui/homestate.dart';

// void main() {
//   runApp(MaterialApp(
//     home: home(),
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//         primarySwatch: Colors.red,
//         colorScheme: ColorScheme.fromSeed(
//             brightness: Brightness.dark, seedColor: Colors.indigo)),
//   ));
// }

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) =>budget_service()),
    ], 
        child: Builder(
          builder: (BuildContext context) {
            final themeService = Provider.of<ThemeService>(context);
            
            return MaterialApp(
              title:"Budget Track",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: themeService.darkTheme
                  ?Brightness.dark
                  :Brightness.light,
                  seedColor: Colors.indigo)
              ),
              home:home()
            );
          },
        )
        );
  }
}
