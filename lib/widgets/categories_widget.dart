import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<String> categories = [
    "Outfit",
    "Makanan",
    "Skincare",
    "Electronic",
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, i) {
          final isSelected = i == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = i);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Selected: ${categories[i]}"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4C53A5) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/banner/${i + 1}.png",
                    width: 38,
                    height: 38,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    categories[i],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF4C53A5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
