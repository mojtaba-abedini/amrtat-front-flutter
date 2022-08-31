import 'package:amertat/pages/base_information/banks.dart';
import 'package:amertat/pages/base_information/paper_price.dart';
import 'package:amertat/pages/base_information/stores.dart';
import 'package:amertat/pages/base_information/vaheds.dart';

import 'package:flutter/material.dart';

import '../widgets/button.dart';
import 'base_information/services_price.dart';


class BaseInformation extends StatefulWidget {
  const BaseInformation({Key? key}) : super(key: key);

  @override
  State<BaseInformation> createState() => _BaseInformationState();
}

class _BaseInformationState extends State<BaseInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اطلاعات پایه'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyButton(
                text: 'قیمت کاغذ',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaperPrice()))),
            MyButton(
                text: 'قیمت سایر خدمات',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ServicesPrice()))),
            MyButton(
                text: 'انبارها',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Stores()))),
            MyButton(
                text: 'واحدها',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Vaheds()))),
            MyButton(
                text: 'بانک ها',
                callback: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Banks()))),
          ],
        ),
      ),
    );
  }
}
