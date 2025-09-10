import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, String>> _cartItems = [];

  // Getter untuk membaca data cart
  List<Map<String, String>> get cartItems => _cartItems;

  // Getter untuk total harga
  int get totalPrice {
    int total = 0;
    for (var item in _cartItems) {
      total += int.tryParse(item["price"] ?? "0") ?? 0;
    }
    return total;
  }

  // Tambah produk ke cart
  void addToCart(Map<String, String> product) {
    _cartItems.add(product);
    notifyListeners();
  }

  // Hapus produk berdasarkan index
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Hapus semua isi cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Cek apakah produk sudah ada di cart
  bool isInCart(String name) {
    return _cartItems.any((item) => item["name"] == name);
  }
}
