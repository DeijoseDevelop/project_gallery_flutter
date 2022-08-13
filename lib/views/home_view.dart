import 'package:flutter/material.dart';
import 'package:gallery_image/views/views.dart';
import 'package:gallery_image/views/widgets/title_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgets = <Widget>[
    ListPhotoView(),
    LibraryView(),
    Text('HomeView'),
    Text('HomeView'),
  ];

  void _changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const TitleMenu(),
          actions:  <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 7, 161, 182),
                radius: 20,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('D')
                )
              ),
            ),
          ],
        ),
        body: Center(
          child: _widgets.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 238, 243, 253),
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: const IconThemeData(
            size: 35,
            color: Color.fromARGB(200, 86, 113, 204),
          ),
          items: _buildBottomNavigationBarItems(),
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 61, 61, 61),
          unselectedItemColor: const Color.fromARGB(255, 61, 61, 61),
          onTap: _changeIndex,
        ),
      ),
    );
  }
}

List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
  return <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.photo_outlined),
      label: 'Photos',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.people_alt_outlined),
      label: 'Sharing',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.library_books_outlined),
      label: 'Library',
    ),
  ];
}
