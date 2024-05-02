import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoriesTile extends StatelessWidget {
  const CategoriesTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description, required this.onTap,
  });

  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // responsive size
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1.5,
              spreadRadius: 2.5,
            ),
          ],
        ),
        child: Column(
          children: [
            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                height: size.height * 0.3,
                width: size.width,
              ),
            ),
            const SizedBox(height: 15),
            // title
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: "Roboto",
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            // description
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
