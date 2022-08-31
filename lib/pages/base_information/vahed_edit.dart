import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api.dart';
import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VahedEdit extends StatefulWidget {
  VahedEdit({Key? key, required this.vahedName, required this.vahedId})
      : super(key: key);
  String vahedName;

  int vahedId;

  @override
  State<VahedEdit> createState() => _VahedEditState();
}

class _VahedEditState extends State<VahedEdit> {
  late String name;
  bool _isLoading = false;

  void onPressEdit() async {
    setState(() {
      _isLoading = true;
    });
    http.Response response = await editVaheds(name, widget.vahedId);
    print(response.body);
    Navigator.pop(context);
  }

  void onPressDelete() async{
    setState(() {
      _isLoading = true;
    });
    http.Response response = await deleteVaheds(widget.vahedId);
    print(response.body);
    Navigator.pop(context);
  }

  Future<http.Response> editVaheds(String name, int id) {
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

  Future<http.Response> deleteVaheds(int id) {
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
    name = widget.vahedName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویرایش واحد'),
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
                          title: 'نام واحد',
                          isNumber: false,
                          isPrice: false,
                          lengthLimit: 0,
                          initialText: widget.vahedName,
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
                            MyButton(text: 'حذف واحد', callback: onPressDelete),
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
