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

  Widget get layout1 => ListView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            color: index % 2 == 0 ? Colors.yellow : Colors.green,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DateTime.now().microsecondsSinceEpoch % 2 == 0
          ? layout1
          : CustomScrollView(
              controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  backgroundColor: Colors.green,
                  title: Text('Ticky appbar'),
                  floating: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index == 0) {
                        return Container(
                          height: 150,
                          color: index % 2 == 0 ? Colors.yellow : Colors.green,
                        );
                      }
                      return Card(
                        margin: const EdgeInsets.all(15),
                        child: Container(
                          color: Colors.blue[100 * (index % 9 + 1)],
                          height: 80,
                          alignment: Alignment.center,
                          child: Text(
                            'Item $index',
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    },
                    childCount: 1000, // 1000 list items
                  ),
                ),
              ],
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
