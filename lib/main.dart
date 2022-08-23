import 'package:amertat/pages/base_information.dart';
import 'package:amertat/pages/main_page.dart';
import 'package:amertat/pages/new_customer.dart';
import 'package:amertat/pages/new_order.dart';
import 'package:amertat/pages/orders.dart';
import 'package:amertat/widgets/button.dart';
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
        primarySwatch: Colors.pink,
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
  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late int _currentIndex;
  late Widget _currentPage = const MainPage();

  @override
  void initState() {
    super.initState();
    _page1 = const BaseInformation();
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
          selectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
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
              label: 'اطلاعات پایه',
              icon: Icon(Icons.insert_drive_file_outlined),
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
    );
  }
}
