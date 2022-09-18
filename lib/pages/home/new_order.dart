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
  String? _uvId;
  String? _letterPressId;
  String? _sahafiId;
  String? _selectedJensId;
  String? _selectedKarbariId;
  String? _selectedSizeId;
  String? _selectedBankId;
  String? _selectedTarafHesabId;

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

  void onPressAdd() async {
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
    setState(() {
      _loadedSize = data['data'];
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
          title: const Text('ثبت سفارش جدید'),
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
                      height: 20,
                    ),
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
                                                                'نام طرف حساب',
                                                            isNumber: false,
                                                            isPrice: false,
                                                            lengthLimit: 0,
                                                            callback: (value) =>
                                                                name = value),
                                                        MyTextboxTitle(
                                                            title: 'تلفن',
                                                            isNumber: false,
                                                            isPrice: false,
                                                            lengthLimit: 0,
                                                            callback: (value) =>
                                                                phone = value),
                                                        MyTextboxTitle(
                                                            title: 'آدرس',
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
                                                                  text: 'ذخیره',
                                                                  callback:
                                                                      onPressAdd),
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
                                'طرف حساب',
                                "طرف حساب را انتخاب کنید",
                                _selectedTarafHesabId,
                                _loadedTarafHesab, (onChangedVal) {
                              setState(() {
                                _selectedTarafHesabId = onChangedVal! ?? "";
                              });
                            }, (onValidateVal) {
                              if (onValidateVal == null) {
                                return "طرف حساب را انتخاب کنید";
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
                        'جنس سفارش',
                        "جنس را انتخاب کنید",
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
                        return "جنس را انتخاب کنید";
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
                        'کاربری',
                        "کاربری را انتخاب کنید",
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
                        'سایز سفارش',
                        "سایز را انتخاب کنید",
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
                          title: 'سایز اختصاصی',
                          isNumber: false,
                          isPrice: false,
                          lengthLimit: 0,
                          callback: (value) => newOrderPrice = value),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width
                          : 640),
                      child: Row(
                        children: [
                          Expanded(
                            child: Visibility(
                              visible: _isVisible,
                              child: MyTextboxTitle(
                                  title: 'عرض کاغذ',
                                  isNumber: false,
                                  isPrice: false,
                                  lengthLimit: 0,
                                  callback: (value) => newOrderPrice = value),
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              visible: _isVisible,
                              child: MyTextboxTitle(
                                  title: 'طول کاغذ',
                                  isNumber: false,
                                  isPrice: false,
                                  lengthLimit: 0,
                                  callback: (value) => newOrderPrice = value),
                            ),
                          ),
                        ],
                      ),
                    ),

                    MyTextboxTitle(
                        title: 'تعداد',
                        isNumber: true,
                        isPrice: false,
                        lengthLimit: 0,
                        callback: (value) => newOrderPrice = value),
                    MyWidgets.dropDownWidget(
                        context,
                        'سلفون',
                        "وضعیت سلفون را انتخاب کنید",
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
                        'طلاکوب',
                        "وضعیت طلاکوب را انتخاب کنید",
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
                        'یووی و امباس',
                        "وضعیت یووی را انتخاب کنید",
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
                        'لترپرس و خط تا برجسته',
                        "وضعیت لترپرس را انتخاب کنید",
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
                        'صحافی و بسته بندی',
                        "وضعیت صحافی را انتخاب کنید",
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
                        title: 'مبلغ کل سفارش',
                        isNumber: true,
                        isPrice: true,
                        lengthLimit: 0,
                        callback: (value) => newOrderPrice = value),
                    MyTextboxTitle(
                        title: 'مبلغ بیعانه',
                        isNumber: true,
                        isPrice: true,
                        lengthLimit: 0,
                        callback: (value) => newOrderFirstPrice = value),
                    MyDatePicker(
                        title: 'تاریخ واریز بیعانه',
                        callback: (jalaliDate, georgianDate) =>
                            date = jalaliDate),
                    ////////////////////////////////////// Size Deopdown /////////////////////////////////////
                    MyWidgets.dropDownWidget(
                        context,
                        'بانک واریز بیعانه',
                        "بانک را انتخاب کنید",
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
                    MyButton(text: 'ذخیره', callback: onPressButton),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )));
  }
}
