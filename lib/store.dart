String newCustomerName = "";
String newCustomerPhone = "";
String newCustomerContactDate = "";
String newCustomerOrderDescription = "";
String newCustomerOrderCount="";

String newOrderName = "";
String newOrderPhone = "";
String newOrderType = "";
String newOrderSize = "";
String newOrderFirstPrice = "";
String newOrderDate = "";
String newOrderFirstPriceDate= "";
String newOrderBank= "";
String newOrderPrice= "";
String selefon= "";
String talakoob= "";
String UV= "";
String letterPress= "";
String sahafi= "";

String printingFormPrice= "";
String selefonPrise= "";
String uvPrise= "";
String letterPressPrise= "";

String craftPrise= "";
String glossePrise= "";


List<Map<String, String>> orderType = [
  {'id': '1', 'name': 'کرافت'},
  {'id': '2', 'name': 'گلاسه'},
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
  {'id': '1', 'orderTypeId' : '1', 'size': '43 عرض - 24 کاست - 50 ارتفاع'},
  {'id': '2', 'orderTypeId' : '1', 'size': '33 عرض - 12 کاست - 48 ارتفاع'},
  {'id': '3', 'orderTypeId' : '0', 'size': 'سایز اختصاصی'},
];

