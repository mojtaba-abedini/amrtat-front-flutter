import 'package:amertat/widgets/button.dart';
import 'package:amertat/widgets/date_picker.dart';
import 'package:amertat/widgets/textbox_title.dart';
import 'package:flutter/material.dart';
import 'package:amertat/store.dart';

class NewCustomer extends StatefulWidget {
  const NewCustomer({Key? key}) : super(key: key);

  @override
  State<NewCustomer> createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
  void onPressButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت مشتری جدید'),
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
                  title: 'نام و نام خانوادگی',
                  isNumber: false,
                  isPrice: false,
                  lengthLimit: 0,
                  callback: (value) => newCustomerName = value),
              MyTextboxTitle(
                  title: 'تلفن تماس',
                  isNumber: true,
                  isPrice: false,
                  lengthLimit: 10,
                  callback: (value) => newCustomerPhone = value),
              MyDatePicker(
                  title: 'تاریخ تماس',
                  callback: (jalaliDate,georgianDate) => newCustomerContactDate = jalaliDate),
              MyTextboxTitle(
                  title: 'نوع سفارش',
                  isNumber: false,
                  isPrice: false,
                  lengthLimit: 0,
                  callback: (value) => newCustomerOrderDescription = value),
              MyTextboxTitle(
                  title: 'تعداد درخواستی',
                  isNumber: true,
                  isPrice: false,
                  lengthLimit: 0,
                  callback: (value) => newCustomerOrderCount = value),
              const SizedBox(
                height: 20,
              ),
              MyButton(text: 'ذخیره', callback: onPressButton),

            ],
          ),
        ),
      ),
    );
  }
}
