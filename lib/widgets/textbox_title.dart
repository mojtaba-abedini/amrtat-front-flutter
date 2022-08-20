import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:amertat/store.dart';

class MyTextboxTitle extends StatefulWidget {
  MyTextboxTitle(
      {Key? key,
      required this.title,
      required this.callback,
      required this.isNumber,
      required this.lengthLimit})
      : super(key: key);

  final bool isNumber;
  final String title;
  final Function callback;
  final int lengthLimit;

  @override
  State<MyTextboxTitle> createState() => _MyTextboxTitleState();
}

class _MyTextboxTitleState extends State<MyTextboxTitle> {
  late TextEditingController textboxValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width < 600
                ? MediaQuery.of(context).size.width
                : 600,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width < 600
                  ? MediaQuery.of(context).size.width
                  : 600,
              height: 50,
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                child: TextField(
                  onChanged: (content) {
                    widget.callback(content);
                  },
                  controller: textboxValue,
                  autofocus: true,
                  cursorColor: Colors.grey,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding: kIsWeb
                        ? const EdgeInsets.all(17)
                        : const EdgeInsets.all(13),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.9, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.9, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  keyboardType: widget.isNumber ? TextInputType.number : null,
                  inputFormatters: widget.lengthLimit == 0
                      ? null
                      : <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(widget.lengthLimit),
                        ], //
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
