import 'package:amertat/widgets/button.dart';
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
  void onPressButton() {
    Navigator.pop(context);
    print(newOrderType);
  }

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
              const SizedBox(
                height: 20,
              ),
              MyTextboxTitle(
                  title: 'نام و نام خانوادگی مشتری',
                  isNumber: false,
                  lengthLimit: 0,
                  callback: (value) => newOrderName = value),
              MyTextboxTitle(
                  title: 'تلفن تماس',
                  isNumber: true,
                  lengthLimit: 10,
                  callback: (value) => newOrderPhone = value),
              MyDropDown(
                  title: 'نوع سفارش',
                  // set first value of dropdown
                  initIndex: () => orderType[0]['name'],
                  // set variable by first value of dropdown
                  initStateIndex: () =>
                      newOrderType = orderType[0]['name'] as String,
                  callback: (value) => newOrderType = value),
              MyDatePicker(
                  title: 'تاریخ تماس',
                  callback: (jalaliDate, georgianDate) =>
                      newOrderDate = jalaliDate),
              const SizedBox(
                height: 20,
              ),
              MyButton(text: 'ذخیره', callback: onPressButton)
            ],
          ),
        )));
  }
}
