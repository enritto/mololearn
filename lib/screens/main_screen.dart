import 'package:flutter/cupertino.dart';
import 'dashboard_tab.dart';
import 'feed_tab.dart';
import 'profile_tab.dart';

class MainScreen extends StatelessWidget {
  final String username;

  const MainScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_solid),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news_solid),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return DashboardTab();
          case 1:
            return FeedTab();
          case 2:
            return ProfileTab(username: username);
          default:
            return DashboardTab();
        }
      },
    );
  }
}