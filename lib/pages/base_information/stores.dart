import 'package:amertat/pages/base_information/store_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../../widgets/button.dart';



class Stores extends StatefulWidget {
  const Stores({Key? key}) : super(key: key);

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  List _anbar = [
    {'id': 1, 'name': 'انبار اول'},
    {'id': 2, 'name': 'انبار دوم'}
  ];
  void onPressButton() {

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انبارها'),
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
                  MyButton(text: 'اضافه کردن انبار', callback: onPressButton),
                  Expanded(
                    child: _anbar.isNotEmpty
                        ? ListView.builder(
                      itemCount: _anbar.length,
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
                                        builder: (context) => StoreEdit(
                                            storeName: _anbar[index]['name'],
                                            storeId: _anbar[index]['id'])));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.store,
                                    color: Colors.black87,
                                    size: 19,
                                  ),
                                  Text(
                                    _anbar[index]['name'],
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
