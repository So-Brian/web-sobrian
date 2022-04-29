import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_sobrian/models/blog.dart';

class BlogsWidget extends StatefulWidget {
  List<Blog> blogs = [];

  @override
  State<StatefulWidget> createState() => _BlogsWidgetState();

  void ToBlog(int index) {
    log(blogs[index].title + 'clicked!');
  }
}

class _BlogsWidgetState extends State<BlogsWidget> {
  bool loading = true;

  @override
  void initState() {
    super.initState();

    loading = true;

    _getBlogs();
  }

  Future<void> _getBlogs() async {
    // var ip = String.fromEnvironment('APPLICATION_NAME');
    try {
      var url = Uri.parse('https://sobrian.azure-api.net/blog-service/all');
      var response = await http.get(url);
      Iterable l = json.decode(response.body);
      widget.blogs = List<Blog>.from(l.map((model) => Blog.fromJson(model)));
    } catch (e) {
      log(e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(
          child: ListView.separated(
        itemCount: widget.blogs.length,
        itemBuilder: ((context, index) => Listener(
              child: Container(
                height: 50,
                color: Colors.amber,
                child: Center(child: Text(widget.blogs[index].title)),
              ),
              onPointerUp: (event) => {widget.ToBlog(index)},
            )),
        separatorBuilder: (context, index) => const Divider(
          color: Colors.white,
          thickness: 0,
          indent: 0,
        ),
      ));
    }
  }
}
