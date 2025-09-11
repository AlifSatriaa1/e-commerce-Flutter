import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int messageCount; // biar dinamis
  final VoidCallback? onMessageTap;

  const HomeAppBar({
    super.key,
    this.messageCount = 0,
    this.onMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.sort, size: 28, color: Color(0xFF4C53A5)),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Menu drawer clicked")),
          );
        },
      ),
      title: const Text(
        "E-commerce",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4C53A5),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: badges.Badge(
            showBadge: messageCount > 0,
            position: badges.BadgePosition.topEnd(top: -6, end: -6),
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(6),
            ),
            badgeContent: Text(
              messageCount.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: onMessageTap ??
                  () => Navigator.pushNamed(context, "/listchat"),
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.message,
                  size: 28,
                  color: Color(0xFF4C53A5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
