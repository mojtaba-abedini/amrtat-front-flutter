import 'package:amertat/pages/base_information/about.dart';
import 'package:amertat/pages/base_information.dart';

import 'package:amertat/pages/home/store_managment.dart';
import 'package:amertat/pages/main_page.dart';

import 'package:amertat/pages/orders.dart';

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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'آمرتات بگ'),
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
        appBar: AppBar(
          toolbarHeight: 75,
          title: Text(widget.title),
          centerTitle: true,
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
                      height: 130,
                      child: SvgPicture.asset(logoFileName),
                    )),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(
                  'صفحه نخست',
                  style: TextStyle(fontSize: 16),
                ),
                selected: _selectedDestination == 1,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(1);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text(
                  'سفارش ها',
                  style: TextStyle(fontSize: 15),
                ),
                selected: _selectedDestination == 2,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(2);
                },
              ),
              ListTile(
                leading: const Icon(Icons.store),
                title: const Text(
                  'مدیریت انبار',
                  style: TextStyle(fontSize: 15),
                ),
                selected: _selectedDestination == 0,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file_outlined),
                title: const Text(
                  'اطلاعات پایه',
                  style: TextStyle(fontSize: 15),
                ),
                selected: _selectedDestination == 3,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BaseInformation()));
                  _changeTab(1);
                },
              ),
              ListTile(
                  leading: const Icon(Icons.bookmark),
                  title: const Text(
                    'درباره ما',
                    style: TextStyle(fontSize: 15),
                  ),
                  selected: _selectedDestination == 3,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const About()));
                  }),
            ],
          )),
        ));
  }
}
