import 'package:amertat/pages/base_information/vaheds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VahedAdd extends StatefulWidget {
  const VahedAdd({Key? key})
      : super(key: key);

  @override
  State<VahedAdd> createState() => _VahedAddState();
}

class _VahedAddState extends State<VahedAdd> {
  late String name;
  bool _isLoading = false;


  void onPressButton() async{
    setState(() {
      _isLoading=true;
    });
    http.Response response = await createVaheds(name);
    print(response.body);
    Navigator.pop(context,true);

 }



  Future<http.Response> createVaheds(String name) {
    return http.post(
      Uri.parse(createVahed),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اضافه کردن واحد'),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextboxTitle(
                    title: 'نام واحد',
                    isNumber: false,
                    isPrice: false,
                    lengthLimit: 0,
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
                      MyButton(text: 'ذخیره', callback: onPressButton),

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
