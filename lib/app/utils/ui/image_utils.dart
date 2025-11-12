import 'package:flutter/material.dart';

Widget networkImage(String url, {BoxFit fit = BoxFit.contain, double? height}) {
  return Image.network(
    url,
    fit: fit,
    height: height,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.broken_image, size: 50);
    },
  );
}
