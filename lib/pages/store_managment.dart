import 'package:amertat/pages/paper_price.dart';
import 'package:amertat/pages/services_price.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';


class StoreManagement extends StatefulWidget {
  const StoreManagement({Key? key}) : super(key: key);

  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
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
