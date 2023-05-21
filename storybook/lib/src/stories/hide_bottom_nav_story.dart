import 'package:flutter/material.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

import '../storybook/storybook.dart';

class HideBottomNavStory extends Story {
  const HideBottomNavStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent(BuildContext context) {
    return [
      WidgetMap(
        title: 'Hide Bottom Nav Story',
        builder: (context) => const HideBottomNavScreen(),
      )
    ];
  }
}

class HideBottomNavScreen extends StatefulWidget {
  const HideBottomNavScreen({super.key});

  @override
  State<HideBottomNavScreen> createState() => _HideBottomNavScreenState();
}

class _HideBottomNavScreenState extends State<HideBottomNavScreen> {
  int _selectedIndex = 0;

  final _hdNavKey = GlobalKey<HidableBottomNavState>();

  final controller = ScrollController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _hdNavKey.currentState?.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            color: index % 2 == 0 ? Colors.yellow : Colors.green,
          );
        },
      ),
      bottomNavigationBar: HidableBottomNav(
        scrollControllers: [
          controller,
        ],
        key: _hdNavKey,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
