import 'dart:convert';
import 'package:amertat/widgets/dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';

class Size extends StatefulWidget {
  const Size({Key? key}) : super(key: key);

  @override
  State<Size> createState() => _SizeState();
}

class _SizeState extends State<Size> {
  bool _isLoading = true;
  late String name;

  late int id;
  late int jens_id;
  late int karbari_id;
  static const apiUrlSize = SizeApi;
  static const apiUrlKarbari = KarbariApi;
  static const apiUrlJens = JensApi;

  List _loadedListSize = [];
  List _loadedListJens = [];
  List _loadedListKarbari = [];

  int getJensIdByName(String value) {
    final foundSelected =
        _loadedListJens.singleWhere((element) => element['name'] == value);
    jens_id = foundSelected['id'];
    return jens_id;
  }
  int getKarbariIdByName(String value) {
    final foundSelected =
    _loadedListKarbari.singleWhere((element) => element['name'] == value);
    karbari_id = foundSelected['id'];
    return karbari_id;
  }

  Future<void> _fetch() async {
    final responseSize = await http.get(Uri.parse(apiUrlSize));
    final dataSize = json.decode(responseSize.body);

    final responseJens = await http.get(Uri.parse(apiUrlJens));
    final dataJens = json.decode(responseJens.body);

    final responseKarbari = await http.get(Uri.parse(apiUrlKarbari));
    final dataKarbari = json.decode(responseKarbari.body);

    setState(() {
      _loadedListSize = dataSize['data'];
      _loadedListJens = dataJens['data'];
      _loadedListKarbari = dataKarbari['data'];
    });
    _isLoading = false;
  }

  void onPressAdd() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);

    http.Response response = await create(jens_id, name);
    print(response.body);

    _fetch();
  }

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    http.Response response = await edit(jens_id, name);
    print(response.body);
    _fetch();
  }

  void onPressDelete() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    http.Response response = await delete(id);
    print(response.body);
    _fetch();
  }

  Future<http.Response> edit(int jens_id, String name) {
    return http.put(
      Uri.parse("$apiUrlSize/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'jens_id': jens_id,
        'name': name,
      }),
    );
  }

  Future<http.Response> delete(int id) {
    return http.delete(
      Uri.parse("$apiUrlSize/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> create(int jens_id, String name) {
    return http.post(
      Uri.parse(apiUrlSize),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'jens_id': jens_id,
        'name': name,
      }),
    );
  }

  String getJensNameById(int jens_id) {
    final foundedJens =
    _loadedListJens.singleWhere((element) => element['id'] == jens_id);
     return foundedJens['name'];
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jens_id = 1;
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کاربری ها'),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width
                    : 600,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 30, right: 20, left: 20),
                    child: Column(
                      children: [
                        MyButton(
                          text: 'اضافه کردن کاربری',
                          callback: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                // Add this line of Code
                                builder: (builder) {
                                  return Container(
                                    height: 500.0,
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0))),
                                      child: Center(
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                MyDropDown(
                                                    title: 'جنس',
                                                    initIndex: () =>
                                                        _loadedListJens[0]
                                                            ['name'],
                                                    initStateIndex: () {},
                                                    mapVariabale:
                                                        _loadedListJens,
                                                    mapFeild: 'name',
                                                    callback: (value) =>
                                                        getJensIdByName(value)),
                                                MyDropDown(
                                                    title: 'کاربری',
                                                    initIndex: () =>
                                                    _loadedListKarbari[0]
                                                    ['name'],
                                                    initStateIndex: () {},
                                                    mapVariabale:
                                                    _loadedListKarbari,
                                                    mapFeild: 'name',
                                                    callback: (value) =>getKarbariIdByName(value)),
                                                MyTextboxTitle(
                                                    title: 'عنوان',
                                                    isNumber: false,
                                                    isPrice: false,
                                                    lengthLimit: 0,
                                                    callback: (value) =>
                                                        name = value),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width <
                                                          600
                                                      ? MediaQuery.of(context)
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
                                                          callback: onPressAdd),
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
                        Expanded(
                          child: _loadedListSize.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _loadedListSize.length,
                                  itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: SizedBox(
                                      height: 50,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            alignment: Alignment.center,
                                            onPrimary:
                                                Theme.of(context).primaryColor,
                                            elevation: 4,
                                            primary: Colors.white,
                                          ),
                                          onPressed: () {
                                            id =
                                                _loadedListSize[index]['id'];
                                            jens_id = _loadedListSize[index]
                                                ['jens_id'];

                                            name = _loadedListSize[index]
                                                ['name'];

                                            showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (builder) {
                                                  return Container(
                                                    height: 400.0,
                                                    color: Colors.transparent,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0))),
                                                      child: Center(
                                                        child: Directionality(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                MyDropDown(
                                                                    title:
                                                                        'جنس',
                                                                    initIndex: () =>
                                                                        _loadedListJens[jens_id - 1]
                                                                            [
                                                                            'name'],
                                                                    initStateIndex:
                                                                        () {},
                                                                    mapVariabale:
                                                                        _loadedListJens,
                                                                    mapFeild:
                                                                        'name',
                                                                    callback: (value) =>
                                                                        getJensIdByName(
                                                                            value)),
                                                                MyTextboxTitle(
                                                                    title:
                                                                        'عنوان',
                                                                    isNumber:
                                                                        false,
                                                                    isPrice:
                                                                        false,
                                                                    lengthLimit:
                                                                        0,
                                                                    initialText:
                                                                        _loadedListSize[index]
                                                                            [
                                                                            'name'],
                                                                    callback:
                                                                        (value) {
                                                                      name =
                                                                          value;
                                                                      jens_id =
                                                                          _loadedListSize[index]
                                                                              [
                                                                              'jens_id'];
                                                                    }),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context)
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
                                                                          text:
                                                                              'ذخیره',
                                                                          callback:
                                                                              onPressEdit),
                                                                      MyButton(
                                                                          text:
                                                                              'حذف سایز',
                                                                          callback:
                                                                              onPressDelete),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(
                                                Icons.store,
                                                color: Colors.black87,
                                                size: 19,
                                              ),
                                              Text('${getJensNameById(_loadedListSize[index]['jens_id'])} - ${_loadedListSize[index]['name']}',
                                                style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'IranYekan',
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black87,
                                                size: 17,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const Text(
                                  'سایزی یافت نشد',
                                  style: TextStyle(fontSize: 18),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
