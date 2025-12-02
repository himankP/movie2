import 'package:flutter/material.dart';

class movieitme extends StatelessWidget {
  String ImageUrl;
  movieitme({super.key, required this.ImageUrl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tapped on image");
      },
      child: Image.asset(ImageUrl, width: 300, height: 300, fit: BoxFit.contain),
    );
  }
}
