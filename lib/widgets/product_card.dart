import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imgPath;
  final String price;

  const ProductCard({super.key, required this.name, required this.imgPath, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(imgPath, fit: BoxFit.cover, width: double.infinity, errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 48)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(price, style: const TextStyle(color: Colors.red)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
