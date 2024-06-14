import 'package:flutter/material.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/string_resources.dart';

// ignore: must_be_immutable
class CommonNetworkImage extends StatelessWidget {
  String imagePath;
  Widget? childWidget;
  CommonNetworkImage({super.key, required this.imagePath, this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: childWidget ??
              CircularProgressIndicator(
                color: ColorsResources.AMBER_ACCENT,
              ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Text(StringResources.ERROR_MESSAGE));
      },
    );
  }
}
