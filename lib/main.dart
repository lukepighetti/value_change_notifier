import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:value_change_notifier/change_notifier.dart';
import 'package:value_change_notifier/value_notifier.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(
        create: (_) => ValueNotifierStateClass(),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierStateClass(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValueNotifier vs ChangeNotifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'changeNotifier',
      routes: {
        'changeNotifier': (context) => ChangeNotifierScreen(),
        'valueNotifier': (context) => ValueNotifierScreen(),
      },
    );
  }
}
