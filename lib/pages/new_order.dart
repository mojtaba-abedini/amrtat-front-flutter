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
                  isPrice: false,
                  lengthLimit: 0,
                  callback: (value) => newOrderName = value),
              MyTextboxTitle(
                  title: 'تلفن تماس',
                  isNumber: true,
                  isPrice: false,
                  lengthLimit: 10,
                  callback: (value) => newOrderPhone = value),
              MyDropDown(
                  title: 'نوع سفارش',
                  initIndex: () => orderType[0]['name'],
                  initStateIndex: () =>
                      newOrderType = orderType[0]['name'] as String,
                  mapVariabale: orderType,
                  mapFeild: 'name',
                  callback: (value) => newOrderType = value),
              MyDropDown(
                  title: 'سایز محصول',
                  initIndex: () => orderSize[0]['size'],
                  initStateIndex: () =>
                      newOrderSize = orderSize[0]['size'] as String,
                  mapVariabale: orderSize,
                  mapFeild: 'size',
                  callback: (value) => newOrderSize = value),
              MyDropDown(
                  title: 'سلفون',
                  initIndex: () => orderAttribute[0]['name'],
                  initStateIndex: () =>
                      newOrderSize = orderAttribute[0]['name'] as String,
                  mapVariabale: orderAttribute,
                  mapFeild: 'name',
                  callback: (value) => selefon = value),
              MyDropDown(
                  title: 'طلاکوب',
                  initIndex: () => orderAttribute[0]['name'],
                  initStateIndex: () =>
                      newOrderSize = orderAttribute[0]['name'] as String,
                  mapVariabale: orderAttribute,
                  mapFeild: 'name',
                  callback: (value) => talakoob = value),
              MyDropDown(
                  title: 'یووی و امباس',
                  initIndex: () => orderAttribute[0]['name'],
                  initStateIndex: () =>
                      newOrderSize = orderAttribute[0]['name'] as String,
                  mapVariabale: orderAttribute,
                  mapFeild: 'name',
                  callback: (value) => UV = value),
              MyDropDown(
                  title: 'لترپرس و خط تا برجسته',
                  initIndex: () => orderAttribute[0]['name'],
                  initStateIndex: () =>
                      newOrderSize = orderAttribute[0]['name'] as String,
                  mapVariabale: orderAttribute,
                  mapFeild: 'name',
                  callback: (value) => letterPress = value),
              MyDropDown(
                  title: 'صحافی و بسته بندی',
                  initIndex: () => orderAttribute[0]['name'],
                  initStateIndex: () =>
                      newOrderSize = orderAttribute[0]['name'] as String,
                  mapVariabale: orderAttribute,
                  mapFeild: 'name',
                  callback: (value) => sahafi = value),
              MyTextboxTitle(
                  title: 'مبلغ کل سفارش',
                  isNumber: true,
                  isPrice: true,
                  lengthLimit: 0,
                  callback: (value) => newOrderPrice = value),
              MyTextboxTitle(
                  title: 'مبلغ بیعانه',
                  isNumber: true,
                  isPrice: true,
                  lengthLimit: 0,
                  callback: (value) => newOrderFirstPrice = value),

              MyDatePicker(
                  title: 'تاریخ واریز بیعانه',
                  callback: (jalaliDate, georgianDate) =>
                      newOrderFirstPriceDate = jalaliDate),

              MyDropDown(
                  title: 'بانک واریز بیعانه',
                  initIndex: () => banks[0]['name'],
                  initStateIndex: () =>
                      newOrderBank = banks[0]['name'] as String,
                  mapVariabale: banks,
                  mapFeild: 'name',
                  callback: (value) => newOrderBank = value),
              const SizedBox(
                height: 20,
              ),
              MyButton(text: 'ذخیره', callback: onPressButton),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )));
  }
}
