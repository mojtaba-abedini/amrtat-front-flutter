import 'package:amertat/pages/base_information/about.dart';
import 'package:amertat/pages/base_information.dart';

import 'package:amertat/pages/home/store_managment.dart';
import 'package:amertat/pages/login_page.dart';
import 'package:amertat/pages/main_page.dart';

import 'package:amertat/pages/orders.dart';
import 'package:amertat/store.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'آمرتات بگ',



      theme: ThemeData(
        fontFamily: 'IranYekan',
        primarySwatch: Palette.myFirstColor,
      ),
      // home: const MyHomePage(title: 'آمرتات بگ'),
      home: const LoginPage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String logoFileName = 'assets/Logo.svg';

  late int _selectedDestination = 0;

  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late int _currentIndex;
  late Widget _currentPage = const MainPage();

  @override
  void initState() {
    super.initState();
    _page1 = const StoreManagement();
    _page2 = const MainPage();
    _page3 = const Orders();

    _pages = [_page1, _page2, _page3];
    _currentIndex = 1;
    _currentPage = _page2;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
      _selectedDestination = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: thirdColor,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.wifi),

            )
          ],
          toolbarHeight: 75,
          title: Text(widget.title),
          centerTitle: true,
          elevation: 0,

        ),
        body: _currentPage,
        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 13,
            selectedIconTheme:
                const IconThemeData(color: Colors.white, size: 40),
            unselectedIconTheme: const IconThemeData(color: Colors.white60),
            unselectedItemColor: Colors.white60,
            selectedItemColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (index) {
              _changeTab(index);
            },
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                label: 'مدیریت انبار',
                icon: Icon(Icons.store),
              ),
              BottomNavigationBarItem(
                label: 'صفحه نخست',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'سفارش ها',
                icon: Icon(Icons.list_sharp),
              ),
            ]),
        drawer: SizedBox(
          width: 250,
          child: Drawer(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Center(
                child: Container(
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    height: 200,
                    child: SizedBox(
                      child: SvgPicture.asset(
                        logoFileName,
                        width: 130,
                        height: 130,
                      ),
                    )),
              ),
              const Divider(
                height: 10,
                thickness: 10,
              ),
              ListTile(
                selectedTileColor: Palette.mySecondColor.shade500,
                selectedColor: Colors.white,


                leading: const Icon(Icons.home,color: Palette.myFirstColor,),
                title: const Text(
                  'صفحه نخست',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                selected: _selectedDestination == 1,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(1);
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),

              ListTile(
                selectedTileColor: Palette.mySecondColor.shade500,
                selectedColor: Colors.white,



                leading: const Icon(Icons.list,color: Palette.myFirstColor,),
                title: const Text(
                  'سفارش ها',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(2);
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                selectedTileColor: Palette.mySecondColor.shade500,
                selectedColor: Colors.white,

                leading: const Icon(Icons.store,color: Palette.myFirstColor,),
                title: const Text(
                  'مدیریت انبار',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                selected: _selectedDestination == 0,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(0);
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                selectedTileColor: Palette.mySecondColor.shade500,
                selectedColor: Colors.white,

                leading: const Icon(Icons.insert_drive_file_outlined,color: Palette.myFirstColor,),
                title: const Text(
                  'اطلاعات پایه',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                selected: _selectedDestination == 3,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BaseInformation()));
                  _changeTab(1);
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                  selectedTileColor: Palette.mySecondColor.shade500,
                  selectedColor: Colors.white,

                  leading: const Icon(Icons.announcement_outlined,color: Palette.myFirstColor,),
                  title: const Text(
                    'درباره ما',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const About()));
                  }),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                  selectedTileColor: Palette.myFirstColor,
                  selectedColor: Colors.white,

                  leading: const Icon(Icons.exit_to_app,color: Palette.myFirstColor,),
                  title: const Text(
                    'خروج',
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                  selectedTileColor: Palette.myFirstColor,
                  selectedColor: Colors.white,


                  title: const Center(
                    child: Text(
                      'نسخه آزمایشی',
                      style: TextStyle(fontSize: 13,color: Palette.myFirstColor),
                    ),
                  ),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          )),
        ));
  }
}


class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return  Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}