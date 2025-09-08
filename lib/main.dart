import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/account_pages.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF4C53A5);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/AccountPage': (context) => const MyAccountPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
