import 'dart:convert';
import 'package:amertat/api.dart';
import 'package:amertat/widgets/button.dart';

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

  String? _selefonId;
  String? _talakoobId;
  String? _uvId;
  String? _letterPressId;
  String? _sahafiId;
  String? _selectedJensId;
  String? _selectedKarbariId;
  String? _selectedSizeId;
  String? _selectedBankId;

  List _loadedJens = [];
  List _loadedSize = [];
  List _loadedKarbari = [];
  List _loadedBank = [];
  List _filteredSize = [];
  List _filteredKarbari = [];

  static const jensApiUrl = JensApi;
  static const karbariApiUrl = KarbariApi;
  static const sizeApiUrl = SizeApi;
  static const bankApiUrl = BankApi;

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
    _isLoading = false;
  }

  Future<void> _fetchBank() async {
    final response = await http.get(Uri.parse(bankApiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedBank = data['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchJens();
    _fetchKarbari();
    _fetchBank();
    _fetchSize();
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
                    MyTextboxTitle(
                        title: 'نام و نام خانوادگی مشتری',
                        isNumber: false,
                        isPrice: false,
                        lengthLimit: 0,
                        callback: (value) => newOrderName = value),
                    MyTextboxTitle(
                        title: 'تلفن تماس',
                        isNumber: true,
                        isPrice: false,
                        lengthLimit: 10,
                        callback: (value) => newOrderPhone = value),

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
                                _selectedKarbariId.toString())
                            .toList();
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                    ////////////////////////////////////// Size Deopdown /////////////////////////////////////
                    MyWidgets.dropDownWidget(
                        context,
                        'سایز سفارش',
                        "سایز را انتخاب کنید",
                        _selectedSizeId,
                        _filteredSize, (onChangedVal) {
                      setState(() {
                        _selectedSizeId = onChangedVal;
                      });
                    }, (onValidateVal) => null,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderColor: Colors.grey,
                        optionValue: "id",
                        optionLabel: "name"),
                    ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////

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
                        "وضعیت لترپرس را انتخاب کنید",
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
                            newOrderFirstPriceDate = jalaliDate),
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
