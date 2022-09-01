import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
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


  late String address;
  late int id;
  static const apiUrl = PaperPriceApi;

  List _loadedList = [];

  Future<void> _fetch() async {

    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);
    setState(() {
      _loadedList = data['data'];
    });
    _isLoading = false;
  }


  void onPressAdd() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context, true);
    http.Response response = await create(name,address);
    print(response.body);

    _fetch();
  }

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    http.Response response = await edit(name,address, id);
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

  Future<http.Response> edit(String name, String address, int id) {
    return http.put(
      Uri.parse("$apiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'address': address,
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

  Future<http.Response> create(String name,String address) {
    return http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'address': address,
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
        title: const Text('انبار ها'),
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
                          text: 'اضافه کردن انبار',
                          callback: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                // Add this line of Code
                                builder: (builder) {
                                  return Container(
                                    height: 400.0,
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
                                                MyTextboxTitle(
                                                    title: 'نام انبار',
                                                    isNumber: false,
                                                    isPrice: false,
                                                    lengthLimit: 0,
                                                    callback: (value) =>
                                                        name = value),
                                                MyTextboxTitle(
                                                    title: 'آدرس انبار',
                                                    isNumber: false,
                                                    isPrice: false,
                                                    lengthLimit: 0,
                                                    callback: (value) =>
                                                    address = value),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width < 600
                                                      ? MediaQuery.of(context).size.width : 600,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceAround,
                                                    children: [
                                                      MyButton(text: 'ذخیره',callback: onPressAdd),
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
                          child: _loadedList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _loadedList.length,
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
                                            id = _loadedList[ index]['id'];
                                            name= _loadedList[ index]['name'];
                                            address = _loadedList[ index]['address'];
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
                                                                MyTextboxTitle(
                                                                    title: 'نام انبار',
                                                                    isNumber:false,
                                                                    isPrice:false,
                                                                    lengthLimit:0,
                                                                    initialText:_loadedList[index]['name'],
                                                                    callback:(value) { name =value;
                                                                      id = _loadedList[index]['id'];

                                                                    }),
                                                                MyTextboxTitle(
                                                                    title: 'آدرس انبار',
                                                                    isNumber:false,
                                                                    isPrice:false,
                                                                    lengthLimit:0,
                                                                    initialText:_loadedList[index]['address'],
                                                                    callback:(value) { address =value;
                                                                    id = _loadedList[index]['id'];

                                                                    }),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width < 600
                                                                      ? MediaQuery.of(context).size.width : 600,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      MyButton(text:'ذخیره', callback:onPressEdit),
                                                                      MyButton(text:'حذف انبار',callback:onPressDelete),
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
                                              Text(
                                                _loadedList[index]['name'],
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
                                  'انباری یافت نشد',
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
