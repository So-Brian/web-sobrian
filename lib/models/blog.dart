class Blog {
  late int id;
  late String title;
  late int authorID;
  late String path;
  late String graphID;
  late String wechatUrl;
  late DateTime created;
  late DateTime modified;

  Blog.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        title = json['Title'];
}
