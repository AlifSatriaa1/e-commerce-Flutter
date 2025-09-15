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
        ChangeNotifierProvider(create: (_) => CartProvider()), // Provider cart
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 🎨 Warna utama Shopee
  static const Color shopeeOrange = Color(0xFFF94D00);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce_Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: shopeeOrange),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: const AppBarTheme(
          backgroundColor: shopeeOrange,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: shopeeOrange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: shopeeOrange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: const TextStyle(color: Colors.black87),
          prefixIconColor: shopeeOrange,
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

      // Routing dengan argument (contoh: detail chat)
      onGenerateRoute: (settings) {
        if (settings.name == '/detailchat') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ChatScreen(
                contactName: args['contactName'] ?? 'Unknown',
                avatarUrl: args['avatarUrl'] ?? '',
              );
            },
          );
        }
        return null;
      },
    );
  }
}
