import 'package:flutter/material.dart';
import 'package:sobrian/routing_constants.dart';
import 'package:sobrian/view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case LoginViewRoute:
      var loginArgument = settings.arguments.toString();
      return MaterialPageRoute(
          builder: (context) => LoginView(argument: loginArgument));
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(
                name: settings.name,
              ));
  }
}
