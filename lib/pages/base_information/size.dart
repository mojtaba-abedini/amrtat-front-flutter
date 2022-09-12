import 'dart:convert';
import 'package:amertat/widgets/my_widget.dart';
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

  List<dynamic> _loadedSize = [];
  List<dynamic> _loadedJens = [];
  List<dynamic> _loadedKarbari = [];
  List<dynamic> _filteredKarbari = [];

  String? _selectedJensId;
  String? _selectedKarbariId;

  Future<void> _fetch() async {
    final responseSize = await http.get(Uri.parse(apiUrlSize));
    final dataSize = json.decode(responseSize.body);

    final responseJens = await http.get(Uri.parse(apiUrlJens));
    final dataJens = json.decode(responseJens.body);

    final responseKarbari = await http.get(Uri.parse(apiUrlKarbari));
    final dataKarbari = json.decode(responseKarbari.body);

    setState(() {
      _loadedSize = dataSize['data'];
      _loadedJens = dataJens['data'];
      _loadedKarbari = dataKarbari['data'];
    });

    _isLoading = false;
  }

  void onPressAdd() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);

    http.Response response = await create(_selectedJensId!, name);
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

  Future<http.Response> create(String _selectedJensId, String name) {
    return http.post(
      Uri.parse(apiUrlSize),
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
        title: const Text('سایز محصولات'),
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
                          text: 'اضافه کردن سایز',
                          callback: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                // Add this line of Code
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context,
                                              setState) =>
                                          Container(
                                            height: 500.0,
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
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width <
                                                                  600
                                                              ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width
                                                              : 600,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          //////////////////////////////////////// Jens Deopdown //////////////////////////////////////
                                                          MyWidgets.dropDownWidget(
                                                              context,
                                                              'جنس',
                                                              "جنس را انتخاب کنید",
                                                              _selectedJensId,
                                                              _loadedJens,
                                                              (onChangedVal) {
                                                            setState(() {
                                                              _selectedJensId =
                                                                  onChangedVal! ??
                                                                      "";
                                                              _selectedKarbariId =
                                                                  null;
                                                              _filteredKarbari = _loadedKarbari
                                                                  .where((element) =>
                                                                      element['jens_id']
                                                                          .toString() ==
                                                                      _selectedJensId
                                                                          .toString())
                                                                  .toList();
                                                            });
                                                          }, (onValidateVal) {
                                                            if (onValidateVal ==
                                                                null) {
                                                              return "جنس را انتخاب کنید";
                                                            }
                                                            return null;
                                                          },
                                                              borderFocusColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              borderColor: Theme
                                                                      .of(
                                                                          context)
                                                                  .primaryColor,
                                                              contentPadding: 5,
                                                              optionValue: "id",
                                                              optionLabel:
                                                                  "name"),
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
                                                              _selectedKarbariId =
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
                                                          ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////

                                                          MyTextboxTitle(
                                                              title: 'عنوان',
                                                              isNumber: false,
                                                              isPrice: false,
                                                              lengthLimit: 0,
                                                              callback:
                                                                  (value) =>
                                                                      name =
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
                                                                    text:
                                                                        'ذخیره',
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
                                            ),
                                          ));
                                });
                          },
                        ),
                        Expanded(
                          child: _loadedSize.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _loadedSize.length,
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
                                            id = _loadedSize[index]['id'];
                                            _selectedJensId = _loadedSize[index]
                                                    ['jens_id']
                                                .toString();
                                            _filteredKarbari = _loadedKarbari
                                                .where((element) =>
                                                    element['jens_id']
                                                        .toString() ==
                                                    _selectedJensId.toString())
                                                .toList();
                                            _selectedKarbariId =
                                                _loadedSize[index]['karbari_id']
                                                    .toString();

                                            name = _loadedSize[index]['name'];

                                            showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                                  setState) =>
                                                              Container(
                                                                height: 500.0,
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    Container(
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              20.0),
                                                                          topRight:
                                                                              Radius.circular(20.0))),
                                                                  child: Center(
                                                                    child:
                                                                        Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            SizedBox(
                                                                          width: MediaQuery.of(context).size.width < 600
                                                                              ? MediaQuery.of(context).size.width
                                                                              : 600,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              //////////////////////////////////////// Jens Deopdown //////////////////////////////////////
                                                                              MyWidgets.dropDownWidget(context, 'جنس', "جنس را انتخاب کنید", _selectedJensId, _loadedJens, (onChangedVal) {
                                                                                setState(() {
                                                                                  _selectedJensId = onChangedVal! ?? "";
                                                                                  _selectedKarbariId = null;
                                                                                  _filteredKarbari = _loadedKarbari.where((element) => element['jens_id'].toString() == _selectedJensId.toString()).toList();
                                                                                });
                                                                              }, (onValidateVal) {
                                                                                if (onValidateVal == null) {
                                                                                  return "جنس را انتخاب کنید";
                                                                                }
                                                                                return null;
                                                                              }, borderFocusColor: Theme.of(context).primaryColor, borderColor: Theme.of(context).primaryColor, contentPadding: 5, optionValue: "id", optionLabel: "name"),
                                                                              //////////////////////////////////////// Jens Deopdown ///////////////////////////////////////

                                                                              ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                              MyWidgets.dropDownWidget(context, 'کاربری', "کاربری را انتخاب کنید", _selectedKarbariId, _filteredKarbari, (onChangedVal) {
                                                                                setState(() {
                                                                                  _selectedKarbariId = onChangedVal;
                                                                                });
                                                                              }, (onValidateVal) => null, borderFocusColor: Theme.of(context).primaryColor, borderColor: Theme.of(context).primaryColor, optionValue: "id", optionLabel: "name"),
                                                                              ////////////////////////////////////// Karbari Deopdown /////////////////////////////////////
                                                                              MyTextboxTitle(
                                                                                  title: 'عنوان',
                                                                                  isNumber: false,
                                                                                  isPrice: false,
                                                                                  lengthLimit: 0,
                                                                                  initialText: _loadedSize[index]['name'],
                                                                                  callback: (value) {
                                                                                    name = value;
                                                                                    jens_id = _loadedSize[index]['jens_id'];
                                                                                  }),
                                                                              const SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width : 600,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: [
                                                                                    MyButton(text: 'ذخیره', callback: onPressEdit),
                                                                                    MyButton(text: 'حذف سایز', callback: onPressDelete),
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
                                                                ),
                                                              ));
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
                                              Text(
                                                '${getJensNameById(_loadedSize[index]['jens_id'])} - ${_loadedSize[index]['name']}',
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
