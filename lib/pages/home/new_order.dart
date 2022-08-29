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
  String _selectedSize = "";
  List _loadedJens = [];
  List _loadedSize = [];
  List _filteredLoadedSize = [];

  Future<void> _fetchJens() async {
    const apiUrl = getAllJens;
    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedJens = data;
    });
  }

  Future<void> _fetchSize() async {
    const apiUrl = getAllSize;
    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedSize = data;
    });
    filterSizes(_loadedJens[0]['id']);
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchJens();
    _fetchSize();
  }

  void onPressButton() {
    Navigator.pop(context);
  }

  filterSizes(int id) {
    _filteredLoadedSize =
        _loadedSize.where((o) => o['karbari_id'] == id).toList();

    setState(() {
      _selectedSize = _filteredLoadedSize[0]['name'];
      _filteredLoadedSize;
    });
  }

  getIdByName(String value) {
    final foundSelected =
        _loadedJens.singleWhere((element) => element['name'] == value);
    filterSizes(foundSelected['id']);

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
                                'نوع سفارش',
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
                                      getIdByName(newValue!);
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

                    // MyDropDown(
                    //     title: 'نوع سفارش',
                    //     initIndex: () => _loadedJens[0]['name'],
                    //     initStateIndex: () =>
                    //         newOrderType = _loadedJens[0]['name'],
                    //     mapVariabale: _loadedJens,
                    //     mapFeild: 'name',
                    //     callback: (value) {
                    //       newOrderType = value;
                    //       getIdByName(value);
                    //
                    //     }),
                    // MyDropDown(
                    //     title: 'سایز محصول',
                    //     initIndex: () => _filteredLoadedSize[0]['name'],
                    //     initStateIndex: () =>
                    //         newOrderSize = _filteredLoadedSize[0]['name'],
                    //     mapVariabale: _filteredLoadedSize,
                    //     mapFeild: 'name',
                    //     callback: (value) => newOrderSize = value),
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
                        initIndex: () => banks[0]['name'],
                        initStateIndex: () =>
                            newOrderBank = banks[0]['name'] as String,
                        mapVariabale: banks,
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

// class Network {
//   final String url;
//   Network(this.url);
//
//   Future fetchData() async {
//     Response response = await get(Uri.encodeFull())
//   }
//
// }

class Album {
  final int id;
  final String name;

  const Album({
    required this.id,
    required this.name,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
    );
  }
}
