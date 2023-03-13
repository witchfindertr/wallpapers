import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyImages extends StatelessWidget {
  const MyImages({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: SizedBox(
        height: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(url, fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return SizedBox(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
