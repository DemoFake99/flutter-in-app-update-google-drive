import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_data_app/providers/product_data_provider.dart';
import 'package:user_data_app/providers/user_data_provider.dart';
import 'package:user_data_app/screens/main_page.dart';

import 'core/utils.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider<UserDataProvider>(
          create: (_) => UserDataProvider(),
        ),
        Provider<ProductDataProvider>(
          create: (_) => ProductDataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainPage(),
    );
  }
}
