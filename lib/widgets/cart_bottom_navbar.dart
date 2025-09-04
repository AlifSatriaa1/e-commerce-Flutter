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
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, -3))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(fontSize: 16, color: Colors.black54)),
              Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tampilkan discount (jika ada)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (discount > 0)
                    Text('Discount: -\$${discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
                  Text('Pay: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),

              ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C53A5),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Checkout', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
