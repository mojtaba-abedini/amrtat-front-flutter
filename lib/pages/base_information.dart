import 'package:amertat/pages/paper_price.dart';
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

          ],
        ),
      ),
    );
  }
}
