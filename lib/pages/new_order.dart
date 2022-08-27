import 'dart:convert';
import 'package:amertat/api.dart';
import 'package:amertat/widgets/button.dart';
import 'package:amertat/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:amertat/store.dart';
import '../widgets/date_picker.dart';
import '../widgets/textbox_title.dart';
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
    size=_filteredLoadedSize;
  }

  getIdByName(String value) {
    final foundSelected =
        _loadedJens.singleWhere((element) => element['name'] == value);
    filterSizes(foundSelected['id']);
    print(_filteredLoadedSize);
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
                    MyDropDown(
                        title: 'نوع سفارش',
                        initIndex: () => _loadedJens[0]['name'],
                        initStateIndex: () =>
                            newOrderType = _loadedJens[0]['name'],
                        mapVariabale: _loadedJens,
                        mapFeild: 'name',
                        callback: (value) {
                          newOrderType = value;
                          getIdByName(value);
                        }),
                    MyDropDown(
                        title: 'سایز محصول',
                        initIndex: () => _filteredLoadedSize[0]['name'],
                        initStateIndex: () =>
                            newOrderSize = _filteredLoadedSize[0]['name'],
                        mapVariabale: _filteredLoadedSize,
                        mapFeild: 'name',
                        callback: (value) => newOrderSize = value),
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
