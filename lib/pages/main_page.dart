import 'package:flutter/material.dart';
import '../store.dart';
import '../widgets/button.dart';
import 'home/new_customer.dart';
import 'home/new_order.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdColor,
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
                callback: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewOrder())))
          ],
        ),
      ),
    );
  }
}
