import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/my_widget.dart';
import '../../widgets/textbox_title.dart';

class PaperPrice extends StatefulWidget {
  const PaperPrice({Key? key}) : super(key: key);

  @override
  State<PaperPrice> createState() => _PaperPriceState();
}

class _PaperPriceState extends State<PaperPrice> {
  bool _isLoading = true;
  late String name;
  late int jens_id;
  late int gram_id;
  late int shit_size_id;
  late int price;

  String? _selectedJensId;
  String? _selectedGramId;
  String? _selectedShitId;

  List<dynamic> _loadedGram = [];
  List<dynamic> _loadedJens = [];
  List<dynamic> _loadedShit = [];
  List<dynamic> _loadedPaperPrice = [];

  late int id;
  static const apiUrlJens = JensApi;
  static const apiUrlGram = GramApi;
  static const apiUrlShit = ShitSizeApi;
  static const apiUrl = PaperPriceApi;

  Future<void> _fetch() async {
    final responseGram = await http.get(Uri.parse(apiUrlGram));
    final dataGram = json.decode(responseGram.body);

    final responseJens = await http.get(Uri.parse(apiUrlJens));
    final dataJens = json.decode(responseJens.body);

    final responseShit = await http.get(Uri.parse(apiUrlShit));
    final dataShit = json.decode(responseShit.body);

    final responsePaperPrice = await http.get(Uri.parse(apiUrl));
    final dataPaperPrice = json.decode(responsePaperPrice.body);

    setState(() {
      _loadedGram = dataGram['data'];
      _loadedJens = dataJens['data'];
      _loadedShit = dataShit['data'];
      _loadedPaperPrice = dataPaperPrice['data'];
    });

    _isLoading = false;
  }

