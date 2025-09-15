import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/pages/cart_provider.dart';

const shopeeColor = Color(0xFFFF5722);

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      padding: const EdgeInsets.only(top: 18, left: 12, right: 12, bottom: 10),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Tombol Back dengan ripple
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(Icons.arrow_back, size: 28, color: shopeeColor),
              ),
            ),

            const SizedBox(width: 16),

            // Judul Cart
            const Text(
              'My Cart',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: shopeeColor,
              ),
            ),

            const Spacer(),

            // Ikon keranjang dengan badge jumlah item
            Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined,
                    size: 28, color: shopeeColor),
                if (cartProvider.cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${cartProvider.cartItems.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Popup Menu
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: shopeeColor),
              onSelected: (value) {
                if (value == 'clear') {
                  if (cartProvider.cartItems.isNotEmpty) {
                    cartProvider.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Cart cleared"),
                        backgroundColor: shopeeColor,
                      ),
                    );
                  }
                } else if (value == 'wishlist') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Go to Wishlist (dummy)"),
                      backgroundColor: shopeeColor,
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Clear Cart",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'wishlist',
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.pink),
                      SizedBox(width: 8),
                      Text(
                        "Go to Wishlist",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
