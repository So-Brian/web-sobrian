class BlogRoutePath {
  final int id;
  final bool isUnknown;

  BlogRoutePath.home()
      : id = 0,
        isUnknown = false;

  BlogRoutePath.details(this.id) : isUnknown = false;

  BlogRoutePath.unknown()
      : id = 0,
        isUnknown = true;

  bool get isHomePage => id == 0;
  bool get isDetailPage => id > 0;
}
