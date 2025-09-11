import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/pages/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cart = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty 🛒',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : Column(
              children: [
                // List Item di Cart
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final product = cart[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: Image.asset(
                            product["image"] ?? "",
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) => const Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                          title: Text(product["name"] ?? "Unknown"),
                          subtitle: Text("Rp ${product["price"] ?? "0"}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              cartProvider.removeFromCart(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${product['name']} removed from cart"),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bagian Total Harga + Voucher + Checkout
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Input Voucher
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Enter voucher code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        onSubmitted: (value) {
                          cartProvider.applyVoucher(value.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                cartProvider.voucherCode != null
                                    ? "Voucher applied: $value"
                                    : "Invalid voucher code",
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),

                      // Subtotal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Subtotal:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Rp ${cartProvider.subtotal}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),

                      // Diskon
                      if (cartProvider.discount > 0) ...[
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Discount:",
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                            Text(
                              "- Rp ${cartProvider.discount}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.red),
                            ),
                          ],
                        ),
                      ],

                      const Divider(height: 25, thickness: 1),

                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp ${cartProvider.totalPrice}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Tombol Checkout
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C53A5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          if (cart.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Cart is empty!"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Checkout successful!"),
                              ),
                            );
                            cartProvider.clearCart();
                          }
                        },
                        child: const Text(
                          "Checkout",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
