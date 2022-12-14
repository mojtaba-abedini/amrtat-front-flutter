import 'dart:convert';
import 'package:amertat/api.dart';
import 'package:amertat/widgets/button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:amertat/store.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/my_widget.dart';
import '../../widgets/textbox_title.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

StreamController<String> streamController = StreamController<String>();

class NewOrder extends StatefulWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  bool _isLoading = true;
  bool _isVisible = false;
  late String name;
  String phone = "";
  String address = "";
  String? date;

  String? _selefonId;
  String? _talakoobId;
  String? _printingColorId;
  String? _uvId;
  String? _letterPressId;
  String? _sahafiId;
  String? _selectedJensId;
  String? _selectedKarbariId;
  String? _selectedSizeId;
  String? _selectedBankId;
  String? _orderStatusId;
  String? _selectedTarafHesabId;
  String? _tedad;

  String? _totalPrice;
  String? _beyanePrice;
  String? _orderDate;
  String _size_ekhtesasi = "";
  String _paperSizeId = "";

  int orderNumber = 2845548;

  List _loadedPaperSize = [];
  List _loadedJens = [];
  List _loadedTarafHesab = [];
  List _loadedSize = [];
  List _loadedKarbari = [];
  List _loadedBank = [];
  List _filteredSize = [];
  List _filteredKarbari = [];
  var _loadedId = [];

  static const jensApiUrl = JensApi;
  static const karbariApiUrl = KarbariApi;
  static const sizeApiUrl = SizeApi;
  static const bankApiUrl = BankApi;
  static const tarafHesabApiUrl = TarafHesabApi;
  static const orderApiUrl = OrderApi;
  static const apiUrlPaperSize = PaperSizeApi;

  void onPressAddTarafHesab() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);
    http.Response response = await create(name, phone, address);
    print(response.body);

    _fetchTarafHesab().then((value) =>
        _selectedTarafHesabId = _loadedId[_loadedId.length - 1].toString());
  }

  Future<http.Response> create(String name, String phone, String address) {
    return http.post(
      Uri.parse(TarafHesabApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'phone': phone,
        'address': address,
      }),
    );
  }

  void onPressAddOrder() async {

    setState(() {
      _isLoading = true;
    });

    Navigator.pop(context, true);
    http.Response response = await createOrder(
        _orderStatusId!,
        _selectedTarafHesabId!,
        _selectedJensId!,
        _selectedKarbariId!,
        _selectedSizeId!,
        _tedad!,
        _printingColorId!,
        _selefonId!,
        _talakoobId!,
        _uvId!,
        _letterPressId!,
        _sahafiId!,
        _totalPrice!,
        _beyanePrice!,
        _orderDate!,
        _selectedBankId!,
        _size_ekhtesasi,
        _paperSizeId);
    print(response.body);
  }

  Future<http.Response> createOrder(
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
    return http.post(
      Uri.parse(orderApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
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

  Future<void> _fetchJens() async {
    final response = await http.get(Uri.parse(jensApiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedJens = data['data'];
    });
  }

  Future<void> _fetchKarbari() async {
    final response = await http.get(Uri.parse(karbariApiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedKarbari = data['data'];
    });
  }

  Future<void> _fetchSize() async {
    final response = await http.get(Uri.parse(sizeApiUrl));
    final data = json.decode(response.body);

    final responsePaperSize = await http.get(Uri.parse(apiUrlPaperSize));
    final dataPaperSize = json.decode(responsePaperSize.body);

    setState(() {
      _loadedSize = data['data'];
      _loadedPaperSize = dataPaperSize['data'];
    });
    _loadedSize.add({
      'id': 0,
      'jens_id': 0,
      'karbari_id': 0,
      'name': '????????',
      'paperTool': 0,
      'paperArz': 0,
      'created_at': null,
      'updated_at': null
    });
  }

  Future<void> _fetchBank() async {
    final response = await http.get(Uri.parse(bankApiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedBank = data['data'];
    });
  }

  Future<void> _fetchTarafHesab() async {
    final response = await http.get(Uri.parse(tarafHesabApiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedTarafHesab = data['data'];
    });

    _loadedTarafHesab.forEach((n) => {_loadedId.add(n['id'])});
    _loadedId.sort();

    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchJens();
    _fetchKarbari();
    _fetchBank();
    _fetchSize();
    _fetchTarafHesab();
  }

  void onPressButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('?????? ?????????? ????????'),
          toolbarHeight: 75,
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    // Text(
                    //   "?????????? ?????????? : $orderNumber",
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold,
                    //       color: Theme.of(context).primaryColor),
                    // ),
                    MyWidgets.dropDownWidget(
                        context,
                        '?????????? ??????????',
                        "?????????? ?????????? ???? ???????????? ????????",
                        _orderStatusId,
                        orderStatus, (onChangedVal) {
                      setState(() {
                        _orderStatusId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width
                          : 640),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              width: 55,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: MyButton(
                                  text: '+',
                                  callback: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        // Add this line of Code
                                        builder: (builder) {
                                          return Container(
                                            height: kIsWeb
                                                ? 500
                                                : MediaQuery.of(context)
                                                    .size
                                                    .height,
                                            color: Colors.transparent,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  20.0))),
                                              child: Center(
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 40,
                                                        ),
                                                        MyTextboxTitle(
                                                            title:
                                                                '?????? ?????? ????????',
                                                            isNumber: false,
                                                            isPrice: false,
                                                            lengthLimit: 0,
                                                            callback: (value) =>
                                                                name = value),
                                                        MyTextboxTitle(
                                                            title: '????????',
                                                            isNumber: false,
                                                            isPrice: false,
                                                            lengthLimit: 0,
                                                            callback: (value) =>
                                                                phone = value),
                                                        MyTextboxTitle(
                                                            title: '????????',
                                                            isNumber: false,
                                                            isPrice: false,
                                                            lengthLimit: 0,
                                                            callback: (value) =>
                                                                address =
                                                                    value),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width <
                                                                  600
                                                              ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width
                                                              : 600,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              MyButton(
                                                                  text: '??????????',
                                                                  callback:
                                                                      onPressAddTarafHesab),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: MyWidgets.dropDownWidget(
                                context,
                                '?????? ????????',
                                "?????? ???????? ???? ???????????? ????????",
                                _selectedTarafHesabId,
                                _loadedTarafHesab, (onChangedVal) {
                              setState(() {
                                _selectedTarafHesabId = onChangedVal! ?? "";
                              });
                            }, (onValidateVal) {
                              if (onValidateVal == null) {
                                return "?????? ???????? ???? ???????????? ????????";
                              }
                              return null;
                            },
                                borderFocusColor:
                                    Theme.of(context).primaryColor,
                                borderColor: Colors.grey,
                                contentPadding: 10,
                                optionValue: "id",
                                optionLabel: "name"),
                          )
                        ],
                      ),
                    ),

                    //////////////////////////////////////// Jens Deopdown //////////////////////////////////////
                    MyWidgets.dropDownWidget(
                        context,
                        '?????? ??????????',
                        "?????? ???? ???????????? ????????",
                        _selectedJensId,
                        _loadedJens, (onChangedVal) {
                      setState(() {
                        _selectedJensId = onChangedVal! ?? "";
                        _selectedKarbariId = null;
                        _selectedSizeId = null;
                        _filteredKarbari = _loadedKarbari
                            .where((element) =>
                                element['jens_id'].toString() ==
                                _selectedJensId.toString())
                            .toList();
                      });
                    }, (onValidateVal) {
                      if (onValidateVal == null) {
                        return "?????? ???? ???????????? ????????";
                      }
                      return null;
                    },
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        contentPadding: 10,
                        optionValue: "id",
                        optionLabel: "name"),
                    //////////////////////////////////////// Jens Deopdown ///////////////////////////////////////

                    ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                    MyWidgets.dropDownWidget(
                        context,
                        '????????????',
                        "???????????? ???? ???????????? ????????",
                        _selectedKarbariId,
                        _filteredKarbari, (onChangedVal) {
                      setState(() {
                        _selectedKarbariId = onChangedVal;
                        _selectedSizeId = null;
                        _filteredSize = _loadedSize
                            .where((element) =>
                                element['karbari_id'].toString() ==
                                    _selectedKarbariId.toString() ||
                                element['karbari_id'].toString() == "0")
                            .toList();
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),

                    MyWidgets.dropDownWidget(
                        context,
                        '???????? ??????????',
                        "???????? ???? ???????????? ????????",
                        _selectedSizeId,
                        _filteredSize, (onChangedVal) {
                      print(_isVisible);
                      setState(() {
                        _selectedSizeId = onChangedVal;
                        int.parse(_selectedSizeId!) == 0
                            ? _isVisible = true
                            : _isVisible = false;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),

                    Visibility(
                      visible: _isVisible,
                      child: MyTextboxTitle(
                          title: '???????? ??????????????',
                          isNumber: false,
                          isPrice: false,
                          lengthLimit: 0,
                          callback: (value) => _size_ekhtesasi = value),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: MyWidgets.dropDownWidget(
                          context,
                          '???????????? ????????',
                          "???????????? ???????? ???? ???????????? ????????",
                          _paperSizeId,
                          _loadedPaperSize, (onChangedVal) {
                        setState(() {
                          _paperSizeId = onChangedVal;
                        });
                      }, (onValidateVal) => null,
                          borderFocusColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          optionValue: "id",
                          optionLabel: "name"),
                    ),

                    MyTextboxTitle(
                        title: '??????????',
                        isNumber: true,
                        isPrice: false,
                        lengthLimit: 0,
                        callback: (value) => _tedad = value),
                    MyWidgets.dropDownWidget(
                        context,
                        '?????????? ?????? ??????',
                        "?????????? ?????? ?????? ???? ???????????? ????????",
                        _printingColorId,
                        printingColor, (onChangedVal) {
                      setState(() {
                        _printingColorId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    MyWidgets.dropDownWidget(
                        context,
                        '??????????',
                        "?????????? ?????????? ???? ???????????? ????????",
                        _selefonId,
                        orderAttribute, (onChangedVal) {
                      setState(() {
                        _selefonId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    MyWidgets.dropDownWidget(
                        context,
                        '????????????',
                        "?????????? ???????????? ???? ???????????? ????????",
                        _talakoobId,
                        orderAttribute, (onChangedVal) {
                      setState(() {
                        _talakoobId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    MyWidgets.dropDownWidget(
                        context,
                        '???????? ?? ??????????',
                        "?????????? ???????? ???? ???????????? ????????",
                        _uvId,
                        orderAttribute, (onChangedVal) {
                      setState(() {
                        _uvId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    MyWidgets.dropDownWidget(
                        context,
                        '???????????? ?? ???? ???? ????????????',
                        "?????????? ???????????? ???? ???????????? ????????",
                        _letterPressId,
                        orderAttribute, (onChangedVal) {
                      setState(() {
                        _letterPressId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    MyWidgets.dropDownWidget(
                        context,
                        '?????????? ?? ???????? ????????',
                        "?????????? ?????????? ???? ???????????? ????????",
                        _sahafiId,
                        orderAttribute, (onChangedVal) {
                      setState(() {
                        _sahafiId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    MyTextboxTitle(
                        title: '???????? ???? ??????????',
                        isNumber: true,
                        isPrice: true,
                        lengthLimit: 0,
                        callback: (value) => _totalPrice =
                            value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                    MyTextboxTitle(
                        title: '???????? ????????????',
                        isNumber: true,
                        isPrice: true,
                        lengthLimit: 0,
                        callback: (value) => _beyanePrice =
                            value.replaceAll(RegExp(r'[^\w\s]+'), '')),
                    MyDatePicker(
                        title: '?????????? ?????????? ????????????',
                        callback: (jalaliDate, georgianDate) =>
                            _orderDate = georgianDate),
                    ////////////////////////////////////// Size Deopdown /////////////////////////////////////
                    MyWidgets.dropDownWidget(
                        context,
                        '???????? ?????????? ????????????',
                        "???????? ???? ???????????? ????????",
                        _selectedBankId,
                        _loadedBank, (onChangedVal) {
                      setState(() {
                        _selectedBankId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(text: '??????????', callback: onPressAddOrder),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )));
  }
}
