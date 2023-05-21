import 'package:flutter/material.dart';
import 'package:mobilehub_ui_core/mobilehub_ui_core.dart';

import '../storybook/storybook.dart';

class SocialDashboardStory extends Story {
  const SocialDashboardStory({Key? key}) : super(key: key);

  @override
  List<WidgetMap> storyContent(BuildContext context) {
    return [
      WidgetMap(
        title: 'Social Dashboard',
        builder: (context) => const SocialDashboardScreen(),
      )
    ];
  }
}

class SocialDashboardScreen extends StatefulWidget {
  const SocialDashboardScreen({super.key});

  @override
  State<SocialDashboardScreen> createState() => _SocialDashboardScreenState();
}

class _SocialDashboardScreenState extends State<SocialDashboardScreen> {
  int _selectedIndex = 0;

  final _hdNavKey = GlobalKey<HidableBottomNavState>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _hdNavKey.currentState?.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            FloatingAppbarPage(
              title: 'Home Page',
              onInnerScrollControllerUpdate: (scrollController) {
                _hdNavKey.currentState?.addListener(scrollController);
              },
            ),
            const NormalPage(),
            FloatingAppbarPage(
              title: 'Account Page',
              onInnerScrollControllerUpdate: (scrollController) {
                _hdNavKey.currentState?.addListener(scrollController);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: HidableBottomNav(
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

class FloatingAppbarPage extends StatelessWidget {
  const FloatingAppbarPage({
    super.key,
    required this.onInnerScrollControllerUpdate,
    required this.title,
  });

  final String title;
  final void Function(ScrollController) onInnerScrollControllerUpdate;

  @override
  Widget build(BuildContext context) {
    return NestedScrollViewNotification(
      onInnerScrollControllerUpdate: onInnerScrollControllerUpdate,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              primary: false,
              snap: true,
              pinned: false,
              automaticallyImplyLeading: false,
              elevation: 0,
              titleSpacing: 0,
              toolbarHeight: 45,
              title: Center(child: Text(title)),
            ),
          )
        ];
      },
      floatHeaderSlivers: true,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            color: index % 2 == 0 ? Colors.white : Colors.grey,
          );
        },
      ),
    );
  }
}

class NormalPage extends StatelessWidget {
  const NormalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Normal Page'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            color: index % 2 == 0 ? Colors.yellow : Colors.green,
          );
        },
      ),
    );
  }
}
