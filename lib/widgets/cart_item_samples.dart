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
    // Tampilkan hanya item yang visible == true
    final visibleItems = items.asMap().entries.where((e) => e.value['visible'] == true).toList();

    if (visibleItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(child: Text('Your cart is empty')),
      );
    }

    return Column(
      children: visibleItems.map((entry) {
        final index = entry.key; // index asli di daftar items
        final item = entry.value as Map<String, dynamic>;

        return Container(
          height: 110,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Row(
            children: [
              // Gambar produk: pakai AssetImage jika ada, fallback NetworkImage
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 86,
                      width: 86,
                      child: Image.asset(
                        // gunakan id untuk menamai file png (mis: 1.png, 2.png)
                        'assets/images/carts/${item['id']}.png',
                        fit: BoxFit.cover,
                        // jika asset tidak ditemukan, tampilkan network image dari item['image']
                        errorBuilder: (context, error, stackTrace) {
                          // fallback ke network image (placeholder)
                          return Image.network(
                            item['image'],
                            fit: BoxFit.cover,
                            width: 86,
                            height: 86,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                width: 86,
                                height: 86,
                                color: Colors.grey.shade200,
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              );
                            },
                            errorBuilder: (context, err, st) {
                              // jika network juga gagal, tampilkan placeholder solid color
                              return Container(
                                width: 86,
                                height: 86,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Badge/tanda di pojok gambar
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4C53A5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_offer, size: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),

              // Info dan aksi
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? 'No name',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text('\$${(item['price'] as double).toStringAsFixed(2)}'),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Tombol delete kecil
                        IconButton(
                          onPressed: () => onDelete(index),
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        ),
                        // Quantity controls
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => onDecrease(index),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text('${item['qty']}', style: const TextStyle(fontSize: 16)),
                            IconButton(
                              onPressed: () => onIncrease(index),
                              icon: const Icon(Icons.add_circle_outline),
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
}
