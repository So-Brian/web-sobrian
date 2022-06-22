import 'package:flutter/material.dart';
import 'package:sobrian/core.dart';
import 'package:sobrian/services/hive_storage_service.dart';

class MainScreen extends StatefulWidget {
  // Receives the name of the route from router delegate
  final String routeName;

  const MainScreen({
    Key? key,
    required this.routeName,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? render;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          Text('data'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => _logOut(),
              child: const Center(
                child: Text(
                  'Log Out ',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          )
        ],
        iconTheme: IconThemeData(color: Colors.red),
      ),
      drawer: Drawer(
        elevation: 1,
        child: ListView.builder(
            itemCount: routeList.length,
            itemBuilder: (context, i) {
              return _navTile(routeList[i]);
            }),
      ),
      body: Row(
        key: UniqueKey(),
        children: [
          Expanded(
            child:
                Center(child: RouteHandeler().getRouteWidget(widget.routeName)),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }

  _logOut() async {
    await HiveDataStorageService.logOutUser();
    AppRouterDelegate().setPathName(RouteData.login.name, loggedIn: false);
  }

  Widget _navTile(SubNavigationRoutes route) {
    return ListTile(
      leading: Icon(
        route.icon,
        color: widget.routeName.contains(route.route.name)
            ? Colors.blue
            : Colors.grey,
      ),
      title: Text(
        route.title,
        style: TextStyle(
          color: widget.routeName.contains(route.route.name)
              ? Colors.blue
              : Colors.grey,
        ),
      ),
      onTap: () {
        AppRouterDelegate().setPathName(route.route.name);
      },
    );
  }
}
