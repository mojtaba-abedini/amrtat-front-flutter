import 'package:amertat/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:amertat/store.dart';
import '../widgets/date_picker.dart';
import '../widgets/textbox_title.dart';


class NewOrder extends StatefulWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ثبت سفارش جدید'),
          toolbarHeight: 75,
          centerTitle: true,
        ),
        body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextboxTitle(
                  title: 'نام و نام خانوادگی مشتری',
                  isNumber: false,
                  lengthLimit: 0,
                  callback: (value) => newCustomerName = value),
              MyTextboxTitle(
                  title: 'تلفن تماس',
                  isNumber: true,
                  lengthLimit: 10,
                  callback: (value) => newCustomerPhone = value),
              MyDropDown(title: 'نوع سفارش'),


              MyDatePicker(
                  title: 'تاریخ تماس',
                  callback: (jalaliDate,georgianDate) => newCustomerContactDate = jalaliDate),
            ],
          ),
        ))
    );
  }
}
