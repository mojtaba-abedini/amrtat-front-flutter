
import 'package:amertat/pages/base_information/banks.dart';
import 'package:amertat/pages/base_information/grams.dart';
import 'package:amertat/pages/base_information/jens.dart';
import 'package:amertat/pages/base_information/paper_price.dart';
import 'package:amertat/pages/base_information/paper_size.dart';
import 'package:amertat/pages/base_information/shit_size.dart';
import 'package:amertat/pages/base_information/stores.dart';
import 'package:amertat/pages/base_information/size.dart';
import 'package:amertat/pages/base_information/taraf_hesab.dart';
import 'package:amertat/pages/base_information/vaheds.dart';
import 'package:amertat/pages/base_information/vaziat_sefaresh.dart';

import 'package:flutter/material.dart';

import '../store.dart';
import '../widgets/button.dart';
import 'base_information/karbari.dart';
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
      backgroundColor: thirdColor,
      appBar: AppBar(
        title: const Text('اطلاعات پایه'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                    text: 'طرف حساب',
                    callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TarafHesab()))),
                const SizedBox(width: 30,),
                MyButton(
                    text: 'قیمت کاغذ',
                    callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaperPrice()))),
                const SizedBox(width: 30,),
                MyButton(
                    text: 'قیمت سایر خدمات',
                    callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServicesPrice()))),
                MyButton(
                    text: 'جنس کاغذ',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Jens()))),
                const SizedBox(width: 30,),
                MyButton(
                    text: 'کاربری ها',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Karbari()))),
                MyButton(
                    text: 'سایز محصولات',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Size()))),
                const SizedBox(width: 30,),
                MyButton(
                    text: 'اندازه شیت',
                    callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShitSize()))),
                MyButton(
                    text: 'اندازه کاغذ',
                    callback: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaperSize()))),
                MyButton(
                    text: 'وضعیت سفارش',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const VaziatSefaresh()))),
                MyButton(
                    text: 'گرماژ',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Grams()))),
                const SizedBox(width: 30,),
                MyButton(
                    text: 'انبارها',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Stores()))),
                MyButton(
                    text: 'واحدها',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Vaheds()))),
                const SizedBox(width: 30,),
                MyButton(
                    text: 'بانک ها',
                    callback: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Banks()))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
