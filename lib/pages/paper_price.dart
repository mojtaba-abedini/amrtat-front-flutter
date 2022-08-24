import 'package:flutter/material.dart';

import '../store.dart';
import '../widgets/button.dart';
import '../widgets/textbox_title.dart';

class PaperPrice extends StatefulWidget {
  const PaperPrice({Key? key}) : super(key: key);

  @override
  State<PaperPrice> createState() => _PaperPriceState();
}

class _PaperPriceState extends State<PaperPrice> {

  void onPressButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قیمت کاغذ'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              MyTextboxTitle(
                  title: 'قیمت کاغذ کرافت',
                  isNumber: false,
                  isPrice: true,
                  lengthLimit: 0,
                  callback: (value) => craftPrise = value),
              MyTextboxTitle(
                  title: 'قیمت کاغذ گلاسه',
                  isNumber: false,
                  isPrice: true,
                  lengthLimit: 0,
                  callback: (value) => glossePrise = value),
              const SizedBox(
                height: 20,
              ),
              MyButton(text: 'ذخیره', callback: onPressButton),

            ],
          ),
        )
      ),
    );
  }
}
