import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BankEdit extends StatefulWidget {
  BankEdit({Key? key, required this.bankName, required this.bankId})
      : super(key: key);
  String bankName;

  int bankId;

  @override
  State<BankEdit> createState() => _BankEditState();
}

class _BankEditState extends State<BankEdit> {
  late String name;
  bool _isLoading = false;

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    http.Response response = await editBanks(name, widget.bankId);
    print(response.body);
    Navigator.pop(context);
  }

  void onPressDelete() async{
    setState(() {
      _isLoading = true;
    });
    http.Response response = await deleteBanks(widget.bankId);
    print(response.body);
    Navigator.pop(context);
  }

  Future<http.Response> editBanks(String name, int id) {
    return http.put(
      Uri.parse("$editBank/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );
  }

  Future<http.Response> deleteBanks(int id) {
    return http.delete(
      Uri.parse("$deleteBank/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      );
  }


  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.bankName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویرایش بانک'),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextboxTitle(
                          title: 'نام بانک',
                          isNumber: false,
                          isPrice: false,
                          lengthLimit: 0,
                          initialText: widget.bankName,
                          callback: (value) => name = value),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width < 600
                            ? MediaQuery.of(context).size.width
                            : 600,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MyButton(text: 'ذخیره', callback: onPressEdit),
                            MyButton(text: 'حذف بانک', callback: onPressDelete),
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
    );
  }
}
