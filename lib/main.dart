import 'package:flutter/material.dart';
import 'package:flutter_instagram/pages/Home.dart';
import 'package:flutter_instagram/pages/Search.dart';
import 'package:flutter_instagram/pages/Activity.dart';
import 'package:flutter_instagram/pages/Profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Instagram',
      home: AppWithBottomBar(),
    );
  }
}

class AppWithBottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppWithBottomBarState();
}

class _AppWithBottomBarState extends State<AppWithBottomBar> {
  PageStorageBucket _pageStorageBucket;
  int _selectedPage;
  final List<Widget> pages = [
    HomePage(
      key: PageStorageKey("Home"),
    ),
    SearchPage(
      key: PageStorageKey("Search"),
    ),
    null, // Since add post is a popup, theres no page to display
    ActivityPage(
      key: PageStorageKey("Activity"),
    ),
    ProfilePage(
      key: PageStorageKey("Profile"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageStorageBucket = PageStorageBucket();
    _selectedPage = 0;
  }

  void onClickAddPost() {

  }

  void onTapBottomBar(newPage) {
    if (newPage != 2) {
      setState(() => _selectedPage = newPage);
      return;
    }
    print("show popup post dialong");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: _pageStorageBucket,
        child: pages[_selectedPage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapBottomBar,
        currentIndex: _selectedPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32.0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Discover")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), title: Text("Post")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text("Activity"), activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Profile"),)
        ],
      ),
    );
  }
}
