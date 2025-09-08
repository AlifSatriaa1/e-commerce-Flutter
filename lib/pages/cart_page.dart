import 'package:flutter/material.dart';
import '../widgets/cart_bottom_navbar.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double subtotal = 150.0;
    double discount = 20.0;
    double total = subtotal - discount;

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: const Center(
        child: Text(
          "Your cart items will appear here",
          style: TextStyle(fontSize: 16),
        ),
      ),
      bottomNavigationBar: CartBottomNavBar(
        subtotal: subtotal,
        discount: discount,
        total: total,
        onCheckout: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Proceeding to checkout...")),
          );
        },
      ),
    );
  }
}
