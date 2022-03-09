import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcase_with_provider/models/movie_model.dart';
import 'package:testcase_with_provider/providers/movies_provider.dart';
import 'package:intl/intl.dart';

class DetailMoviePage extends StatelessWidget {
  final Result movie;
  const DetailMoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _baseImageUrl = context.read<MoviesProvider>().imageBaseUrl;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Movie Detail'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(_baseImageUrl + movie.backdropPath!),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 130,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image:
                                NetworkImage(_baseImageUrl + movie.posterPath!),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 150,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              movie.title!.isEmpty
                                  ? movie.originalName!
                                  : movie.title!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('dd MMMM yyyy').format(
                                movie.releaseDate == null
                                    ? movie.firstAirDate!
                                    : movie.releaseDate!,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 224, 205, 35),
                                ),
                                const SizedBox(width: 10),
                                Text(movie.voteAverage.toString())
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width - 20,
                    padding: const EdgeInsets.fromLTRB(0, 30, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.overview!,
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
