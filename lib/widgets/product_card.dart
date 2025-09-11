import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String imgPath;
  final String price;
  final VoidCallback? onAddToCart; // callback buat cart

  const ProductCard({
    super.key,
    required this.name,
    required this.imgPath,
    required this.price,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kamu klik $name")),
        );
      },
      child: Card(
        elevation: 6,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // gambar produk
                  Positioned.fill(
                    child: Image.asset(
                      imgPath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                      ),
                    ),
                  ),
                  // tombol add cart
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: onAddToCart,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4C53A5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // nama + harga
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF4C53A5),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Rp $price",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
