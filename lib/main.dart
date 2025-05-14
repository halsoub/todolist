import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/date.dart';
import 'package:todolist/provider/task.dart';
import 'package:todolist/provider/theme.dart';
import 'package:todolist/provider/time.dart';
import 'package:todolist/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  // await themeProvider.loadThemePref();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => DatePickerProvider()),
        ChangeNotifierProvider(create: (context) => TimePickerProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,

          debugShowCheckedModeBanner: false,

          home: HomeScreen(),
        );
      },
    );
  }
}
