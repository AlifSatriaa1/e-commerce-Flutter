import 'package:flutter/material.dart';

class CartItemSamples extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final void Function(int index) onIncrease;
  final void Function(int index) onDecrease;
  final void Function(int index) onDelete;

  const CartItemSamples({
    super.key,
    required this.items,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Filter item visible
    final visibleItems = items.asMap().entries.where((e) => e.value['visible'] == true).toList();

    if (visibleItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Text(
            'Your cart is empty 🛒',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: visibleItems.map((entry) {
        final index = entry.key;
        final item = entry.value as Map<String, dynamic>;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: 115,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            children: [
              // Gambar produk
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 90,
                  width: 90,
                  child: Image.asset(
                    'assets/images/carts/${item['id']}.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade200,
                            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                          );
                        },
                        errorBuilder: (context, err, st) {
                          return Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image_not_supported, color: Colors.white70),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // Info + kontrol
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'No name',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Rp ${(item['price'] as double).toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Delete
                        IconButton(
                          onPressed: () => onDelete(index),
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          tooltip: "Remove item",
                        ),
                        // Qty control
                        Row(
                          children: [
                            _qtyButton(
                              icon: Icons.remove_circle_outline,
                              onTap: () => onDecrease(index),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '${item['qty']}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            _qtyButton(
                              icon: Icons.add_circle_outline,
                              onTap: () => onIncrease(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22, color: const Color(0xFF4C53A5)),
      ),
    );
  }
}
