import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcase_with_provider/providers/movies_provider.dart';
import '../providers/connectivity_provider.dart';
import '../widgets/moviescard_widget.dart';
import '../widgets/noconnection_widget.dart';
import 'detailmovie_page.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ConnectivityProvider>().checkConnection();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: true,
      ),
      body: Consumer<ConnectivityProvider>(
        builder: (context, connection, child) {
          if (connection.connectivityResult == ConnectivityResult.none) {
            return NoConnectionWidget(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MoviesPage(),
                  ),
                  (route) => false,
                );
              },
            );
          } else {
            return FutureBuilder(
              future: context.read<MoviesProvider>().getMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Consumer<MoviesProvider>(
                    builder: (context, movies, _) => GridView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: movies.movies.results!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return MoviesCardWidget(
                          image: movies.imageBaseUrl +
                              movies.movies.results![index].posterPath!,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailMoviePage(
                                  movie: movies.movies.results![index],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
