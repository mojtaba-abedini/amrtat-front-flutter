import 'dart:convert';

import 'package:amertat/pages/home/new_order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../api.dart';
import '../store.dart';
import '../widgets/button.dart';
import '../widgets/date_picker.dart';
import '../widgets/my_widget.dart';
import '../widgets/textbox_title.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  static const orderApiUrl = OrderApi;
  static const tarafHesabApiUrl = TarafHesabApi;
  static const jensApiUrl = JensApi;
  static const sizeApiUrl = SizeApi;
  static const StatusApiUrl = StatusApi;
  static const PaymentApiUrl = PaymentApi;
  static const karbariApiUrl = KarbariApi;
  static const apiUrlPaperSize = PaperSizeApi;
  static const bankApiUrl = BankApi;

  bool _isVisible = false;
  List _loadedOrder = [];
  List _darJaryanOrder = [];
  List _darEntezarOrder = [];
  List _ersalShodeOrder = [];
  List _loadedPaperSize = [];
  List _loadedPayment = [];
  List _filteredPayment = [];
  List _loadedSize = [];
  List _loadedJens = [];
  List _loadedKarbari = [];
  List _loadedTarafHesab = [];
  List _loadedStatus = [];
  bool _isLoading = true;
  List _filteredSize = [];
  List _filteredKarbari = [];
  List _loadedBank = [];
  String _size_ekhtesasi = "";
  String _paperSizeId = "";

  int? _selectedOrderId;
  int? _selectedPaymentId;

  String? _selectedStatusId;
  String? _selectedOrderNumber;
  String? _selectedTarafHesabId;
  String? _selectedJensId;
  String? _selectedKarbariId;
  String? _selectedSizeId;
  String? _selectedTedad;
  String? _selectedPrintingColorId;
  String? _selectedSelefonId;
  String? _selectedTalakoobId;
  String? _selectedUvId;
  String? _selectedLetterPressId;
  String? _selectedSahafiId;
  String? _selectedTotalPrice;
  String? _selectedBeyanehPrice;
  String? _selectedBeyanehDate;
  String? _selectedBankId;
  String? _selectedSizeEkhtesasi;
  String? _selectedPaperSizeId;
  String? _orderDate;

  Future<void> _fetchOrders() async {



    final responseOrder = await http.get((Uri.parse(orderApiUrl)), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $LoginToken',
    });
    final dataOrder = json.decode(responseOrder.body);



    final responsePayment = await http.get(Uri.parse(PaymentApiUrl));
    final dataPayment = json.decode(responsePayment.body);

    final responseTarafHesab = await http.get(Uri.parse(tarafHesabApiUrl));
    final dataTarafHesab = json.decode(responseTarafHesab.body);

    final responseStatus = await http.get(Uri.parse(StatusApiUrl));
    final dataStatus = json.decode(responseStatus.body);


    setState(() {

      dataOrder['status'] == 'success' ? _loadedOrder = dataOrder['data'] : _loadedOrder=[] ;
      _loadedPayment = dataPayment['data'];
      _loadedTarafHesab = dataTarafHesab['data'];
      _loadedStatus = dataStatus['data'];
    });

    _darJaryanOrder = _loadedOrder
        .where((element) =>
            ((element['status_id'].toString() == 1.toString()) ||
                element['status_id'].toString() == 2.toString()) ||
            element['status_id'].toString() == 3.toString())
        .toList();
    _darEntezarOrder = _loadedOrder
        .where((element) => element['status_id'].toString() == 4.toString())
        .toList();
    _ersalShodeOrder = _loadedOrder
        .where((element) => element['status_id'].toString() == 5.toString())
        .toList();
  }

  Future<void> _fetch() async {


    final responseJens = await http.get(Uri.parse(jensApiUrl));
    final dataJens = json.decode(responseJens.body);

    final responseSize = await http.get(Uri.parse(sizeApiUrl));
    final dataSize = json.decode(responseSize.body);

    final responseKarbari = await http.get(Uri.parse(karbariApiUrl));
    final dataKarbari = json.decode(responseKarbari.body);

    final responsePaperSize = await http.get(Uri.parse(apiUrlPaperSize));
    final dataPaperSize = json.decode(responsePaperSize.body);

    final responseBank = await http.get(Uri.parse(bankApiUrl));
    final dataBank = json.decode(responseBank.body);

    setState(() {


      _loadedJens = dataJens['data'];
      _loadedSize = dataSize['data'];

      _loadedKarbari = dataKarbari['data'];
      _loadedPaperSize = dataPaperSize['data'];
      _loadedBank = dataBank['data'];
    });
    _loadedSize.add({
      'id': 0,
      'jens_id': 0,
      'karbari_id': 0,
      'name': 'سایر',
      'paperTool': 0,
      'paperArz': 0,
      'created_at': null,
      'updated_at': null
    });
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchOrders();
    _fetch();
  }

  Future<http.Response> delete(int id) {
    return http.delete(
      Uri.parse("$orderApiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  void onPressDeleteOrder() async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await delete(_selectedOrderId!);
    print(response.body);
    _fetchOrders();
    setState(() {
      _isLoading = false;
    });
  }

  void onPressUpdateOrder() async {
    setState(() {
      _isLoading = true;
    });

    Navigator.pop(context);
    http.Response response = await updateOrder(
        _selectedOrderId!,
        _selectedOrderNumber!,
        _selectedStatusId!,
        _selectedTarafHesabId!,
        _selectedJensId!,
        _selectedKarbariId!,
        _selectedSizeId!,
        _selectedTedad!,
        _selectedPrintingColorId!,
        _selectedSelefonId!,
        _selectedTalakoobId!,
        _selectedUvId!,
        _selectedLetterPressId!,
        _selectedSahafiId!,
        _selectedTotalPrice!,
        _selectedBeyanehPrice!,
        _selectedBeyanehDate!,
        _selectedBankId!,
        _size_ekhtesasi,
        _paperSizeId);
    print(response.body);
    _fetchOrders();


    setState(() {
      _isLoading = false;
    });
  }

  Future<http.Response> updateOrder(
      int id,
      String order_number,
      String status_id,
      String taraf_hesab_id,
      String jens_id,
      String karbari_id,
      String size_id,
      String tedad,
      String printing_color,
      String selefon_id,
      String talakoob_id,
      String uv_id,
      String letter_press_id,
      String sahafi_id,
      String total_price,
      String peyaneh_price,
      String order_date,
      String bank_id,
      String size_ekhtesasi,
      String paper_sizes_id) {
    return http.put(
      Uri.parse("$orderApiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'order_number': int.parse(order_number),
        'status_id': int.parse(status_id),
        'taraf_hesab_id': int.parse(taraf_hesab_id),
        'jens_id': int.parse(jens_id),
        'karbari_id': int.parse(karbari_id),
        'size_id': int.parse(size_id),
        'tedad': int.parse(tedad),
        'printing_color': int.parse(printing_color),
        'selefon_id': int.parse(selefon_id),
        'talakoob_id': int.parse(talakoob_id),
        'uv_id': int.parse(uv_id),
        'letter_press_id': int.parse(letter_press_id),
        'sahafi_id': int.parse(sahafi_id),
        'total_price': int.parse(total_price),
        'peyaneh_price': int.parse(peyaneh_price),
        'order_date': order_date,
        'bank_id': int.parse(bank_id),
      }),
    );
  }

  String getTarafHesabNameById(int tarafHesabId) {
    final foundedTarafHesab = _loadedTarafHesab
        .singleWhere((element) => element['id'] == tarafHesabId);
    return foundedTarafHesab['name'];
  }

  String getJensNameById(int jensId) {
    final foundedTarafHesab =
        _loadedJens.singleWhere((element) => element['id'] == jensId);
    return foundedTarafHesab['name'];
  }

  String getSizeNameById(int sizeId) {
    final foundedTarafHesab =
        _loadedSize.singleWhere((element) => element['id'] == sizeId);
    return foundedTarafHesab['name'];
  }

  String getStatusNameById(int statusId) {
    final foundedStatus =
        _loadedStatus.singleWhere((element) => element['id'] == statusId);
    return foundedStatus['name'];
  }

  String formatPrice(String my_price) {
    String price = my_price;
    String priceInText = "";
    int counter = 0;
    for (int i = (price.length - 1); i >= 0; i--) {
      counter++;
      String str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = "$str$priceInText";
      } else if (i == 0) {
        priceInText = "$str$priceInText";
      } else {
        priceInText = ",$str$priceInText";
      }
    }
    return priceInText.trim();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'IranYekan',
        primarySwatch: Palette.mySecondColor,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        initialIndex: 2,
        child: Column(
          children: [
            Container(
              color: Palette.mySecondColor,
              constraints: const BoxConstraints.expand(height: 50),
              child: const TabBar(
                indicatorColor: Palette.myFirstColor,
                indicatorWeight: 4,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'IranYekan',
                    fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    TextStyle(fontSize: 14.0, fontFamily: 'IranYekan'),
                tabs: [
                  Tab(
                    text: 'ارسال شده',
                  ),
                  Tab(
                    text: 'در انتظار تسویه',
                  ),
                  Tab(
                    text: 'در جریان',
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width
                    : 600,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: kIsWeb
                              ? const EdgeInsets.only(
                                  top: 20, bottom: 30, right: 20, left: 20)
                              : const EdgeInsets.only(
                                  bottom: 30, right: 20, left: 20),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Center(
                                  child: _ersalShodeOrder.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: _ersalShodeOrder.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: SizedBox(
                                              height: 60,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    alignment: Alignment.center,
                                                    onPrimary: Theme.of(context)
                                                        .primaryColor,
                                                    elevation: 4,
                                                    primary: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _selectedOrderId =
                                                        _ersalShodeOrder[index]
                                                            ['id'];
                                                    _selectedOrderNumber =
                                                        _ersalShodeOrder[index]
                                                            ['order_number'];
                                                    _selectedStatusId =
                                                        _ersalShodeOrder[index]
                                                                ['status_id']
                                                            .toString();
                                                    _selectedTarafHesabId =
                                                        _ersalShodeOrder[index][
                                                                'taraf_hesab_id']
                                                            .toString();
                                                    _selectedJensId =
                                                        _ersalShodeOrder[index]
                                                                ['jens_id']
                                                            .toString();
                                                    _selectedKarbariId =
                                                        _ersalShodeOrder[index]
                                                                ['karbari_id']
                                                            .toString();
                                                    _selectedSizeId =
                                                        _ersalShodeOrder[index]
                                                                ['size_id']
                                                            .toString();

                                                    int.parse(_selectedSizeId!) ==
                                                            0
                                                        ? _isVisible = true
                                                        : _isVisible = false;

                                                    _selectedSizeEkhtesasi = int
                                                                .parse(
                                                                    _selectedSizeId!) ==
                                                            0
                                                        ? _ersalShodeOrder[
                                                                    index][
                                                                'size_ekhtesasi']
                                                            .toString()
                                                        : null;
                                                    _selectedPaperSizeId = int
                                                                .parse(
                                                                    _selectedSizeId!) ==
                                                            0
                                                        ? _ersalShodeOrder[
                                                                    index][
                                                                'size_ekhtesasi']
                                                            .toString()
                                                        : null;

                                                    _selectedTedad =
                                                        _ersalShodeOrder[index]
                                                                ['tedad']
                                                            .toString();
                                                    _selectedPrintingColorId =
                                                        _ersalShodeOrder[index][
                                                                'printing_color']
                                                            .toString();
                                                    _selectedSelefonId =
                                                        _ersalShodeOrder[index]
                                                                ['selefon_id']
                                                            .toString();
                                                    ;
                                                    _selectedTalakoobId =
                                                        _ersalShodeOrder[index]
                                                                ['talakoob_id']
                                                            .toString();
                                                    _selectedUvId =
                                                        _ersalShodeOrder[index]
                                                                ['uv_id']
                                                            .toString();
                                                    _selectedLetterPressId =
                                                        _ersalShodeOrder[index][
                                                                'letter_press_id']
                                                            .toString();
                                                    _selectedSahafiId =
                                                        _ersalShodeOrder[index]
                                                                ['sahafi_id']
                                                            .toString();
                                                    _selectedTotalPrice =
                                                        _ersalShodeOrder[index]
                                                                ['total_price']
                                                            .toString();

                                                    _filteredPayment = _loadedPayment
                                                        .where((element) =>
                                                            element['order_id']
                                                                .toString() ==
                                                            _selectedOrderId
                                                                .toString())
                                                        .toList();

                                                    _filteredKarbari =
                                                        _loadedKarbari
                                                            .where((element) =>
                                                                element['jens_id']
                                                                    .toString() ==
                                                                _selectedJensId
                                                                    .toString())
                                                            .toList();
                                                    _filteredSize = _loadedSize
                                                        .where((element) =>
                                                            element['karbari_id']
                                                                    .toString() ==
                                                                _selectedKarbariId
                                                                    .toString() ||
                                                            element['karbari_id']
                                                                    .toString() ==
                                                                "0")
                                                        .toList();

                                                    _selectedBeyanehPrice =
                                                        _filteredPayment[0]
                                                                ['mosbat_price']
                                                            .toString();
                                                    _selectedBeyanehDate =
                                                        _filteredPayment[0]
                                                            ['date'];
                                                    _selectedBankId =
                                                        _filteredPayment[0]
                                                                ['bank_id']
                                                            .toString();

                                                    showModalBottomSheet(
                                                        useRootNavigator: true,
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        // Add this line of Code
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext
                                                                        context,
                                                                    setState) =>
                                                                Container(
                                                              height: kIsWeb ?  MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height -
                                                                  120 :  MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height -
                                                                  90,
                                                              color: Colors
                                                                  .transparent,
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20.0),
                                                                        topRight:
                                                                            Radius.circular(20.0))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 40,
                                                                  ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            "شماره سفارش : $_selectedOrderNumber",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Palette.myFirstColor,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(height: 10,),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'وضعیت سفارش',
                                                                              "وضعیت سفارش را انتخاب کنید",
                                                                              _selectedStatusId,
                                                                              orderStatus,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedStatusId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'طرف حساب',
                                                                              "طرف حساب را انتخاب کنید",
                                                                              _selectedTarafHesabId,
                                                                              _loadedTarafHesab,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedTarafHesabId = onChangedVal! ?? "";
                                                                            });
                                                                          }, (onValidateVal) {
                                                                            if (onValidateVal ==
                                                                                null) {
                                                                              return "طرف حساب را انتخاب کنید";
                                                                            }
                                                                            return null;
                                                                          },
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              contentPadding: 10,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          //////////////////////////////////////// Jens Deopdown //////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'جنس سفارش',
                                                                              "جنس را انتخاب کنید",
                                                                              _selectedJensId,
                                                                              _loadedJens,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedJensId = onChangedVal! ?? "";
                                                                              _selectedKarbariId = null;
                                                                              _selectedSizeId = null;
                                                                              _filteredKarbari = _loadedKarbari.where((element) => element['jens_id'].toString() == _selectedJensId.toString()).toList();
                                                                            });
                                                                          }, (onValidateVal) {
                                                                            if (onValidateVal ==
                                                                                null) {
                                                                              return "جنس را انتخاب کنید";
                                                                            }
                                                                            return null;
                                                                          },
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              contentPadding: 10,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          //////////////////////////////////////// Jens Deopdown ///////////////////////////////////////

                                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'کاربری',
                                                                              "کاربری را انتخاب کنید",
                                                                              _selectedKarbariId,
                                                                              _filteredKarbari,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedKarbariId = onChangedVal;
                                                                              _selectedSizeId = null;
                                                                              _filteredSize = _loadedSize.where((element) => element['karbari_id'].toString() == _selectedKarbariId.toString() || element['karbari_id'].toString() == "0").toList();
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'سایز سفارش',
                                                                              "سایز را انتخاب کنید",
                                                                              _selectedSizeId,
                                                                              _filteredSize,
                                                                              (onChangedVal) {
                                                                            print(_isVisible);
                                                                            setState(() {
                                                                              _selectedSizeId = onChangedVal;
                                                                              int.parse(_selectedSizeId!) == 0 ? _isVisible = true : _isVisible = false;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          Visibility(
                                                                            visible:
                                                                                _isVisible,
                                                                            child: MyTextboxTitle(
                                                                                title: 'سایز اختصاصی',
                                                                                isNumber: false,
                                                                                isPrice: false,
                                                                                lengthLimit: 0,
                                                                                callback: (value) => _size_ekhtesasi = value),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                _isVisible,
                                                                            child: MyWidgets.dropDownWidget(
                                                                                context,
                                                                                'اندازه کاغذ',
                                                                                "اندازه کاغذ را انتخاب کنید",
                                                                                _paperSizeId,
                                                                                _loadedPaperSize,
                                                                                (onChangedVal) {
                                                                              setState(() {
                                                                                _paperSizeId = onChangedVal;
                                                                              });
                                                                            }, (onValidateVal) => null,
                                                                                borderFocusColor: Palette.myFirstColor,
                                                                                borderColor: Theme.of(context).primaryColor,
                                                                                optionValue: "id",
                                                                                optionLabel: "name"),
                                                                          ),

                                                                          MyTextboxTitle(
                                                                              title: 'تعداد',
                                                                              isNumber: true,
                                                                              isPrice: false,
                                                                              lengthLimit: 0,
                                                                              initialText: _selectedTedad,
                                                                              callback: (value) => _selectedTedad = value.toString()),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'تعداد رنگ چاپ',
                                                                              "تعداد رنگ چاپ را انتخاب کنید",
                                                                              _selectedPrintingColorId,
                                                                              printingColor,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedPrintingColorId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'سلفون',
                                                                              "وضعیت سلفون را انتخاب کنید",
                                                                              _selectedSelefonId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedSelefonId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'طلاکوب',
                                                                              "وضعیت طلاکوب را انتخاب کنید",
                                                                              _selectedTalakoobId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedTalakoobId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'یووی و امباس',
                                                                              "وضعیت یووی را انتخاب کنید",
                                                                              _selectedUvId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedUvId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'لترپرس و خط تا برجسته',
                                                                              "وضعیت لترپرس را انتخاب کنید",
                                                                              _selectedLetterPressId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedLetterPressId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'صحافی و بسته بندی',
                                                                              "وضعیت صحافی را انتخاب کنید",
                                                                              _selectedSahafiId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedSahafiId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyTextboxTitle(
                                                                              title: 'مبلغ کل سفارش',
                                                                              isNumber: true,
                                                                              isPrice: true,
                                                                              lengthLimit: 0,
                                                                              initialText: formatPrice(_selectedTotalPrice!),
                                                                              callback: (value) => _selectedTotalPrice = value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                                                                          MyTextboxTitle(
                                                                              title: 'مبلغ بیعانه',
                                                                              isNumber: true,
                                                                              isPrice: true,
                                                                              lengthLimit: 0,
                                                                              initialText: formatPrice(_selectedBeyanehPrice!),
                                                                              callback: (value) => _selectedBeyanehPrice = value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                                                                          MyDatePicker(
                                                                              title: 'تاریخ واریز بیعانه',
                                                                              initialDate: _selectedBeyanehDate,
                                                                              callback: (jalaliDate, georgianDate) =>
                                                                              _selectedBeyanehDate = georgianDate),
                                                                          ////////////////////////////////////// Size Deopdown /////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'بانک واریز بیعانه',
                                                                              "بانک را انتخاب کنید",
                                                                              _selectedBankId,
                                                                              _loadedBank,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedBankId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                            width: MediaQuery.of(context).size.width < 600
                                                                                ? MediaQuery.of(context).size.width
                                                                                : 600,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                MyButton(text: 'ذخیره', callback: onPressUpdateOrder),
                                                                                MyButton(text: 'حذف سفارش', callback: onPressDeleteOrder),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.person,
                                                              color: Palette
                                                                  .myFirstColor,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              getTarafHesabNameById(
                                                                  _ersalShodeOrder[
                                                                          index]
                                                                      [
                                                                      'taraf_hesab_id']),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'شماره سفارش : ${_ersalShodeOrder[index]['order_number']}',
                                                              style: const TextStyle(
                                                                  color: Palette
                                                                      .myFirstColor,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'وضعیت : ${getStatusNameById(_ersalShodeOrder[index]['status_id'])}',
                                                              style: const TextStyle(
                                                                  color: Palette
                                                                      .myFirstColor,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'سفارشی یافت نشد',
                                            style: TextStyle(
                                                color: Palette.myFirstColor,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'IranYekan',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                ),
                        ),
                        Padding(
                          padding: kIsWeb
                              ? const EdgeInsets.only(
                                  top: 20, bottom: 30, right: 20, left: 20)
                              : const EdgeInsets.only(
                                  bottom: 30, right: 20, left: 20),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Center(
                                  child: _darEntezarOrder.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: _darEntezarOrder.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: SizedBox(
                                              height: 60,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    alignment: Alignment.center,
                                                    onPrimary: Theme.of(context)
                                                        .primaryColor,
                                                    elevation: 4,
                                                    primary: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _selectedOrderId =
                                                        _darEntezarOrder[index]
                                                            ['id'];
                                                    _selectedOrderNumber =
                                                        _darEntezarOrder[index]
                                                            ['order_number'];
                                                    _selectedStatusId =
                                                        _darEntezarOrder[index]
                                                                ['status_id']
                                                            .toString();
                                                    _selectedTarafHesabId =
                                                        _darEntezarOrder[index][
                                                                'taraf_hesab_id']
                                                            .toString();
                                                    _selectedJensId =
                                                        _darEntezarOrder[index]
                                                                ['jens_id']
                                                            .toString();
                                                    _selectedKarbariId =
                                                        _darEntezarOrder[index]
                                                                ['karbari_id']
                                                            .toString();
                                                    _selectedSizeId =
                                                        _darEntezarOrder[index]
                                                                ['size_id']
                                                            .toString();

                                                    int.parse(_selectedSizeId!) ==
                                                            0
                                                        ? _isVisible = true
                                                        : _isVisible = false;

                                                    _selectedSizeEkhtesasi = int
                                                                .parse(
                                                                    _selectedSizeId!) ==
                                                            0
                                                        ? _darEntezarOrder[
                                                                    index][
                                                                'size_ekhtesasi']
                                                            .toString()
                                                        : null;
                                                    _selectedPaperSizeId = int
                                                                .parse(
                                                                    _selectedSizeId!) ==
                                                            0
                                                        ? _darEntezarOrder[
                                                                    index][
                                                                'size_ekhtesasi']
                                                            .toString()
                                                        : null;

                                                    _selectedTedad =
                                                        _darEntezarOrder[index]
                                                                ['tedad']
                                                            .toString();
                                                    _selectedPrintingColorId =
                                                        _darEntezarOrder[index][
                                                                'printing_color']
                                                            .toString();
                                                    _selectedSelefonId =
                                                        _darEntezarOrder[index]
                                                                ['selefon_id']
                                                            .toString();
                                                    ;
                                                    _selectedTalakoobId =
                                                        _darEntezarOrder[index]
                                                                ['talakoob_id']
                                                            .toString();
                                                    _selectedUvId =
                                                        _darEntezarOrder[index]
                                                                ['uv_id']
                                                            .toString();
                                                    _selectedLetterPressId =
                                                        _darEntezarOrder[index][
                                                                'letter_press_id']
                                                            .toString();
                                                    _selectedSahafiId =
                                                        _darEntezarOrder[index]
                                                                ['sahafi_id']
                                                            .toString();
                                                    _selectedTotalPrice =
                                                        _darEntezarOrder[index]
                                                                ['total_price']
                                                            .toString();

                                                    _filteredPayment = _loadedPayment
                                                        .where((element) =>
                                                            element['order_id']
                                                                .toString() ==
                                                            _selectedOrderId
                                                                .toString())
                                                        .toList();

                                                    _filteredKarbari =
                                                        _loadedKarbari
                                                            .where((element) =>
                                                                element['jens_id']
                                                                    .toString() ==
                                                                _selectedJensId
                                                                    .toString())
                                                            .toList();
                                                    _filteredSize = _loadedSize
                                                        .where((element) =>
                                                            element['karbari_id']
                                                                    .toString() ==
                                                                _selectedKarbariId
                                                                    .toString() ||
                                                            element['karbari_id']
                                                                    .toString() ==
                                                                "0")
                                                        .toList();

                                                    _selectedBeyanehPrice =
                                                        _filteredPayment[0]
                                                                ['mosbat_price']
                                                            .toString();
                                                    _selectedBeyanehDate =
                                                        _filteredPayment[0]
                                                            ['date'];
                                                    _selectedBankId =
                                                        _filteredPayment[0]
                                                                ['bank_id']
                                                            .toString();

                                                    showModalBottomSheet(
                                                        useRootNavigator: true,
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        // Add this line of Code
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext
                                                                        context,
                                                                    setState) =>
                                                                Container(
                                                                  height: kIsWeb ?  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height -
                                                                      120 :  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height -
                                                                      90,
                                                              color: Colors
                                                                  .transparent,
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20.0),
                                                                        topRight:
                                                                            Radius.circular(20.0))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 40,
                                                                  ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            "شماره سفارش : $_selectedOrderNumber",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Palette.myFirstColor,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(height: 10,),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'وضعیت سفارش',
                                                                              "وضعیت سفارش را انتخاب کنید",
                                                                              _selectedStatusId,
                                                                              orderStatus,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedStatusId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'طرف حساب',
                                                                              "طرف حساب را انتخاب کنید",
                                                                              _selectedTarafHesabId,
                                                                              _loadedTarafHesab,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedTarafHesabId = onChangedVal! ?? "";
                                                                            });
                                                                          }, (onValidateVal) {
                                                                            if (onValidateVal ==
                                                                                null) {
                                                                              return "طرف حساب را انتخاب کنید";
                                                                            }
                                                                            return null;
                                                                          },
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              contentPadding: 10,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          //////////////////////////////////////// Jens Deopdown //////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'جنس سفارش',
                                                                              "جنس را انتخاب کنید",
                                                                              _selectedJensId,
                                                                              _loadedJens,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedJensId = onChangedVal! ?? "";
                                                                              _selectedKarbariId = null;
                                                                              _selectedSizeId = null;
                                                                              _filteredKarbari = _loadedKarbari.where((element) => element['jens_id'].toString() == _selectedJensId.toString()).toList();
                                                                            });
                                                                          }, (onValidateVal) {
                                                                            if (onValidateVal ==
                                                                                null) {
                                                                              return "جنس را انتخاب کنید";
                                                                            }
                                                                            return null;
                                                                          },
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              contentPadding: 10,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          //////////////////////////////////////// Jens Deopdown ///////////////////////////////////////

                                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'کاربری',
                                                                              "کاربری را انتخاب کنید",
                                                                              _selectedKarbariId,
                                                                              _filteredKarbari,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedKarbariId = onChangedVal;
                                                                              _selectedSizeId = null;
                                                                              _filteredSize = _loadedSize.where((element) => element['karbari_id'].toString() == _selectedKarbariId.toString() || element['karbari_id'].toString() == "0").toList();
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'سایز سفارش',
                                                                              "سایز را انتخاب کنید",
                                                                              _selectedSizeId,
                                                                              _filteredSize,
                                                                              (onChangedVal) {
                                                                            print(_isVisible);
                                                                            setState(() {
                                                                              _selectedSizeId = onChangedVal;
                                                                              int.parse(_selectedSizeId!) == 0 ? _isVisible = true : _isVisible = false;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          Visibility(
                                                                            visible:
                                                                                _isVisible,
                                                                            child: MyTextboxTitle(
                                                                                title: 'سایز اختصاصی',
                                                                                isNumber: false,
                                                                                isPrice: false,
                                                                                lengthLimit: 0,
                                                                                callback: (value) => _size_ekhtesasi = value),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                _isVisible,
                                                                            child: MyWidgets.dropDownWidget(
                                                                                context,
                                                                                'اندازه کاغذ',
                                                                                "اندازه کاغذ را انتخاب کنید",
                                                                                _paperSizeId,
                                                                                _loadedPaperSize,
                                                                                (onChangedVal) {
                                                                              setState(() {
                                                                                _paperSizeId = onChangedVal;
                                                                              });
                                                                            }, (onValidateVal) => null,
                                                                                borderFocusColor: Palette.myFirstColor,
                                                                                borderColor: Theme.of(context).primaryColor,
                                                                                optionValue: "id",
                                                                                optionLabel: "name"),
                                                                          ),

                                                                          MyTextboxTitle(
                                                                              title: 'تعداد',
                                                                              isNumber: true,
                                                                              isPrice: false,
                                                                              lengthLimit: 0,
                                                                              initialText: _selectedTedad,
                                                                              callback: (value) => _selectedTedad = value.toString()),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'تعداد رنگ چاپ',
                                                                              "تعداد رنگ چاپ را انتخاب کنید",
                                                                              _selectedPrintingColorId,
                                                                              printingColor,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedPrintingColorId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'سلفون',
                                                                              "وضعیت سلفون را انتخاب کنید",
                                                                              _selectedSelefonId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedSelefonId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'طلاکوب',
                                                                              "وضعیت طلاکوب را انتخاب کنید",
                                                                              _selectedTalakoobId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedTalakoobId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'یووی و امباس',
                                                                              "وضعیت یووی را انتخاب کنید",
                                                                              _selectedUvId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedUvId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'لترپرس و خط تا برجسته',
                                                                              "وضعیت لترپرس را انتخاب کنید",
                                                                              _selectedLetterPressId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedLetterPressId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'صحافی و بسته بندی',
                                                                              "وضعیت صحافی را انتخاب کنید",
                                                                              _selectedSahafiId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedSahafiId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyTextboxTitle(
                                                                              title: 'مبلغ کل سفارش',
                                                                              isNumber: true,
                                                                              isPrice: true,
                                                                              lengthLimit: 0,
                                                                              initialText: formatPrice(_selectedTotalPrice!),
                                                                              callback: (value) => _selectedTotalPrice = value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                                                                          MyTextboxTitle(
                                                                              title: 'مبلغ بیعانه',
                                                                              isNumber: true,
                                                                              isPrice: true,
                                                                              lengthLimit: 0,
                                                                              initialText: formatPrice(_selectedBeyanehPrice!),
                                                                              callback: (value) => _selectedBeyanehPrice = value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                                                                          MyDatePicker(
                                                                              title: 'تاریخ واریز بیعانه',
                                                                              initialDate: _selectedBeyanehDate,
                                                                              callback: (jalaliDate, georgianDate) =>
                                                                              _selectedBeyanehDate = georgianDate),
                                                                          ////////////////////////////////////// Size Deopdown /////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'بانک واریز بیعانه',
                                                                              "بانک را انتخاب کنید",
                                                                              _selectedBankId,
                                                                              _loadedBank,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedBankId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              // borderFocusColor: Palette.myFirstColor,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                            width: MediaQuery.of(context).size.width < 600
                                                                                ? MediaQuery.of(context).size.width
                                                                                : 600,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                MyButton(text: 'ذخیره', callback: onPressUpdateOrder),
                                                                                MyButton(text: 'حذف سفارش', callback: onPressDeleteOrder),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.person,
                                                              color: Palette
                                                                  .myFirstColor,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              getTarafHesabNameById(
                                                                  _darEntezarOrder[
                                                                          index]
                                                                      [
                                                                      'taraf_hesab_id']),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'شماره سفارش : ${_darEntezarOrder[index]['order_number']}',
                                                              style: const TextStyle(
                                                                  color: Palette
                                                                      .myFirstColor,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'وضعیت : ${getStatusNameById(_darEntezarOrder[index]['status_id'])}',
                                                              style: const TextStyle(
                                                                  color: Palette
                                                                      .myFirstColor,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'سفارشی یافت نشد',
                                            style: TextStyle(
                                                color: Palette.myFirstColor,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'IranYekan',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                ),
                        ),
                        Padding(
                          padding: kIsWeb
                              ? const EdgeInsets.only(
                                  top: 20, bottom: 30, right: 20, left: 20)
                              : const EdgeInsets.only(
                                  bottom: 30, right: 20, left: 20),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Center(
                                  child: _darJaryanOrder.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: _darJaryanOrder.length,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: SizedBox(
                                              height: 60,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    alignment: Alignment.center,
                                                    onPrimary: Theme.of(context)
                                                        .primaryColor,
                                                    elevation: 4,
                                                    primary: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _selectedOrderId =
                                                        _darJaryanOrder[index]
                                                            ['id'];
                                                    _selectedOrderNumber =
                                                        _darJaryanOrder[index]
                                                            ['order_number'];
                                                    _selectedStatusId =
                                                        _darJaryanOrder[index]
                                                                ['status_id']
                                                            .toString();
                                                    _selectedTarafHesabId =
                                                        _darJaryanOrder[index][
                                                                'taraf_hesab_id']
                                                            .toString();
                                                    _selectedJensId =
                                                        _darJaryanOrder[index]
                                                                ['jens_id']
                                                            .toString();
                                                    _selectedKarbariId =
                                                        _darJaryanOrder[index]
                                                                ['karbari_id']
                                                            .toString();
                                                    _selectedSizeId =
                                                        _darJaryanOrder[index]
                                                                ['size_id']
                                                            .toString();

                                                    int.parse(_selectedSizeId!) ==
                                                            0
                                                        ? _isVisible = true
                                                        : _isVisible = false;

                                                    _selectedSizeEkhtesasi = int
                                                                .parse(
                                                                    _selectedSizeId!) ==
                                                            0
                                                        ? _darJaryanOrder[index]
                                                                [
                                                                'size_ekhtesasi']
                                                            .toString()
                                                        : null;
                                                    _selectedPaperSizeId = int
                                                                .parse(
                                                                    _selectedSizeId!) ==
                                                            0
                                                        ? _darJaryanOrder[index]
                                                                [
                                                                'size_ekhtesasi']
                                                            .toString()
                                                        : null;

                                                    _selectedTedad =
                                                        _darJaryanOrder[index]
                                                                ['tedad']
                                                            .toString();
                                                    _selectedPrintingColorId =
                                                        _darJaryanOrder[index][
                                                                'printing_color']
                                                            .toString();
                                                    _selectedSelefonId =
                                                        _darJaryanOrder[index]
                                                                ['selefon_id']
                                                            .toString();
                                                    ;
                                                    _selectedTalakoobId =
                                                        _darJaryanOrder[index]
                                                                ['talakoob_id']
                                                            .toString();
                                                    _selectedUvId =
                                                        _darJaryanOrder[index]
                                                                ['uv_id']
                                                            .toString();
                                                    _selectedLetterPressId =
                                                        _darJaryanOrder[index][
                                                                'letter_press_id']
                                                            .toString();
                                                    _selectedSahafiId =
                                                        _darJaryanOrder[index]
                                                                ['sahafi_id']
                                                            .toString();
                                                    _selectedTotalPrice =
                                                        _darJaryanOrder[index]
                                                                ['total_price']
                                                            .toString();

                                                    _filteredPayment = _loadedPayment
                                                        .where((element) =>
                                                            element['order_id']
                                                                .toString() ==
                                                            _selectedOrderId
                                                                .toString())
                                                        .toList();

                                                    _filteredKarbari =
                                                        _loadedKarbari
                                                            .where((element) =>
                                                                element['jens_id']
                                                                    .toString() ==
                                                                _selectedJensId
                                                                    .toString())
                                                            .toList();
                                                    _filteredSize = _loadedSize
                                                        .where((element) =>
                                                            element['karbari_id']
                                                                    .toString() ==
                                                                _selectedKarbariId
                                                                    .toString() ||
                                                            element['karbari_id']
                                                                    .toString() ==
                                                                "0")
                                                        .toList();

                                                    _selectedBeyanehPrice =
                                                        _filteredPayment[0]
                                                                ['mosbat_price']
                                                            .toString();
                                                    _selectedBeyanehDate =
                                                        _filteredPayment[0]
                                                            ['date'];
                                                    _selectedBankId =
                                                        _filteredPayment[0]
                                                                ['bank_id']
                                                            .toString();

                                                    showModalBottomSheet(
                                                        useRootNavigator: true,
                                                        isScrollControlled:
                                                            true,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        // Add this line of Code
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                            builder: (BuildContext
                                                                        context,
                                                                    setState) =>
                                                                Container(
                                                                  height: kIsWeb ?  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height -
                                                                      120 :  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height -
                                                                      90,
                                                              color: Colors
                                                                  .transparent,
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20.0),
                                                                        topRight:
                                                                            Radius.circular(20.0))),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    top: 40,
                                                                  ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Text(
                                                                            "شماره سفارش : $_selectedOrderNumber",
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Palette.myFirstColor,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(height: 10,),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'وضعیت سفارش',
                                                                              "وضعیت سفارش را انتخاب کنید",
                                                                              _selectedStatusId,
                                                                              orderStatus,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedStatusId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'طرف حساب',
                                                                              "طرف حساب را انتخاب کنید",
                                                                              _selectedTarafHesabId,
                                                                              _loadedTarafHesab,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedTarafHesabId = onChangedVal! ?? "";
                                                                            });
                                                                          }, (onValidateVal) {
                                                                            if (onValidateVal ==
                                                                                null) {
                                                                              return "طرف حساب را انتخاب کنید";
                                                                            }
                                                                            return null;
                                                                          },
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              contentPadding: 10,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          //////////////////////////////////////// Jens Deopdown //////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'جنس سفارش',
                                                                              "جنس را انتخاب کنید",
                                                                              _selectedJensId,
                                                                              _loadedJens,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedJensId = onChangedVal! ?? "";
                                                                              _selectedKarbariId = null;
                                                                              _selectedSizeId = null;
                                                                              _filteredKarbari = _loadedKarbari.where((element) => element['jens_id'].toString() == _selectedJensId.toString()).toList();
                                                                            });
                                                                          }, (onValidateVal) {
                                                                            if (onValidateVal ==
                                                                                null) {
                                                                              return "جنس را انتخاب کنید";
                                                                            }
                                                                            return null;
                                                                          },
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              contentPadding: 10,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          //////////////////////////////////////// Jens Deopdown ///////////////////////////////////////

                                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'کاربری',
                                                                              "کاربری را انتخاب کنید",
                                                                              _selectedKarbariId,
                                                                              _filteredKarbari,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedKarbariId = onChangedVal;
                                                                              _selectedSizeId = null;
                                                                              _filteredSize = _loadedSize.where((element) => element['karbari_id'].toString() == _selectedKarbariId.toString() || element['karbari_id'].toString() == "0").toList();
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'سایز سفارش',
                                                                              "سایز را انتخاب کنید",
                                                                              _selectedSizeId,
                                                                              _filteredSize,
                                                                              (onChangedVal) {
                                                                            print(_isVisible);
                                                                            setState(() {
                                                                              _selectedSizeId = onChangedVal;
                                                                              int.parse(_selectedSizeId!) == 0 ? _isVisible = true : _isVisible = false;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),

                                                                          Visibility(
                                                                            visible:
                                                                                _isVisible,
                                                                            child: MyTextboxTitle(
                                                                                title: 'سایز اختصاصی',
                                                                                isNumber: false,
                                                                                isPrice: false,
                                                                                lengthLimit: 0,
                                                                                callback: (value) => _size_ekhtesasi = value),
                                                                          ),
                                                                          Visibility(
                                                                            visible:
                                                                                _isVisible,
                                                                            child: MyWidgets.dropDownWidget(
                                                                                context,
                                                                                'اندازه کاغذ',
                                                                                "اندازه کاغذ را انتخاب کنید",
                                                                                _paperSizeId,
                                                                                _loadedPaperSize,
                                                                                (onChangedVal) {
                                                                              setState(() {
                                                                                _paperSizeId = onChangedVal;
                                                                              });
                                                                            }, (onValidateVal) => null,
                                                                                borderFocusColor: Palette.myFirstColor,
                                                                                borderColor: Theme.of(context).primaryColor,
                                                                                optionValue: "id",
                                                                                optionLabel: "name"),
                                                                          ),

                                                                          MyTextboxTitle(
                                                                              title: 'تعداد',
                                                                              isNumber: true,
                                                                              isPrice: false,
                                                                              lengthLimit: 0,
                                                                              initialText: _selectedTedad,
                                                                              callback: (value) => _selectedTedad = value.toString()),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'تعداد رنگ چاپ',
                                                                              "تعداد رنگ چاپ را انتخاب کنید",
                                                                              _selectedPrintingColorId,
                                                                              printingColor,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedPrintingColorId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'سلفون',
                                                                              "وضعیت سلفون را انتخاب کنید",
                                                                              _selectedSelefonId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedSelefonId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'طلاکوب',
                                                                              "وضعیت طلاکوب را انتخاب کنید",
                                                                              _selectedTalakoobId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedTalakoobId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'یووی و امباس',
                                                                              "وضعیت یووی را انتخاب کنید",
                                                                              _selectedUvId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedUvId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'لترپرس و خط تا برجسته',
                                                                              "وضعیت لترپرس را انتخاب کنید",
                                                                              _selectedLetterPressId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedLetterPressId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'صحافی و بسته بندی',
                                                                              "وضعیت صحافی را انتخاب کنید",
                                                                              _selectedSahafiId,
                                                                              orderAttribute,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedSahafiId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          MyTextboxTitle(
                                                                              title: 'مبلغ کل سفارش',
                                                                              isNumber: true,
                                                                              isPrice: true,
                                                                              lengthLimit: 0,
                                                                              initialText: formatPrice(_selectedTotalPrice!),
                                                                              callback: (value) => _selectedTotalPrice = value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                                                                          MyTextboxTitle(
                                                                              title: 'مبلغ بیعانه',
                                                                              isNumber: true,
                                                                              isPrice: true,
                                                                              lengthLimit: 0,
                                                                              initialText: formatPrice(_selectedBeyanehPrice!),
                                                                              callback: (value) => _selectedBeyanehPrice = value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                                                                          MyDatePicker(
                                                                              title: 'تاریخ واریز بیعانه',
                                                                              initialDate: _selectedBeyanehDate,
                                                                              callback: (jalaliDate, georgianDate) =>
                                                                              _selectedBeyanehDate = georgianDate),
                                                                          ////////////////////////////////////// Size Deopdown /////////////////////////////////////
                                                                          MyWidgets.dropDownWidget(
                                                                              context,
                                                                              'بانک واریز بیعانه',
                                                                              "بانک را انتخاب کنید",
                                                                              _selectedBankId,
                                                                              _loadedBank,
                                                                              (onChangedVal) {
                                                                            setState(() {
                                                                              _selectedBankId = onChangedVal;
                                                                            });
                                                                          }, (onValidateVal) => null,
                                                                              borderFocusColor: Palette.myFirstColor,
                                                                              borderColor: Colors.grey,
                                                                              optionValue: "id",
                                                                              optionLabel: "name"),
                                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                          const SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                            width: MediaQuery.of(context).size.width < 600
                                                                                ? MediaQuery.of(context).size.width
                                                                                : 600,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                MyButton(text: 'ذخیره', callback: onPressUpdateOrder),
                                                                                MyButton(text: 'حذف سفارش', callback: onPressDeleteOrder),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.person,
                                                              color: Palette
                                                                  .myFirstColor,
                                                              size: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              getTarafHesabNameById(
                                                                  _darJaryanOrder[
                                                                          index]
                                                                      [
                                                                      'taraf_hesab_id']),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'شماره سفارش : ${_darJaryanOrder[index]['order_number']}',
                                                              style: const TextStyle(
                                                                  color: Palette
                                                                      .myFirstColor,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'وضعیت : ${getStatusNameById(_darJaryanOrder[index]['status_id'])}',
                                                              style: const TextStyle(
                                                                  color: Palette
                                                                      .myFirstColor,
                                                                  fontFamily:
                                                                      'IranYekan',
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'سفارشی یافت نشد',
                                            style: TextStyle(
                                                color: Palette.myFirstColor,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'IranYekan',
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
