import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../../store.dart';
import '../../widgets/button.dart';
import '../../widgets/date_picker.dart';

class StoreManagement extends StatefulWidget {
  const StoreManagement({Key? key}) : super(key: key);

  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
  String? _orderDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyDatePicker(
                title: 'تاریخ واریز بیعانه',
                initialDate: '2022-9-21',
                callback: (jalaliDate, georgianDate) {
                  _orderDate = georgianDate;
                  print(_orderDate);
                }),
          ],
        ),
      ),
    );
  }
}
