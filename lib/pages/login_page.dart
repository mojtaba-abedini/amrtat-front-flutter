import 'package:amertat/main.dart';
import 'package:amertat/store.dart';
import 'package:amertat/widgets/button.dart';
import 'package:amertat/widgets/textbox_title.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String? _email;
  String? _password;
  String _payam="";

  static const loginApiUrl = LoginApi;


  void login() async {
    setState(() {
      _isLoading = true;
    });

    http.Response response = await create(_email!,_password!);
    final data = json.decode(response.body);
  //  print(response.body);


     setState(() {
       if (data['status'] == 'error') {_payam = 'نام کاربری یا رمز عبور اشتباه است';}
       else{
         _payam = '';
         LoginToken = data['data']['token'];

         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => const MyHomePage(title: 'آمرتات بگ')));
         // print(LoginToken);
       };
       _isLoading = false;

     });


  }



  Future<http.Response> create(String email,String password) {
    return http.post(
      Uri.parse(loginApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.myFirstColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text(_payam,style: const TextStyle(color: Colors.white,fontSize: 16) ,),
            const SizedBox(height: 20,),
            MyTextboxTitle(title: 'ایمیل', titleColor: Colors.white, callback: (value) => _email = value, isNumber: false, isPrice: false, lengthLimit: 0),
            MyTextboxTitle(title: 'رمز عبور', titleColor: Colors.white,callback: (value) => _password = value, isNumber: false, isPrice: false, lengthLimit: 0),
            const SizedBox(height: 20,),
            MyButton(text: 'ورود', callback: login,isLoading: _isLoading,)
          ],
        ),
      ),
    );
  }
}
