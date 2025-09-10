import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import 'pages/cart_provider.dart';

// Pages
import 'pages/login_page.dart';
import 'pages/account_page.dart';
import 'pages/cart_page.dart';
import 'pages/home_page.dart';
import 'pages/list_chat.dart';
import 'pages/detail_chat.dart'; // ChatScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // ✅ Provider untuk cart
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primary = Color(0xFF4C53A5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
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
      ),

      // Halaman awal
      initialRoute: '/login',

      // Routing utama
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/account': (context) => const AccountPage(),
        '/cart': (context) => const CartPage(),
        '/listchat': (context) => const ListChatPage(),
      },

      // Routing dengan argument (contoh: masuk ke detail chat)
      onGenerateRoute: (settings) {
        if (settings.name == '/detailchat') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ChatScreen(
                contactName: args['contactName'] ?? 'Unknown',
                avatarUrl: args['avatarUrl'] ?? '', // default kosong
              );
            },
          );
        }
        return null;
      },
    );
  }
}
