import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, size: 28, color: Color(0xFF4C53A5)),
            ),
            const SizedBox(width: 16),
            const Text(
              'Cart',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
            const Spacer(),
            const Icon(Icons.shopping_cart_outlined, size: 28, color: Color(0xFF4C53A5)),
            const SizedBox(width: 12),
            // tiga titik menu (contoh)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Color(0xFF4C53A5)),
            )
          ],
        ),
      ),
    );
  }
}
