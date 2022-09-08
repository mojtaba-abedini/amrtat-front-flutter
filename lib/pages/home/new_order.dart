import 'dart:convert';
import 'package:amertat/api.dart';
import 'package:amertat/widgets/button.dart';
import 'package:amertat/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:amertat/store.dart';
import '../../widgets/date_picker.dart';
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
  late String _selectedJens = _loadedJens[0]['name'] as String;
  late String _selectedKarbari = _loadedKarbari[0]['name'] as String;
  String _selectedSize = "";
  late int jens_id;
  late int karbari_id;
  List _loadedJens = [];
  List _loadedSize = [];
  List _loadedKarbari = [];
  List _loadedBank = [];
  List _filteredLoadedSize = [];
  List _filteredLoadedKarbari = [];
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
    filterKarbari(_loadedJens[0]['id']);
  }

  Future<void> _fetchSize() async {
    final response = await http.get(Uri.parse(sizeApiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedSize = data['data'];
    });
    filterSizes(_loadedKarbari[0]['id']);
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

  filterSizes(int karbari_id) {
    _filteredLoadedSize =
        _loadedSize.where((o) => (o['karbari_id'] == karbari_id)).toList();

    setState(() {
      _selectedSize = _filteredLoadedSize[0]['name'];
      _filteredLoadedSize;
    });
  }

  filterKarbari(int jens_id) {
    _filteredLoadedKarbari =
        _loadedKarbari.where((o) => o['jens_id'] == jens_id).toList();

    setState(() {
      _selectedKarbari = _filteredLoadedKarbari[0]['name'];
      _filteredLoadedKarbari;
    });
  }

  int getJensIdByName(String value) {
    final foundedJens =
        _loadedJens.singleWhere((element) => element['name'] == value);
    jens_id = foundedJens['id'];
    print(jens_id);
    return jens_id;
  }

  int getKarbariIdByName(String value) {
    final foundedKarbari =
        _loadedKarbari.singleWhere((element) => element['name'] == value);
    karbari_id = foundedKarbari['id'];
    return karbari_id;
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'جنس سفارش',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 17),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                width: MediaQuery.of(context).size.width < 600
                                    ? MediaQuery.of(context).size.width
                                    : 600,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    onChanged: (newValue) {
                                      getJensIdByName(newValue!);
                                      filterKarbari(jens_id);
                                      filterSizes(
                                          _filteredLoadedKarbari[0]['id']);
                                      setState(() {
                                        _selectedJens = newValue;
                                      });
                                    },
                                    icon: const Visibility(
                                        visible: false,
                                        child: Icon(Icons.arrow_downward)),
                                    value: _selectedJens,
                                    elevation: 16,
                                    iconSize: 0,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    items: _loadedJens.map((value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value['name'],
                                        child: Text(
                                          value['name'],
                                          style: const TextStyle(
                                              fontFamily: 'IranYekan',
                                              fontSize: 17),
                                        ),
                                      );
                                    }).toList(),
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'کاربری',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 17),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                width: MediaQuery.of(context).size.width < 600
                                    ? MediaQuery.of(context).size.width
                                    : 600,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    onChanged: (newValue) {
                                      getKarbariIdByName(newValue!);
                                      filterSizes(karbari_id);
                                      setState(() {
                                        _selectedKarbari = newValue;
                                      });
                                    },
                                    icon: const Visibility(
                                        visible: false,
                                        child: Icon(Icons.arrow_downward)),
                                    value: _selectedKarbari,
                                    elevation: 16,
                                    iconSize: 0,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    items: _filteredLoadedKarbari.map((value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value['name'],
                                        child: Text(
                                          value['name'],
                                          style: const TextStyle(
                                              fontFamily: 'IranYekan',
                                              fontSize: 17),
                                        ),
                                      );
                                    }).toList(),
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'سایز محصول',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 17),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                width: MediaQuery.of(context).size.width < 600
                                    ? MediaQuery.of(context).size.width
                                    : 600,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: DropdownButton<String>(
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedSize = newValue!;
                                      });
                                    },
                                    icon: const Visibility(
                                        visible: false,
                                        child: Icon(Icons.arrow_downward)),
                                    value: _selectedSize,
                                    elevation: 16,
                                    iconSize: 0,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    items: _filteredLoadedSize.map((value) {
                                      return DropdownMenuItem<String>(
                                        alignment: Alignment.center,
                                        value: value['name'],
                                        child: Text(
                                          value['name'],
                                          style: const TextStyle(
                                              fontFamily: 'IranYekan',
                                              fontSize: 17),
                                        ),
                                      );
                                    }).toList(),
                                    underline: Container(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextboxTitle(
                        title: 'تعداد',
                        isNumber: true,
                        isPrice: false,
                        lengthLimit: 0,
                        callback: (value) => newOrderPrice = value),
                    MyDropDown(
                        title: 'سلفون',
                        initIndex: () => orderAttribute[0]['name'],
                        initStateIndex: () =>
                            newOrderType = orderAttribute[0]['name'] as String,
                        mapVariabale: orderAttribute,
                        mapFeild: 'name',
                        callback: (value) => selefon = value),
                    MyDropDown(
                        title: 'طلاکوب',
                        initIndex: () => orderAttribute[0]['name'],
                        initStateIndex: () =>
                            newOrderType = orderAttribute[0]['name'] as String,
                        mapVariabale: orderAttribute,
                        mapFeild: 'name',
                        callback: (value) => talakoob = value),
                    MyDropDown(
                        title: 'یووی و امباس',
                        initIndex: () => orderAttribute[0]['name'],
                        initStateIndex: () =>
                            newOrderType = orderAttribute[0]['name'] as String,
                        mapVariabale: orderAttribute,
                        mapFeild: 'name',
                        callback: (value) => UV = value),
                    MyDropDown(
                        title: 'لترپرس و خط تا برجسته',
                        initIndex: () => orderAttribute[0]['name'],
                        initStateIndex: () =>
                            newOrderType = orderAttribute[0]['name'] as String,
                        mapVariabale: orderAttribute,
                        mapFeild: 'name',
                        callback: (value) => letterPress = value),
                    MyDropDown(
                        title: 'صحافی و بسته بندی',
                        initIndex: () => orderAttribute[0]['name'],
                        initStateIndex: () =>
                            newOrderType = orderAttribute[0]['name'] as String,
                        mapVariabale: orderAttribute,
                        mapFeild: 'name',
                        callback: (value) => sahafi = value),
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
                    MyDropDown(
                        title: 'بانک واریز بیعانه',
                        initIndex: () => _loadedBank[0]['name'],
                        initStateIndex: () =>
                            newOrderBank = _loadedBank[0]['name'] as String,
                        mapVariabale: _loadedBank,
                        mapFeild: 'name',
                        callback: (value) => newOrderBank = value),
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
