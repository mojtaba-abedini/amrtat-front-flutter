import 'package:flutter/material.dart';

const firstColor = Color(0xff20958f);
const secondColor = Color(0xff2b7a77);
const thirdColor = Color(0xfff5f5f5);

class Palette {
  static const MaterialColor myFirstColor = MaterialColor(
    0xff20958f,
    <int, Color>{
      50: Color.fromRGBO(52, 73, 85, .1),
      100: Color.fromRGBO(52, 73, 85, .2),
      200: Color.fromRGBO(52, 73, 85, .3),
      300: Color.fromRGBO(52, 73, 85, .4),
      400: Color.fromRGBO(52, 73, 85, .5),
      500: Color.fromRGBO(52, 73, 85, .6),
      600: Color.fromRGBO(52, 73, 85, .7),
      700: Color.fromRGBO(52, 73, 85, .8),
      800: Color.fromRGBO(52, 73, 85, .9),
      900: Color.fromRGBO(52, 73, 85, 1.0),
    },
  );

  static const MaterialColor mySecondColor = MaterialColor(
    0xff20958f,
    <int, Color>{
      50: Color.fromRGBO(249, 170, 51, .1),
      100: Color.fromRGBO(249, 170, 51, .2),
      200: Color.fromRGBO(249, 170, 51, .3),
      300: Color.fromRGBO(249, 170, 51, .4),
      400: Color.fromRGBO(249, 170, 51, .5),
      500: Color.fromRGBO(249, 170, 51, .6),
      600: Color.fromRGBO(249, 170, 51, .7),
      700: Color.fromRGBO(249, 170, 51, .8),
      800: Color.fromRGBO(249, 170, 51, .9),
      900: Color.fromRGBO(249, 170, 51, 1.0),
    },
  );
}

Map<int, Color> color = {
  100: const Color.fromRGBO(6, 181, 212, .1),
  100: const Color.fromRGBO(6, 181, 212, .2),
  200: const Color.fromRGBO(6, 181, 212, .3),
  300: const Color.fromRGBO(6, 181, 212, .4),
  400: const Color.fromRGBO(6, 181, 212, .5),
  500: const Color.fromRGBO(6, 181, 212, .6),
  600: const Color.fromRGBO(6, 181, 212, .7),
  700: const Color.fromRGBO(6, 181, 212, .8),
  800: const Color.fromRGBO(6, 181, 212, .9),
  900: const Color.fromRGBO(6, 181, 212, 1.0),
};

String newCustomerName = "";
String newCustomerPhone = "";
String newCustomerContactDate = "";
String newCustomerOrderDescription = "";
String newCustomerOrderCount = "";

String newOrderName = "";
String newOrderPhone = "";
String newOrderType = "";
String newOrderSize = "";
String newOrderFirstPrice = "";
String newOrderDate = "";
String newOrderFirstPriceDate = "";
String newOrderBank = "";
String newOrderPrice = "";
String selefon = "";
String talakoob = "";
String UV = "";
String letterPress = "";
String sahafi = "";

String printingFormPrice = "";
String selefonPrise = "";
String uvPrise = "";
String letterPressPrise = "";

String craftPrise = "";
String glossePrise = "";

List orderAttribute = [
  {'id': 1, 'name': 'دارد'},
  {'id': 2, 'name': 'ندارد'},
];

List printingColor = [
  {'id': 1, 'name': '1'},
  {'id': 2, 'name': '2'},
  {'id': 3, 'name': '3'},
  {'id': 4, 'name': '4'},
];


List orderStatus = [
  {'id': 1, 'name': 'ثبت سفارش'},
  {'id': 2, 'name': 'چاپ و لترپرس'},
  {'id': 3, 'name': 'ساخت'},
  {'id': 4, 'name': 'تکمیل سفارش'},
  {'id': 5, 'name': 'تسویه و ارسال'},
];

