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

List<Map<String, String>> jens = [
  {'id': '1', 'name': 'کرافت'},
  {'id': '2', 'name': 'گلاسه'},
];

List<Map<String, String>> karbari = [
  {'id': '1', 'jensId': '1', 'name': 'ساک دستی خرید ( ضخامت حدود 130 گرم )'},
  {'id': '2', 'jensId': '1', 'name': 'پاکت فست فود ( ضخامت حدود 80 گرم )'},
  {'id': '3', 'jensId': '2', 'name': 'ساک دستی خرید ( ضخامت های مختلف )'},
];


List<Map<String, String>> size = [

{'id': '1', 'jensId' : '1' , 'karbariId': '1', 'name': '17 عرض 7 کاست 15 ارتفاع'},
{'id': '2', 'jensId' : '1' ,'karbariId': '1', 'name': '17 عرض 7 کاست 25 ارتفاع'},
{'id': '3', 'jensId' : '1' ,'karbariId': '1', 'name': '24 عرض 10 کاست 23 ارتفاع'},
{'id': '4', 'jensId' : '1' ,'karbariId': '1', 'name': '25 عرض 9 کاست 23.5 ارتفاع'},
{'id': '5', 'jensId' : '1' ,'karbariId': '1', 'name': '20 عرض 9 کاست 21 ارتفاع'},
{'id': '6', 'jensId' : '1' ,'karbariId': '1', 'name': '20 عرض 9 کاست 31 ارتفاع'},
{'id': '7', 'jensId' : '1' ,'karbariId': '1', 'name': '30 عرض 12 کاست 20 ارتفاع'},
{'id': '8', 'jensId' : '1' ,'karbariId': '1', 'name': '24 عرض 10 کاست 35 ارتفاع'},
{'id': '9', 'jensId' : '1' ,'karbariId': '1', 'name': '24 عرض 10 کاست 40 ارتفاع'},
{'id': '10', 'jensId' : '1' ,'karbariId': '1', 'name': '38 عرض 10 کاست 26 ارتفاع'},
{'id': '11', 'jensId' : '1' ,'karbariId': '1', 'name': '36 عرض 11 کاست 24 ارتفاع'},
{'id': '12', 'jensId' : '1' ,'karbariId': '1', 'name': '30 عرض 12 کاست 45 ارتفاع'},
{'id': '13', 'jensId' : '1' ,'karbariId': '1', 'name': '43 عرض 14 کاست 32 ارتفاع'},
{'id': '14', 'jensId' : '1' ,'karbariId': '1', 'name': '45 عرض 12 کاست 33 ارتفاع'},
{'id': '15', 'jensId' : '1' ,'karbariId': '1', 'name': '34 عرض 14 کاست 47 ارتفاع'},
{'id': '16', 'jensId' : '1' ,'karbariId': '1', 'name': '52 عرض 15 کاست 36 ارتفاع'},
{'id': '17', 'jensId' : '1' , 'karbariId': '2', 'name': '26.5 عرض 12 کاست 30 ارتفاع'},
{'id': '18', 'jensId' : '1' , 'karbariId': '2', 'name': '26.5 عرض 12 کاست 36 ارتفاع'},
{'id': '19', 'jensId' : '1' , 'karbariId': '2', 'name': '29.5 عرض 14 کاست 40 ارتفاع'},
{'id': '20', 'jensId' : '1' , 'karbariId': '2', 'name': '27 عرض 19 کاست 37 ارتفاع'},
{'id': '21', 'jensId' : '1' , 'karbariId': '2', 'name': '34.5 عرض 15 کاست 39 ارتفاع'},
{'id': '22', 'jensId' : '1' , 'karbariId': '2', 'name': '27 عرض 23 کاست 34 ارتفاع'},
{'id': '23', 'jensId' : '1' , 'karbariId': '2', 'name': '25 عرض 24.5 کاست 36 ارتفاع'},
{'id': '24', 'jensId' : '1' , 'karbariId': '2', 'name': '29.5 عرض 28.5 کاست 34 ارتفاع'},
{'id': '25', 'jensId' : '1' , 'karbariId': '2', 'name': '35 عرض 34 کاست 31 ارتفاع'},
{'id': '26', 'jensId' : '2' , 'karbariId': '3', 'name': '17 عرض 7 کاست 15 ارتفاع'},
{'id': '27', 'jensId' : '2' , 'karbariId': '3', 'name': '17 عرض 7 کاست 25 ارتفاع'},
{'id': '28', 'jensId' : '2' , 'karbariId': '3', 'name': '24 عرض 10 کاست 23 ارتفاع'},
{'id': '29', 'jensId' : '2' , 'karbariId': '3', 'name': '25 عرض 9 کاست 23.5 ارتفاع'},
{'id': '30', 'jensId' : '2' , 'karbariId': '3', 'name': '20 عرض 9 کاست 21 ارتفاع'},
{'id': '31', 'jensId' : '2' , 'karbariId': '3', 'name': '20 عرض 9 کاست 31 ارتفاع'},
{'id': '32', 'jensId' : '2' , 'karbariId': '3', 'name': '30 عرض 12 کاست 20 ارتفاع'},
{'id': '33', 'jensId' : '2' , 'karbariId': '3', 'name': '24 عرض 10 کاست 35 ارتفاع'},
{'id': '34', 'jensId' : '2' , 'karbariId': '3', 'name': '24 عرض 10 کاست 40 ارتفاع'},
{'id': '35', 'jensId' : '2' , 'karbariId': '3', 'name': '38 عرض 10 کاست 26 ارتفاع'},
{'id': '36', 'jensId' : '2' , 'karbariId': '3', 'name': '36 عرض 11 کاست 24 ارتفاع'},
{'id': '37', 'jensId' : '2' , 'karbariId': '3', 'name': '30 عرض 12 کاست 45 ارتفاع'},
{'id': '38', 'jensId' : '2' , 'karbariId': '3', 'name': '43 عرض 14 کاست 32 ارتفاع'},
{'id': '39', 'jensId' : '2' , 'karbariId': '3', 'name': '45 عرض 12 کاست 33 ارتفاع'},
{'id': '40', 'jensId' : '2' , 'karbariId': '3', 'name': '34 عرض 14 کاست 47 ارتفاع'},
{'id': '41', 'jensId' : '2' , 'karbariId': '3', 'name': '52 عرض 15 کاست 36 ارتفاع'}

];









List<Map<String, String>> orderAttribute = [
  {'id': '1', 'name': 'ندارد'},
  {'id': '2', 'name': 'دارد'},
];

List<Map<String, String>> banks = [
  {'id': '1', 'name': 'ملت'},
  {'id': '2', 'name': 'صادرات'},
  {'id': '3', 'name': 'مهر اقتصاد'},
];

List<Map<String, String>> orderSize = [
  {'id': '1', 'orderTypeId': '1', 'size': '43 عرض - 24 کاست - 50 ارتفاع'},
  {'id': '2', 'orderTypeId': '1', 'size': '33 عرض - 12 کاست - 48 ارتفاع'},
  {'id': '3', 'orderTypeId': '0', 'size': 'سایز اختصاصی'},
];


class Jens {

  final int id;
  final String name;

  const Jens({
    required this.id,
    required this.name,
  });

  factory Jens.fromJson(Map<String, dynamic> json) {
    return Jens(
      id: json['id'],
      name: json['name'],
    );
  }
}
