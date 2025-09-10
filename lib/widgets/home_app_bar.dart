import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 30, color: Color(0xFF4C53A5)),
          const SizedBox(width: 20),
          const Text(
            "E-commerce",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C53A5),
            ),
          ),
          const Spacer(),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -10, end: -10),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
            ),
            badgeContent: const Text(
              "3",
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () {
                // ✅ Benerin ke route listchat
                Navigator.pushNamed(context, "/listchat");
              },
              child: const Icon(
                Icons.message,
                size: 32,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
