import 'package:flutter/material.dart';

/// Displays a product image from a URL.
/// WantAPI serves standard PNGs, so Image.network works directly.
class ApiImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final Widget Function(BuildContext, Object, StackTrace?) errorBuilder;

  const ApiImage({
    Key? key,
    required this.url,
    this.fit = BoxFit.cover,
    required this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      errorBuilder: errorBuilder,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}
