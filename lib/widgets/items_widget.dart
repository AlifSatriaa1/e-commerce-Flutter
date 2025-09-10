  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:e_commerce/pages/cart_provider.dart';

  class ItemsWidget extends StatelessWidget {
    const ItemsWidget({super.key});

    final List<Map<String, String>> products = const [
      {"name": "Outfit", "image": "assets/images/carts/1.png", "price": "55000"},
      {"name": "Makanan", "image": "assets/images/carts/2.png", "price": "25000"},
      {"name": "Skincare", "image": "assets/images/carts/3.png", "price": "40000"},
      {"name": "Electronic", "image": "assets/images/carts/4.png", "price": "120000"},
    ];

    @override
    Widget build(BuildContext context) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, i) {
          final product = products[i];
          return Container(
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
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Image.asset(
                      product["image"]!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                            "Rp ${product["price"]}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4C53A5),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart,
                                color: Color(0xFF4C53A5)),
                            onPressed: () {
                              context.read<CartProvider>().addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${product['name']} added to cart"),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
