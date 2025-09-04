import 'package:flutter/material.dart';
import '../widgets/cart_appbar.dart';
import '../widgets/cart_item_samples.dart';
import '../widgets/cart_bottom_navbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // sample data (id, name, price, qty, imageUrl, visible)
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Classic Sneakers",
      "price": 55.0,
      "qty": 1,
      // placeholder web image (ganti nanti ke AssetImage)
      "image":
          "https://picsum.photos/seed/p1/200/200", 
      "visible": true
    },
    {
      "id": 2,
      "name": "Denim Jacket",
      "price": 79.0,
      "qty": 2,
      "image": "https://picsum.photos/seed/p2/200/200",
      "visible": true
    },
    {
      "id": 3,
      "name": "Leather Bag",
      "price": 120.0,
      "qty": 1,
      "image": "https://picsum.photos/seed/p3/200/200",
      "visible": true
    },
    {
      "id": 4,
      "name": "Casual Shirt",
      "price": 29.0,
      "qty": 3,
      "image": "https://picsum.photos/seed/p4/200/200",
      "visible": true
    },
  ];

  final TextEditingController _couponController = TextEditingController();
  String appliedCoupon = '';
  double discount = 0.0;

  double get subtotal {
    double s = 0;
    for (var it in cartItems) {
      if (it['visible'] == true) {
        s += (it['price'] as double) * (it['qty'] as int);
      }
    }
    return s;
  }

  double get total => (subtotal - discount).clamp(0.0, double.infinity);

  void increaseQty(int index) {
    setState(() {
      cartItems[index]['qty'] = cartItems[index]['qty'] + 1;
    });
  }

  void decreaseQty(int index) {
    setState(() {
      if (cartItems[index]['qty'] > 1) {
        cartItems[index]['qty'] = cartItems[index]['qty'] - 1;
      }
    });
  }

  void hideItem(int index) {
    setState(() {
      cartItems[index]['visible'] = false; // hide (not delete permanent)
    });
  }

  void applyCoupon() {
    final code = _couponController.text.trim();
    setState(() {
      if (code == 'DISKON10') {
        discount = subtotal * 0.1; // 10% discount
        appliedCoupon = 'DISKON10';
      } else if (code == 'MIN50') {
        // example fixed discount
        discount = subtotal >= 50 ? 5.0 : 0.0;
        appliedCoupon = discount > 0 ? 'MIN50' : 'Invalid';
      } else {
        discount = 0.0;
        appliedCoupon = 'Invalid';
      }
    });
  }

  void checkout() {
    // contoh aksi checkout: hanya tampilkan snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Checkout berhasil. Total: \$${total.toStringAsFixed(2)}")),
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar khusus Cart (widget terpisah)
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CartAppBar(),
      ),

      // Body: ListView agar bisa di-scroll
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          // Kontainer utama dengan dekorasi atas membulat
          Container(
            // tinggi bersifat adaptif; cukup beri padding top
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFFF5F7FF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: [
                // daftar item cart (widget terpisah)
                CartItemSamples(
                  items: cartItems,
                  onIncrease: increaseQty,
                  onDecrease: decreaseQty,
                  onDelete: hideItem,
                ),

                const SizedBox(height: 12),

                // Add Coupon Code area (sesuai modul)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _couponController,
                          decoration: const InputDecoration(
                            hintText: 'Add Coupon Code',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: applyCoupon,
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ),

                if (appliedCoupon.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      appliedCoupon == 'Invalid' ? 'Coupon not valid' : 'Coupon applied: $appliedCoupon',
                      style: TextStyle(
                        color: appliedCoupon == 'Invalid' ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      // bottom nav khusus cart
      bottomNavigationBar: CartBottomNavBar(
        subtotal: subtotal,
        discount: discount,
        total: total,
        onCheckout: checkout,
      ),
    );
  }
}
