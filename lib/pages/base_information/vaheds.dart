import 'package:amertat/pages/base_information/store_edit.dart';
import 'package:amertat/pages/base_information/vahed_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../../widgets/button.dart';



class Vaheds extends StatefulWidget {
  const Vaheds({Key? key}) : super(key: key);

  @override
  State<Vaheds> createState() => _VahedsState();
}

class _VahedsState extends State<Vaheds> {
  List _vahes = [
    {'id': 1, 'name': 'کیلوگرم'},
    {'id': 2, 'name': 'رول'},
    {'id': 2, 'name': 'شیت'},
    {'id': 2, 'name': 'عدد'},

  ];
  void onPressButton() {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('واحدها'),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width < 600
              ? MediaQuery.of(context).size.width
              : 600,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 10,right: 20,left: 20),
              child: Column(
                children: [
                  MyButton(text: 'اضافه کردن واد', callback: onPressButton),
                  Expanded(
                    child: _vahes.isNotEmpty
                        ? ListView.builder(
                      itemCount: _vahes.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: 50,
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                // padding: const EdgeInsets.only(left: 20),
                                onPrimary: Theme.of(context).primaryColor,
                                elevation: 4,
                                primary: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VahedEdit(
                                            storeName: _vahes[index]['name'],
                                            storeId: _vahes[index]['id'])));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.assignment_turned_in,
                                    color: Colors.black87,
                                    size: 19,
                                  ),
                                  Text(
                                    _vahes[index]['name'],
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
                  ),
                ],
              ),



            ),
          ),
        ),
      ),
    );
  }
}
