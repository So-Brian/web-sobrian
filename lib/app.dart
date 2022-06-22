import 'package:flutter/material.dart';
import 'package:sobrian/core.dart';
//import 'package:web_sobrian/core.dart';

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation 2.0',
      routeInformationParser: RoutesInformationParser(),
      routerDelegate: AppRouterDelegate(isLoggedIn: isLoggedIn),
    );
  }
}
