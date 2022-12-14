import 'package:flutter/material.dart';

const firstColor = Color(0xffa10035);
const secondColor = Color(0xff747474);
const thirdColor = Color(0xfff5f5f5);



class Palette {
  static const MaterialColor myFirstColor = MaterialColor(
    0xffa10035,
    <int, Color>{
      50: Color.fromRGBO(161, 0, 53, .1),
      100: Color.fromRGBO(161, 0, 53, .2),
      200: Color.fromRGBO(161, 0, 53,.3),
      300: Color.fromRGBO(161, 0, 53, .4),
      400: Color.fromRGBO(161, 0, 53, .5),
      500: Color.fromRGBO(161, 0, 53, .6),
      600: Color.fromRGBO(161, 0, 53, .7),
      700: Color.fromRGBO(161, 0, 53, .8),
      800: Color.fromRGBO(161, 0, 53, .9),
      900: Color.fromRGBO(161, 0, 53, 1.0),
    },
  );

  static const MaterialColor mySecondColor = MaterialColor(
    0xff747474,
    <int, Color>{
      50: Color.fromRGBO(116, 116, 116, .1),
      100: Color.fromRGBO(116, 116, 116, .2),
      200: Color.fromRGBO(116, 116, 116, .3),
      300: Color.fromRGBO(116, 116, 116, .4),
      400: Color.fromRGBO(116, 116, 116, .5),
      500: Color.fromRGBO(116, 116, 116, .6),
      600: Color.fromRGBO(116, 116, 116, .7),
      700: Color.fromRGBO(116, 116, 116, .8),
      800: Color.fromRGBO(116, 116, 116, .9),
      900: Color.fromRGBO(116, 116, 116, 1.0),
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

String LoginToken ="";


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
  {'id': 1, 'name': '????????'},
  {'id': 2, 'name': '??????????'},
];

List printingColor = [
  {'id': 1, 'name': '1'},
  {'id': 2, 'name': '2'},
  {'id': 3, 'name': '3'},
  {'id': 4, 'name': '4'},
];


List orderStatus = [
  {'id': 1, 'name': '?????? ??????????'},
  {'id': 2, 'name': '?????? ?? ????????????'},
  {'id': 3, 'name': '????????'},
  {'id': 4, 'name': '?????????? ??????????'},
  {'id': 5, 'name': '?????????? ?? ??????????'},
];

