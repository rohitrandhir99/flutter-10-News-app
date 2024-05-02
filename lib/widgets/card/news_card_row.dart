import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsCardRow extends StatelessWidget {
  const NewsCardRow({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.onTap,
    required this.title,
  });

  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 0.2,
              spreadRadius: 0.9,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 130,
                width: 130,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "Roboto",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
