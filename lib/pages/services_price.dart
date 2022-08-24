import 'package:flutter/material.dart';

import '../store.dart';
import '../widgets/button.dart';
import '../widgets/textbox_title.dart';

class ServicesPrice extends StatefulWidget {
  const ServicesPrice({Key? key}) : super(key: key);

  @override
  State<ServicesPrice> createState() => _ServicesPriceState();
}

class _ServicesPriceState extends State<ServicesPrice> {
  void onPressButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قیمت سایر خدمات'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            MyTextboxTitle(
                title: 'قیمت هر فرم چاپ',
                isNumber: false,
                isPrice: true,
                lengthLimit: 0,
                callback: (value) => printingFormPrice = value),
            MyTextboxTitle(
                title: 'قیمت سلفون',
                isNumber: false,
                isPrice: true,
                lengthLimit: 0,
                callback: (value) => selefonPrise = value),
            MyTextboxTitle(
                title: 'قیمت یووی',
                isNumber: false,
                isPrice: true,
                lengthLimit: 0,
                callback: (value) => uvPrise = value),
            MyTextboxTitle(
                title: 'قیمت لترپرس',
                isNumber: false,
                isPrice: true,
                lengthLimit: 0,
                callback: (value) => letterPressPrise = value),
            const SizedBox(
              height: 20,
            ),
            MyButton(text: 'ذخیره', callback: onPressButton),
          ],
        ),
      )),
    );
  }
}
