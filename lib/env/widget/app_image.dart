import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app_bts/env/class/app_env.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imagePath,
    this.height,
    this.radius = 8,
    this.boxFit = BoxFit.cover,
  });

  final String imagePath;
  final double radius;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        fit: boxFit,
        height: height ?? MediaQuery.of(context).size.height,
        width: width,
        placeholder: (_, ___) => SizedBox(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade200,
            child: const ColoredBox(color: Colors.white),
          ),
        ),
        errorWidget: (_, __, ___) {
          return Image.network(
            AppAsset.imageNetworkPlaceholder,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
