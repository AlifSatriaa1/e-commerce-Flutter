import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, String>> _cartItems = [];
  int _discount = 0; 
  String? _voucherCode;

  // Getter cart
  List<Map<String, String>> get cartItems => _cartItems;

  // Getter subtotal
  int get subtotal {
    int total = 0;
    for (var item in _cartItems) {
      total += int.tryParse(item["price"] ?? "0") ?? 0;
    }
    return total;
  }

  // Getter discount
  int get discount => _discount;

  // Getter total (subtotal - discount, tidak boleh minus)
  int get totalPrice => (subtotal - discount).clamp(0, 999999999);

  // Getter voucher
  String? get voucherCode => _voucherCode;

  // Tambah produk
  void addToCart(Map<String, String> product) {
    _cartItems.add(product);
    notifyListeners();
  }

  // Hapus produk
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    _discount = 0;
    _voucherCode = null;
    notifyListeners();
  }

  // Terapkan diskon nominal langsung
  void applyDiscount(int amount) {
    _discount = amount;
    notifyListeners();
  }

  // Terapkan diskon pakai kode voucher
  void applyVoucher(String code) {
    _voucherCode = code;
    if (code == "DISKON10") {
      // 10% off
      _discount = (subtotal * 0.10).toInt();
    } else if (code == "DISKON50") {
      // 50rb off
      _discount = 50000;
    } else {
      // kode tidak valid
      _discount = 0;
      _voucherCode = null;
    }
    notifyListeners();
  }

  // Cek apakah produk sudah ada
  bool isInCart(String name) {
    return _cartItems.any((item) => item["name"] == name);
  }
}
