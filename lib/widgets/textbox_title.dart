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
        required this.isPrice,
        required this.lengthLimit,
        this.initialText


      })
      : super(key: key);

  final bool isNumber;
  String? initialText;
  final bool isPrice;
  final String title;
  final Function callback;
  final int lengthLimit;


  @override
  State<MyTextboxTitle> createState() => _MyTextboxTitleState();
}

class _MyTextboxTitleState extends State<MyTextboxTitle> {
  late TextEditingController textboxValue = TextEditingController();

  @override
  void initState() {

    super.initState();
    widget.initialText != null ? textboxValue.text = widget.initialText!  : null;
  }

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
                style: const TextStyle(color: Colors.black87, fontSize: 17),
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
                        ? const EdgeInsets.all(15)
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
                  inputFormatters: widget.lengthLimit == 0 && widget.isPrice == false
                      ? null
                      : (widget.lengthLimit == 0 && widget.isPrice == true
                      ? <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter(),
                  ]
                      : ((widget.lengthLimit != 0 && widget.isPrice == true
                      ? <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(widget.lengthLimit),
                    ThousandsSeparatorInputFormatter(),
                  ]
                      : ((widget.lengthLimit != 0 && widget.isPrice == false
                      ? <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(
                        widget.lengthLimit)
                  ]
                      : null))))),
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





// class MyTextboxTitle extends StatelessWidget {
//   MyTextboxTitle(
//       {Key? key,
//       required this.title,
//       required this.callback,
//       required this.isNumber,
//       required this.isPrice,
//       required this.lengthLimit,
//       this.initialText
//
//
//       })
//       : super(key: key);
//
//   final bool isNumber;
//   String? initialText;
//   final bool isPrice;
//   final String title;
//   final Function callback;
//   final int lengthLimit;
//   late TextEditingController textboxValue = TextEditingController();
//
//
//   if(initialText != null) {textboxValue = initialText;}
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width < 600
//                 ? MediaQuery.of(context).size.width
//                 : 600,
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 title,
//                 style: const TextStyle(color: Colors.black87, fontSize: 17),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width < 600
//                   ? MediaQuery.of(context).size.width
//                   : 600,
//               height: 50,
//               child: Material(
//                 elevation: 3,
//                 borderRadius: BorderRadius.circular(5),
//                 child: TextField(
//                   onChanged: (content) {
//                     callback(content);
//                   },
//                   controller: textboxValue,
//                   autofocus: true,
//                   cursorColor: Colors.grey,
//                   textAlign: TextAlign.right,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                   decoration: InputDecoration(
//                     contentPadding: kIsWeb
//                         ? const EdgeInsets.all(17)
//                         : const EdgeInsets.all(13),
//                     filled: true,
//                     fillColor: Colors.white70,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                           const BorderSide(width: 0.9, color: Colors.grey),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 0.9, color: Theme.of(context).primaryColor),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   keyboardType: isNumber ? TextInputType.number : null,
//                   inputFormatters: lengthLimit == 0 && isPrice == false
//                       ? null
//                       : (lengthLimit == 0 && isPrice == true
//                           ? <TextInputFormatter>[
//                               ThousandsSeparatorInputFormatter(),
//                             ]
//                           : ((lengthLimit != 0 && isPrice == true
//                               ? <TextInputFormatter>[
//                                   LengthLimitingTextInputFormatter(lengthLimit),
//                                   ThousandsSeparatorInputFormatter(),
//                                 ]
//                               : ((lengthLimit != 0 && isPrice == false
//                                   ? <TextInputFormatter>[
//                                       LengthLimitingTextInputFormatter(
//                                           lengthLimit)
//                                     ]
//                                   : null))))),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
