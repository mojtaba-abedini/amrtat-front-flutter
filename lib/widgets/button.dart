import 'package:amertat/store.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.text, required this.callback})
      : super(key: key);

  final String text;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          width: 180,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              onPrimary: Colors.lightBlueAccent,
              // elevation: 3,
              primary: Palette.mySecondColor,
            ),
            onPressed: () => callback(),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'IranYekan',
                fontSize: text == "+" ? 25 : 15,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30,)
      ],
    );
  }

}
