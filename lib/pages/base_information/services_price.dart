import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';

import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';

class ServicesPrice extends StatefulWidget {
  const ServicesPrice({Key? key}) : super(key: key);

  @override
  State<ServicesPrice> createState() => _ServicesPriceState();
}

class _ServicesPriceState extends State<ServicesPrice> {
  bool _isLoading = true;
  late String name;
  late int id;
  int form_price = 0;
  int selephon_price = 0;
  int uv_price = 0;
  int letter_press_price = 0;

  static const apiUrl = ServicePriceApi;

  List _loadedList = [];

  Future<void> _fetch() async {
    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedList = data['data'];
    });

    id = _loadedList[0]['id'];
    form_price = _loadedList[0]['form_price'];
    selephon_price = _loadedList[0]['selephon_price'];
    uv_price = _loadedList[0]['uv_price'];
    letter_press_price = _loadedList[0]['letter_press_price'];

    _isLoading = false;
  }

  void onPressAdd() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);

    http.Response response =
        await create(form_price, selephon_price, uv_price, letter_press_price);
    print(response.body);

    _fetch();
  }

  void onPressEdit() async {

    Navigator.pop(context);
    http.Response response = await edit(
        form_price, selephon_price, uv_price, letter_press_price, id);
    print(response.body);

  }

  Future<http.Response> edit(int form_price, int selephon_price, int uv_price,
      int letter_press_price, int id) {
    return http.put(
      Uri.parse("$apiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'form_price': form_price,
        'selephon_price': selephon_price,
        'uv_price': uv_price,
        'letter_press_price': letter_press_price,
      }),
    );
  }

  Future<http.Response> create(int form_price, int selephon_price, int uv_price,
      int letter_press_price) {
    return http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'form_price': form_price,
        'selephon_price': selephon_price,
        'uv_price': uv_price,
        'letter_press_price': letter_press_price,
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قیمت سایر خدمات'),
        toolbarHeight: 75,
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  MyTextboxTitle(
                      title: 'قیمت هر فرم چاپ',
                      isNumber: false,
                      isPrice: false,
                      lengthLimit: 0,
                      initialText: form_price.toString(),
                      callback: (value) => form_price = int.parse(value)),
                  MyTextboxTitle(
                      title: 'قیمت سلفون',
                      isNumber: false,
                      isPrice: false,
                      lengthLimit: 0,
                      initialText: selephon_price.toString(),
                      callback: (value) => selephon_price = int.parse(value)),
                  MyTextboxTitle(
                      title: 'قیمت یووی',
                      isNumber: false,
                      isPrice: false,
                      lengthLimit: 0,
                      initialText: uv_price.toString(),
                      callback: (value) => uv_price = int.parse(value)),
                  MyTextboxTitle(
                      title: 'قیمت لترپرس',
                      isNumber: false,
                      isPrice: false,
                      lengthLimit: 0,
                      initialText: letter_press_price.toString(),
                      callback: (value) =>
                          letter_press_price = int.parse(value)),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(text: 'ذخیره', callback: onPressEdit),
                ],
              ),
      )),
    );
  }
}
