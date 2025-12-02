import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie/Models/movieItem.dart';
import 'package:movie/component/movieItem.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isLoading = true;
  Movie? movieData;
  _fetchdata(String? movie) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final url = Uri.parse('https://www.omdbapi.com/?i=tt3896198&apikey=$apiKey');
      final response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode != 200) {
        return;
      }
      final data = json.decode(response.body);

      final movie = Movie.fromJson(data);
      print(movie);
      print(data);
      setState(() {
        _isLoading = false;
        movieData = movie;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    print("Homescreen");
    _fetchdata("movie");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: SingleChildScrollView(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Homescreen',
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.search, color: Color(0xFFFFFFFF), size: 50),
                          ],
                        ),

                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(movieData!.poster, width: 300, height: 300, fit: BoxFit.cover),
                              ),
                              Positioned(
                                bottom: 50,
                                left: 50,
                                child: Text(
                                  'Movie Title',

                                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 50,
                                child: Text('1994', style: TextStyle(color: Colors.white, fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "popular",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              movieitme(ImageUrl: 'images/image1.jpg'),
                              movieitme(ImageUrl: 'images/image1.jpg'),
                              movieitme(ImageUrl: 'images/image1.jpg'),
                              movieitme(ImageUrl: 'images/image1.jpg'),
                              movieitme(ImageUrl: 'images/image1.jpg'),
                              movieitme(ImageUrl: 'images/image1.jpg'),
                            ],
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
