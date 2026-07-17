import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CommonCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ??
          const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          const Center(
            child: Icon(Icons.error_outline),
          ),
    );
  }
}
