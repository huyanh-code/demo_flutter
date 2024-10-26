import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/views/tabs/bookDetails_tab.dart';
import 'package:namer_app/views/tabs/bookmark_tab.dart';
import 'package:namer_app/views/tabs/favourite_tab.dart';
import 'package:namer_app/views/tabs/generator_tab.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageList = [
      GeneratorTab(),
      FavouriteTab(),
      BookmarkTab(),
      BookdetailsTab(),
    ];
    const _navBarItems = [
      
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, color: Colors.black,),
        activeIcon: Icon(Icons.home_rounded),
        backgroundColor: Colors.lightGreen,
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite, color: Colors.black),
        activeIcon: Icon(Icons.favorite_rounded),
        backgroundColor: Colors.lightGreen,
        label: 'Favorites',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark_border_outlined, color: Colors.black,),
        activeIcon: Icon(Icons.bookmark_rounded),
        backgroundColor: Colors.lightGreen,
        label: 'Bookmarks',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books_sharp, color: Colors.black,),
        activeIcon: Icon(Icons.library_books_rounded),
        backgroundColor: Colors.lightGreen,
        label: 'Library',
      ),
    ];

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: _navBarItems,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Row(
          children: <Widget>[
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: pageList[
                  _selectedIndex], // Chuyển nội dung chính sang trang tương ứng
            )
          ],
        ),
      );
  }
}
