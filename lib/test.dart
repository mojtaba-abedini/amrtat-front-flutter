import 'package:flutter/material.dart';

import 'store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _selectedJens = jens[0]['name'] as String;
  List _jenses = [];

  JensDependentDropDown() {
    jens.forEach((value) {
      _jenses.add(value['name']);
    });
  }

  String _selectedSize = "";
  List _sizes = [];

  SizeDependentDropDown(jensKarbari) {
    size.forEach((value) {
      if (jensKarbari == value['karbari']) {
        _sizes.add(value['name']);
      }
    });

    _selectedSize = _sizes[0];
  }

  @override
  void initState() {
    super.initState();
    JensDependentDropDown();
    SizeDependentDropDown(_selectedJens);
  }

  void onPressButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // MyDropDown(
            //     title: 'نوع سفارش',
            //
            //     mapField: 'name',
            //     mapVariabale: jens,
            //     callback: (value) {
            //       print(value);
            //       newOrderType = value;
            //
            //     }),
            // MyDropDown(
            //     title: 'سایز محصول',
            //
            //     mapField: 'name',
            //     is: false,
            //     filterValue: 'karbari',
            //     mapVariabale: size,
            //     callback: (value) {
            //       newOrderType = value;
            //
            //     }),
            const SizedBox(
              height: 23,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width
                    : 600,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
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
                                _sizes = [];
                                SizeDependentDropDown(newValue);
                                _selectedJens = "$newValue";
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
                            items: _jenses.map((value) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontFamily: 'IranYekan', fontSize: 17),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.title,
                        style: const TextStyle(
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
                                _selectedSize = "$newValue";
                                print('sdfsdfsdf');
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
                            items: _sizes.map((value) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontFamily: 'IranYekan', fontSize: 17),
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
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
