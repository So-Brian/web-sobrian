import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:web_sobrian/widgets/blog.dart';
import 'package:web_sobrian/widgets/blogs.dart';

import 'models/blog.dart';
import 'pages/home_page.dart';
import 'blog_route_path.dart';

//https://www.youtube.com/watch?v=FBoAXUkHu44

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoBrian',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Sobrian Blogs'),
    );
  }
}

class BlogRouteInformationParser extends RouteInformationParser<BlogRoutePath> {
  @override
  Future<BlogRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    Uri uri = Uri.parse('');
    if (routeInformation.location != null) {
      uri = Uri.parse(routeInformation.location.toString());
    }

    log(uri.toString());

    // Handle '/'
    if (uri.pathSegments.length == 0) {
      return BlogRoutePath.home();
    }

    // Handle '/blog/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'book') return BlogRoutePath.unknown();
      final bookId = int.tryParse(uri.pathSegments[1]);
      if (bookId == null) return BlogRoutePath.unknown();

      return BlogRoutePath.details(bookId);
    }

    // Handle unknown routes
    return BlogRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(BlogRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/not-found');
    }

    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }

    if (configuration.isDetailPage) {
      return RouteInformation(location: '/book/${configuration.id}');
    }

    return null;
  }
}

class BlogRouterDelegate extends RouterDelegate<BlogRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BlogRoutePath> {
  Blog? _selectedBlog;
  bool _show404 = false;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  void _handleBlogTapped(Blog blog) {
    _selectedBlog = blog;
    notifyListeners();
  }

  @override
  BlogRoutePath? get currentConfiguration {
    if (_show404) return BlogRoutePath.unknown();

    if (_selectedBlog == null) return BlogRoutePath.home();

    return BlogRoutePath.details(_selectedBlog!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(key: const ValueKey('HomePage'), child: BlogsWidget()),
        if (_selectedBlog != null) MaterialPage(child: BlogWidget())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        _selectedBlog = null;
        _show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(BlogRoutePath configuration) async {
    if (configuration.isUnknown) {
      _selectedBlog = null;
      _show404 = true;

      return;
    }

    if (configuration.isDetailPage) {}
  }
}
