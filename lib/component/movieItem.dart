import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie/Models/movieItem.dart';

class movieitme extends StatefulWidget {
  String ImageUrl;
  String id;
  movieitme({super.key, required this.ImageUrl, required this.id});

  @override
  State<movieitme> createState() => _movieitmeState();
}

class _movieitmeState extends State<movieitme> {
  bool _isLoading = true;
  Movie? movieData;
  @override
  void initState() {
    // TODO: implement initState
    _fechData();

    print(widget.id);
  }

  _fechData() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final url = Uri.parse('https://www.omdbapi.com/?i=${widget.id}&apikey=$apiKey');
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode != 200) {
        return;
      }
      final data = json.decode(response.body);
      print(data);

      final movie = Movie.fromJson(data);
      print(movie);
      print(movie);

      setState(() {
        _isLoading = false;
        movieData = movie;
      });

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
      child:
          _isLoading
              ? SizedBox(width: 300, height: 300, child: Center(child: const CircularProgressIndicator()))
              : Image.network(movieData!.poster, width: 300, height: 300, fit: BoxFit.contain),
    );
  }
}