  void onPressAdd() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);
    name =
        "${getJensNameById(int.parse(_selectedJensId!))} ${getGramNameById(int.parse(_selectedGramId!))} گرم ${getShitNameById(int.parse(_selectedShitId!))}";

    jens_id = int.parse(_selectedJensId!);
    gram_id = int.parse(_selectedGramId!);
    shit_size_id = int.parse(_selectedShitId!);

    http.Response response =
        await create(name, jens_id, gram_id, shit_size_id, price);
    print(response.body);

    _fetch();
  }

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    name =
        "${getJensNameById(int.parse(_selectedJensId!))} ${getGramNameById(int.parse(_selectedGramId!))} گرم ${getShitNameById(int.parse(_selectedShitId!))}";
    jens_id = int.parse(_selectedJensId!);
    gram_id = int.parse(_selectedGramId!);
    shit_size_id = int.parse(_selectedShitId!);

    http.Response response =
        await edit(id, name, jens_id, gram_id, shit_size_id, price);
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

  Future<http.Response> edit(
      int id, String name, int jens_id, int gram_id, int shit_id, int price) {
    return http.put(
      Uri.parse("$apiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'jens_id': jens_id,
        'gram_id': gram_id,
        'shit_size_id': shit_id,
        'price': price,
      }),
    );
  }

  Future<http.Response> delete(int id) {
    return http.delete(
      Uri.parse("$apiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> create(
      String name, int jens_id, int gram_id, int shit_id, int price) {
    return http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'jens_id': jens_id,
        'gram_id': gram_id,
        'shit_size_id': shit_id,
        'price': price,
      }),
    );
  }

  String getJensNameById(int jens_id) {
    final foundedJens =
        _loadedJens.singleWhere((element) => element['id'] == jens_id);
    return foundedJens['name'];
  }

  String getGramNameById(int gram_id) {
    final foundedGram =
        _loadedGram.singleWhere((element) => element['id'] == gram_id);
    return foundedGram['gram'];
  }

  String getShitNameById(int shit_id) {
    final foundedShit =
        _loadedShit.singleWhere((element) => element['id'] == shit_id);
    return foundedShit['name'];
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
        title: const Text('قیمت ها'),
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
                          text: 'اضافه کردن قیمت',
                          callback: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                // Add this line of Code
                                builder: (builder) {
                                  return Container(
                                    height: 600.0,
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
                                                // MyTextboxTitle(
                                                //     title: 'عنوان',
                                                //     isNumber: false,
                                                //     isPrice: false,
                                                //     lengthLimit: 0,
                                                //     callback: (value) =>
                                                //         name = value),
                                                MyWidgets.dropDownWidget(
                                                    context,
                                                    'جنس',
                                                    "جنس را انتخاب کنید",
                                                    _selectedJensId,
                                                    _loadedJens,
                                                    (onChangedVal) {
                                                  setState(() {
                                                    _selectedJensId =
                                                        onChangedVal;
                                                  });
                                                }, (onValidateVal) => null,
                                                    borderFocusColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    borderColor:
                                                       Colors.grey,
                                                    optionValue: "id",
                                                    optionLabel: "name"),

                                                MyWidgets.dropDownWidget(
                                                    context,
                                                    'گرماژ',
                                                    "گرماژ را انتخاب کنید",
                                                    _selectedGramId,
                                                    _loadedGram,
                                                    (onChangedVal) {
                                                  setState(() {
                                                    _selectedGramId =
                                                        onChangedVal;
                                                  });
                                                }, (onValidateVal) => null,
                                                    borderFocusColor:
                                                        Theme.of(context)
                                                            .primaryColor,

                                                    borderColor:
                                                    Colors.grey,
                                                    optionValue: "id",
                                                    optionLabel: "gram"),

                                                MyWidgets.dropDownWidget(
                                                    context,
                                                    'اندازه شیت',
                                                    "اندازه شیت را انتخاب کنید",
                                                    _selectedShitId,
                                                    _loadedShit,
                                                    (onChangedVal) {
                                                  setState(() {
                                                    _selectedShitId =
                                                        onChangedVal;
                                                  });
                                                }, (onValidateVal) => null,
                                                    borderFocusColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    borderColor:
                                                    Colors.grey,
                                                    optionValue: "id",
                                                    optionLabel: "name"),

                                                MyTextboxTitle(
                                                    title: 'قیمت',
                                                    isNumber: false,
                                                    isPrice: false,
                                                    lengthLimit: 0,
                                                    callback: (value) => price =
                                                        int.parse(value)),
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
                          child: _loadedPaperPrice.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _loadedPaperPrice.length,
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
                                            id = _loadedPaperPrice[index]['id'];
                                            name = _loadedPaperPrice[index]
                                                ['name'];
                                            _selectedJensId =
                                                _loadedPaperPrice[index]
                                                        ['jens_id']
                                                    .toString();
                                            _selectedGramId =
                                                _loadedPaperPrice[index]
                                                        ['gram_id']
                                                    .toString();
                                            _selectedShitId =
                                                _loadedPaperPrice[index]
                                                        ['shit_size_id']
                                                    .toString();
                                            price = _loadedPaperPrice[index]
                                                ['price'];
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (builder) {
                                                  return Container(
                                                    height: 600.0,
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
                                                                // MyTextboxTitle(
                                                                //     title: 'عنوان',
                                                                //     isNumber:false,
                                                                //     isPrice:false,
                                                                //     lengthLimit:0,
                                                                //     initialText:_loadedPaperPrice[index]['name'],
                                                                //     callback:(value) { name =value;
                                                                //       id = _loadedPaperPrice[index]['id'];
                                                                //     }),

                                                                MyWidgets.dropDownWidget(
                                                                    context,
                                                                    'جنس',
                                                                    "جنس را انتخاب کنید",
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
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                    borderColor:
                                                                    Colors.grey,
                                                                    optionValue:
                                                                        "id",
                                                                    optionLabel:
                                                                        "name"),

                                                                MyWidgets.dropDownWidget(
                                                                    context,
                                                                    'گرماژ',
                                                                    "گرماژ را انتخاب کنید",
                                                                    _selectedGramId,
                                                                    _loadedGram,
                                                                    (onChangedVal) {
                                                                  setState(() {
                                                                    _selectedGramId =
                                                                        onChangedVal;
                                                                  });
                                                                },
                                                                    (onValidateVal) =>
                                                                        null,
                                                                    borderFocusColor:
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                    borderColor:
                                                                    Colors.grey,
                                                                    optionValue:
                                                                        "id",
                                                                    optionLabel:
                                                                        "gram"),

                                                                MyWidgets.dropDownWidget(
                                                                    context,
                                                                    'اندازه شیت',
                                                                    "اندازه شیت را انتخاب کنید",
                                                                    _selectedShitId,
                                                                    _loadedShit,
                                                                    (onChangedVal) {
                                                                  setState(() {
                                                                    _selectedShitId =
                                                                        onChangedVal;

                                                                  });
                                                                },
                                                                    (onValidateVal) =>
                                                                        null,
                                                                    borderFocusColor:
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                    borderColor:
                                                                    Colors.grey,
                                                                    optionValue:
                                                                        "id",
                                                                    optionLabel:
                                                                        "name"),

                                                                MyTextboxTitle(
                                                                    title:
                                                                        'قیمت',
                                                                    isNumber:
                                                                        false,
                                                                    isPrice:
                                                                        false,
                                                                    lengthLimit:
                                                                        0,
                                                                    initialText:
                                                                        _loadedPaperPrice[index]['price']
                                                                            .toString(),
                                                                    callback: (value) =>
                                                                        price =
                                                                            int.parse(value)),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),

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
                                                                              'حذف قیمت',
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
                                              Text(
                                                '${_loadedPaperPrice[index]['price']} تومان',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontFamily: 'IranYekan',
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                _loadedPaperPrice[index]
                                                    ['name'],
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
                                  'قیمتی یافت نشد',
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
