import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text("Popüler Filmler")),
        body: const MovieList(),
      ),
    );
  }
}

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final dio = Dio();
  List movies = [];

  Widget _buildStars(num? voteAverage) {
    // TMDB vote_average is 0–10. Convert to 0–5 scale.
    final rating5 = ((voteAverage ?? 0).toDouble() / 2.0).clamp(0.0, 5.0);
    final full = rating5.floor();
    final hasHalf = (rating5 - full) >= 0.5;
    final empty = 5 - full - (hasHalf ? 1 : 0);

    final icons = <Widget>[];
    for (var i = 0; i < full; i++) {
      icons.add(const Icon(Icons.star, size: 20, color: Colors.amber));
    }
    if (hasHalf) {
      icons.add(const Icon(Icons.star_half, size: 20, color: Colors.amber));
    }
    for (var i = 0; i < empty; i++) {
      icons.add(const Icon(Icons.star_border, size: 20, color: Colors.amber));
    }

    return Row(mainAxisSize: MainAxisSize.min, children: icons);
  }

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final token = const String.fromEnvironment(
      '456cd613a45584e4334e555517765a7d',
    );
    final url =
        'https://api.themoviedb.org/3/movie/popular?language=tr-TR&page=1';

    try {
      final res = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${"eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NTZjZDYxM2E0NTU4NGU0MzM0ZTU1NTUxNzc2NWE3ZCIsIm5iZiI6MTc1ODIwMTczMS42NDQsInN1YiI6IjY4Y2MwNzgzNjU0ODcxMWY4ZDE0OTFmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ARqziTH-PeP3NP1iGVHJf__B-X0L1R9NPXsMUdcM4zI"}',
            'Accept': 'application/json',
          },
        ),
      );

      setState(() {
        movies = res.data['results'];
      });
    } catch (e) {
      debugPrint("Hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          leading: GestureDetector(
            onTap: () {
              if (movie['poster_path'] != null) {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    child: InteractiveViewer(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              }
            },
            child: (movie['poster_path'] != null)
                ? Image.network(
                    'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                    width: 56,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.movie_outlined),
          ),
          title: Text(movie['title'] ?? 'Başlıksız'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Vizyon: ${movie['release_date'] ?? '-'}"),
              Text("Puan: ${movie['vote_average'] ?? '-'}"),
            ],
          ),
          trailing: _buildStars(movie['vote_average'] as num?),
        );
      },
    );
  }
}
