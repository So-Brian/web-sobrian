import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sobrian/routing_constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to LoginView and wait for a result to come back
          var result = await Navigator.pushNamed(context, LoginViewRoute,
              arguments: 'Data Passed in');

          // If the result matches show a dialog
          if (result == 'fromLogin') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text('From Login'),
                    ));
          }
        },
        tooltip: 'Login',
        child: const Icon(Icons.login),
      ),
    );
  }

  void onPressed() {}
}

class LoginView extends StatelessWidget {
  final String argument;
  const LoginView({Key? key, required this.argument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Text('Login $argument'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context, 'fromLogin'),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      onWillPop: () => Future.value(false),
      // onWillPop: () async {
      //   Navigator.pop(context, 'fromLogin');
      //   return false;
      // },
    );
  }
}

class UndefinedView extends StatelessWidget {
  final String? name;
  const UndefinedView({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}
