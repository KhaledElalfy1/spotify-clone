import 'package:client/core/utils/app_colors.dart';
import 'package:client/features/home/view/pages/song_page.dart';
import 'package:client/features/home/view/pages/widgets/music_slab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'library_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  final List<Widget> _children = const [
    SongPage(),
    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          _children[selectedIndex],
          const Positioned(
            bottom: 0,
            child: MusicSlab(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: Image.asset(
                  'assets/images/home_filled.png',
                  color: AppColors.whiteColor,
                ),
                icon: Image.asset(
                  'assets/images/home_unfilled.png',
                  color: AppColors.inactiveBottomBarItemColor,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/library.png',
                  color: selectedIndex == 1
                      ? AppColors.whiteColor
                      : AppColors.inactiveBottomBarItemColor,
                ),
                label: 'Library'),
          ]),
    );
  }
}
