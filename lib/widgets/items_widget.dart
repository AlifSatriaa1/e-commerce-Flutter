import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  final List<Map<String, String>> products = const [
    {"name": "Outfit", "image": "assets/images/carts/1.png", "price": "\$55"},
    {"name": "Makanan", "image": "assets/images/carts/2.png", "price": "\$25"},
    {"name": "Skincare", "image": "assets/images/carts/3.png", "price": "\$40"},
    {"name": "Electronic", "image": "assets/images/carts/4.png", "price": "\$120"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 produk per baris
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72, // proporsi lebih seimbang
      ),
      itemBuilder: (context, i) {
        final product = products[i];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/itemDetail"),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar produk
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Image.asset(
                      product["image"]!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                // Nama + harga
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["name"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4C53A5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product["price"]!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4C53A5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Icon(Icons.favorite_border, color: Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
