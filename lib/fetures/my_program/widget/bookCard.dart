import 'package:flutter/material.dart';
import '../model/theatre_model.dart';

class BookCard extends StatelessWidget {
  final TheatreItem item;
  final double width;
  final double height;
  final VoidCallback onTap;

  const BookCard({
    super.key,
    required this.item,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: item.title, // Unique tag per item
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFF5A623), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF5A623).withAlpha(55),
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              item.imageAsset,
              key: ValueKey(item.imageAsset), // ⬅️ Key for image change
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: const Color(0xFF1A2A3A),
                child: const Center(
                  child: Icon(Icons.image, color: Colors.white24, size: 32),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}