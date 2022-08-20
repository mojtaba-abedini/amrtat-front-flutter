import 'package:amertat/pages/new_customer.dart';
import 'package:amertat/pages/new_order.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButton(
                text: 'ثبت مشتری جدید',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewCustomer()))),
            MyButton(
                text: 'ثبت سفارش جدید',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewOrder())))
          ],
        ),
      ),
    );
  }
}
