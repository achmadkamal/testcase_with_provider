import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcase_with_provider/pages/login_page.dart';
import 'package:testcase_with_provider/pages/movies_page.dart';
import 'package:testcase_with_provider/providers/auth_provider.dart';
import 'package:testcase_with_provider/providers/connectivity_provider.dart';
import 'package:testcase_with_provider/providers/global_provider.dart';
import 'package:testcase_with_provider/providers/movies_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalProvider>(
          create: (_) => GlobalProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider()..isLoggedIn(),
        ),
        ChangeNotifierProvider<MoviesProvider>(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (_) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) =>
              auth.loginStatus == true ? const MoviesPage() : const LoginPage(),
        ),
      ),
    );
  }
}
