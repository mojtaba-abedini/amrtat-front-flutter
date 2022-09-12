import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/my_widget.dart';
import '../../widgets/textbox_title.dart';

class Karbari extends StatefulWidget {
  const Karbari({Key? key}) : super(key: key);

  @override
  State<Karbari> createState() => _KarbariState();
}

class _KarbariState extends State<Karbari> {
  bool _isLoading = true;
  String? name;
  int? id;
  String? _selectedJensId;

  static const apiUrlKarbari = KarbariApi;
  static const apiUrlJens = JensApi;

  List _loadedKarbari = [];
  List _loadedJens = [];


  Future<void> _fetch() async {
    final responseKarbari = await http.get(Uri.parse(apiUrlKarbari));
    final dataKarbari = json.decode(responseKarbari.body);

    final responseJens = await http.get(Uri.parse(apiUrlJens));
    final dataJens = json.decode(responseJens.body);
    setState(() {
      _loadedKarbari = dataKarbari['data'];
      _loadedJens = dataJens['data'];
    });
    _isLoading = false;
  }

  void onPressAdd() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);

    http.Response response = await create(_selectedJensId!, name!);
    print(response.body);

    _fetch();
  }

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    http.Response response = await edit(_selectedJensId!, name!);
    print(response.body);
    _fetch();
  }

  void onPressDelete() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    http.Response response = await delete(id!);
    print(response.body);
    _fetch();
  }

  Future<http.Response> edit(String _selectedJensId, String name) {
    return http.put(
      Uri.parse("$apiUrlKarbari/$_selectedJensId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'jens_id': int.parse(_selectedJensId),
        'name': name,
      }),
    );
  }

  Future<http.Response> delete(int id) {
    return http.delete(
      Uri.parse("$apiUrlKarbari/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> create(String _selectedJensId, String name) {
    return http.post(
      Uri.parse(apiUrlKarbari),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'jens_id': int.parse(_selectedJensId),
        'name': name,
      }),
    );
  }

  String getJensNameById(int jens_id) {
    final foundedJens =
    _loadedJens.singleWhere((element) => element['id'] == jens_id);
     return foundedJens['name'];
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
                                    height: 350.0,
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

                                                MyWidgets.dropDownWidget(
                                                    context,
                                                    'جنس',
                                                    "کاربری را انتخاب کنید",
                                                    _selectedJensId,
                                                    _loadedJens,
                                                        (onChangedVal) {
                                                      setState(() {
                                                        _selectedJensId =
                                                            onChangedVal;
                                                      });
                                                    },
                                                        (onValidateVal) =>
                                                    null,
                                                    borderFocusColor:
                                                    Theme.of(
                                                        context)
                                                        .primaryColor,
                                                    borderColor: Theme
                                                        .of(
                                                        context)
                                                        .primaryColor,
                                                    optionValue: "id",
                                                    optionLabel:
                                                    "name"),



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
                          child: _loadedKarbari.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _loadedKarbari.length,
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
                                                _loadedKarbari[index]['id'];
                                            _selectedJensId = _loadedKarbari[index]
                                                ['jens_id'].toString();

                                            name = _loadedKarbari[index]
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
                                                                MyWidgets.dropDownWidget(
                                                                    context,
                                                                    'جنس',
                                                                    "کاربری را انتخاب کنید",
                                                                    _selectedJensId,
                                                                    _loadedJens,
                                                                        (onChangedVal) {
                                                                      setState(() {
                                                                        _selectedJensId =
                                                                            onChangedVal;
                                                                      });
                                                                    },
                                                                        (onValidateVal) =>
                                                                    null,
                                                                    borderFocusColor:
                                                                    Theme.of(
                                                                        context)
                                                                        .primaryColor,
                                                                    borderColor: Theme
                                                                        .of(
                                                                        context)
                                                                        .primaryColor,
                                                                    optionValue: "id",
                                                                    optionLabel:
                                                                    "name"),

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
                                                                        _loadedKarbari[index]
                                                                            [
                                                                            'name'],
                                                                    callback:
                                                                        (value) {
                                                                      name =
                                                                          value;
                                                                      _selectedJensId =
                                                                          _loadedKarbari[index]
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
                                              Text('${getJensNameById(_loadedKarbari[index]['jens_id'])} - ${_loadedKarbari[index]['name']}',
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
