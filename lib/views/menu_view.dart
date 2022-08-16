import 'package:flutter/material.dart';
import 'package:gallery_image/modelview/providers/auth_login.dart';
import 'package:gallery_image/modelview/services/auth_service.dart';
import 'package:gallery_image/modelview/services/gallery_service.dart';
import 'package:gallery_image/views/views.dart';
import 'package:gallery_image/views/widgets/loader.dart';
import 'package:gallery_image/views/widgets/title_menu.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  static final List<Widget> _widgets = <Widget>[
    ListPhotoView(galleryService: GalleryService().getGallery()),
    const SearchPhotoView(),
    const LibraryView(),
    const TakePhotoView(),
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
          automaticallyImplyLeading: false,
          actions: <Widget>[
            /* Container(
              margin: const EdgeInsets.only(right: 20),
              child: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 7, 161, 182),
                  radius: 20,
                  child:
                      Padding(padding: EdgeInsets.all(10), child: Text('D'))),
            ), */
            const TitleMenu(),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.redAccent)),
              onPressed: () async {
                openLoader(context);
                AuthLogin _authLogin = AuthLogin();
                openLoader(context);
                closeLoader(context);
                await _authLogin.logout();
                bool isSupported = await AuthService.isSupported();
                if(isSupported) {
                  Future.delayed(const Duration(seconds: 1), () async {
                  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthView()),
                        (Route<dynamic> route) => false);
                  });
                } else{
                  // ignore: use_build_context_synchronously
                  Future.delayed(const Duration(seconds: 1), () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginView()),
                        (Route<dynamic> route) => false);
                  });
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  //fontSize: 20,
                ),
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
      icon: Icon(Icons.photo_library_outlined),
      label: 'Library',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.camera_alt_outlined),
      label: 'Take a picture',
    ),
  ];
}
