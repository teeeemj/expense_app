import 'package:expense/screens/add_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        showUnselectedLabels: true,
        items: _buildBottomNavBarItems,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> get _buildBottomNavBarItems => [
      const BottomNavigationBarItem(
          icon: Icon(Icons.analytics), label: 'Analytic'),
      BottomNavigationBarItem(
          activeIcon: Builder(
            builder: (BuildContext context) {
              return CircleAvatar(
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddPage(),
                    );
                  },
                ),
              );
            },
          ),
          icon: const CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 20,
            child: Icon(Icons.home),
          ),
          label: ''),
      const BottomNavigationBarItem(
        icon: Icon(Icons.system_update_sharp),
        label: 'Change Log',
      ),
    ];
