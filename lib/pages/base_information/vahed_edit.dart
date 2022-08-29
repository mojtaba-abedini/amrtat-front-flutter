import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/button.dart';
import '../../widgets/textbox_title.dart';

class VahedEdit extends StatefulWidget {
  VahedEdit({Key? key, required this.storeName, required this.storeId})
      : super(key: key);
  String storeName;
  int storeId;

  @override
  State<VahedEdit> createState() => _VahedEditState();
}

class _VahedEditState extends State<VahedEdit> {
  void onPressButton() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویرایش واحد'),
        centerTitle: true,
        toolbarHeight: 75,
      ),
      body: Center(
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
                    initialText: widget.storeName,
                    callback: (value) => null),

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
                      MyButton(text: 'حذف واحد', callback: onPressButton),
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
