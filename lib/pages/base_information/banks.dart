import 'dart:convert';
import 'package:amertat/pages/base_information/bank_add.dart';
import 'package:amertat/pages/base_information/bank_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';

class Banks extends StatefulWidget {
  const Banks({Key? key}) : super(key: key);

  @override
  State<Banks> createState() => _BanksState();
}

class _BanksState extends State<Banks> {
  bool _isLoading = true;

  List _bank = [];

  Future<void> _fetchBank() async {
    const apiUrl = getAllBank;
    final response = await http.get(Uri.parse(apiUrl));
    final data = json.decode(response.body);

    setState(() {
      _bank = data['data'];
    });
    _isLoading = false;
  }

  void onPressButton() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => const BankAdd()))
        .then((value) => _fetchBank());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بانک ها'),
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
                            text: 'اضافه کردن بانک', callback: onPressButton),
                        Expanded(
                          child: _bank.isNotEmpty
                              ? ListView.builder(
                                  itemCount: _bank.length,
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
                                                        BankEdit(
                                                            bankName:
                                                            _bank[index]
                                                                    ['name'],
                                                            bankId:
                                                            _bank[index]
                                                                    ['id']))).then((value) => _fetchBank());
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(
                                                Icons.monetization_on,
                                                color: Colors.black87,
                                                size: 19,
                                              ),
                                              Text(
                                                _bank[index]['name'],
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
                                  'بانکی یافت نشد',
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
