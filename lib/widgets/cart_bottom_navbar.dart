import 'package:flutter/material.dart';

class CartBottomNavBar extends StatelessWidget {
  final double subtotal;
  final double discount;
  final double total;
  final VoidCallback onCheckout;

  const CartBottomNavBar({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subtotal & Discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subtotal:",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                Text(
                  "Rp ${subtotal.toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            if (discount > 0) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount:",
                    style: TextStyle(fontSize: 15, color: Colors.redAccent),
                  ),
                  Text(
                    "- Rp ${discount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 8),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp ${total.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Checkout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C53A5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 4,
                ),
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                label: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 