import 'dart:convert';
import 'package:amertat/pages/base_information/vahed_add.dart';
import 'package:amertat/pages/base_information/vahed_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';

class Vaheds extends StatefulWidget {
  const Vaheds({Key? key}) : super(key: key);

  @override
  State<Vaheds> createState() => _VahedsState();
}

class _VahedsState extends State<Vaheds> {
  bool _isLoading = true;

  List _vahed = [];

  Future<void> _fetchVahed() async {
    const apiUrl = getAllVahed;
    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _vahed = data['data'];
    });
    _isLoading = false;
  }

  void onPressButton() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => const VahedAdd()))
        .then((value) => _fetchVahed());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchVahed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('واحدها'),
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
                            text: 'اضافه کردن واحد', callback: onPressButton),
                        Expanded(
                          child: _vahed.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _vahed.length,
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
                                            // padding: const EdgeInsets.only(left: 20),
                                            onPrimary:
                                                Theme.of(context).primaryColor,
                                            elevation: 4,
                                            primary: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VahedEdit(
                                                            vahedName:
                                                                _vahed[index]
                                                                    ['name'],
                                                            vahedId:
                                                                _vahed[index]
                                                                    ['id']))).then((value) => _fetchVahed());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(
                                                Icons.assignment_turned_in,
                                                color: Colors.black87,
                                                size: 19,
                                              ),
                                              Text(
                                                _vahed[index]['name'],
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
                                  'واحدی یافت نشد',
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
