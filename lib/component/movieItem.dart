import 'package:flutter/material.dart';

class movieitme extends StatefulWidget {
  String ImageUrl;
  movieitme({super.key, required this.ImageUrl});

  @override
  State<movieitme> createState() => _movieitmeState();
}

class _movieitmeState extends State<movieitme> {
  bool _isLoading = true;

  _fechData() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tapped on image");
      },
      child: Image.asset("images/image1.jpg", width: 300, height: 300, fit: BoxFit.contain),
    );
  }
}
