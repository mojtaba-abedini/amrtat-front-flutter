import 'package:amertat/pages/paper_price.dart';
import 'package:amertat/pages/services_price.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';


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

          ],
        ),
      ),
    );
  }
}
