import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TarafHesab extends StatefulWidget {
  const TarafHesab({Key? key}) : super(key: key);

  @override
  State<TarafHesab> createState() => _TarafHesabState();
}

class _TarafHesabState extends State<TarafHesab> {

  bool _isLoading = true;
  late String name;
  late String phone;
  late String address;
  late int id;
  static const apiUrl = TarafHesabApi;

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
    http.Response response = await create(name,phone,address);
    print(response.body);

    _fetch();
  }

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    Navigator.pop(context);
    http.Response response = await edit(name,phone, address, id);
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

  Future<http.Response> edit(String name, String phone, String address, int id) {
    return http.put(
      Uri.parse("$apiUrl/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phone': phone,
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

  Future<http.Response> create(String name,String phone, String address) {
    return http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phone': phone,
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
        title: const Text('طرف حساب ها'),
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
                          text: 'اضافه کردن طرف حساب',
                          callback: () {
                            address="";
                            phone = "";
                            showModalBottomSheet(
                              isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                // Add this line of Code
                                builder: (builder) {
                                  return Container(
                                    height: kIsWeb ? 500 : MediaQuery.of(context).size.height,
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


                                              children: [
                                                const SizedBox(height: 40,),

                                                MyTextboxTitle(
                                                    title: 'نام طرف حساب',
                                                    isNumber: false,
                                                    isPrice: false,
                                                    lengthLimit: 0,
                                                    callback: (value) =>
                                                        name = value),
                                                MyTextboxTitle(
                                                    title: 'تلفن',
                                                    isNumber: false,
                                                    isPrice: false,
                                                    lengthLimit: 0,
                                                    callback: (value) =>
                                                    phone = value),
                                                MyTextboxTitle(
                                                    title: 'آدرس',
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
                                    padding: kIsWeb
                                        ? const EdgeInsets.symmetric(
                                        horizontal: 20)
                                        : const EdgeInsets.symmetric(
                                        horizontal: 5),
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
                                            _loadedList[ index]['phone'] == null ? phone= "" : phone= _loadedList[ index]['phone'];
                                            _loadedList[ index]['address'] == null ? address= "" : address= _loadedList[ index]['address'];
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (builder) {
                                                  return Container(
                                                    height: kIsWeb ? 500 : MediaQuery.of(context).size.height,
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

                                                              children: [
                                                              const SizedBox(height: 40,),
                                                                MyTextboxTitle(
                                                                    title: 'نام طرف حساب',
                                                                    isNumber:false,
                                                                    isPrice:false,
                                                                    lengthLimit:0,
                                                                    initialText:_loadedList[index]['name'],
                                                                    callback:(value) { name =value;


                                                                    }),
                                                                MyTextboxTitle(
                                                                    title: 'تلفن',
                                                                    isNumber:false,
                                                                    isPrice:false,
                                                                    lengthLimit:0,
                                                                    initialText:_loadedList[index]['phone'],
                                                                    callback:(value) { phone =value;


                                                                    }),
                                                                MyTextboxTitle(
                                                                    title: 'آدرس',
                                                                    isNumber:false,
                                                                    isPrice:false,
                                                                    lengthLimit:0,
                                                                    initialText:_loadedList[index]['address'],
                                                                    callback:(value) { address =value;


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
                                                                      MyButton(text:'حذف طرف حساب',callback:onPressDelete),

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
