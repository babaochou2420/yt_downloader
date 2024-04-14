import 'package:flutter/material.dart';
import 'package:yt_downloader/screens/screen_query.dart';
import 'package:yt_downloader/screens/screen_search.dart';
import 'package:yt_downloader/screens/screen_settings.dart';

class ViewNavigation extends StatefulWidget {
  const ViewNavigation({Key? key}) : super(key: key);

  @override
  State<ViewNavigation> createState() => _ViewNavigationState();
}

class _ViewNavigationState extends State<ViewNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.manage_search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library),
            label: 'Query',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        // Search video by url
        ScreenSearch(),

        // Video download query
        ScreenQuery(),

        // Settings
        ScreenSettings(),
      ][currentPageIndex],
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.destinations,
    this.indicatorColor,
  }) : super(key: key);

  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final List<NavigationDestination> destinations;
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    final Color themeColor = Theme.of(context).colorScheme.primary;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        for (var destination in destinations)
          BottomNavigationBarItem(
            icon: destination.icon,
            label: destination.label,
          ),
      ],
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: indicatorColor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: indicatorColor ?? themeColor),
    );
  }
}

class NavigationDestination {
  const NavigationDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
  });

  final Widget icon;
  final String label;
  final Widget? selectedIcon;
}
