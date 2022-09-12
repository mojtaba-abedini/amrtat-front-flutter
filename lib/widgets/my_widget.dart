import 'package:flutter/material.dart';

class MyWidgets {

  static Widget dropDownWidget(BuildContext context,
      String title,
      String hintText,
      dynamic value,
      List<dynamic> lstData,
      Function onChanged,
      Function onValidate, {
        double hintFontSize = 16,
        Color borderColor = Colors.redAccent,
        double borderRadius = 5,
        Color borderFocusColor = Colors.redAccent,
        double paddingLeft = 0,
        double paddingRight = 0,
        double paddingTop = 0,
        double paddingBottom = 0,
        String optionValue = "id",
        String optionLabel = "name",
        double contentPadding = 6,
        Color validationColor = Colors.redAccent,
        Color textColor = Colors.black,
        Color hintColor = Colors.black,
        double borderWidth = 2,
        double focusedBorderWidth = 2,
        double enabledBorderWidth = 1,
        Widget? suffixIcon,
        Icon? prefixIcon,
        bool showPrefixIcon = false,
        Color prefixIconColor = Colors.redAccent,
        double prefixIconPaddingLeft = 30,
        double prefixIconPaddingRight = 10,
        double prefixIconPaddingTop = 0,
        double prefixIconPaddingBottom = 0,
      }) {
    if (value != "") {
      var findValue = lstData
          .where((item) => item[optionValue].toString() == value.toString());

      if (findValue.length > 0) {
        value = findValue.first[optionValue].toString();
      } else {
        value = null;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 600
            ? MediaQuery.of(context).size.width
            : 600,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black87, fontSize: 17),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: paddingLeft,
                  right: paddingRight,
                  top: paddingTop,
                  bottom: paddingBottom,
                ),
                child: FormField<dynamic>(
                  builder: (FormFieldState<dynamic> state) {
                    return DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: value != "" ? value : null,
                      isDense: true,
                      hint: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          hintText,
                          style: TextStyle(
                            fontSize: hintFontSize,
                          ),
                        ),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(contentPadding),
                        errorStyle: TextStyle(
                          color: validationColor,
                        ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: hintFontSize,
                          color: hintColor,
                        ),
                        hintText: hintText,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: borderColor,
                            width: enabledBorderWidth,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                          borderSide: BorderSide(
                            color: borderColor,
                            width: borderWidth,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: borderFocusColor,
                            width: focusedBorderWidth,
                          ),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        suffixIcon: suffixIcon,
                        prefixIcon: showPrefixIcon
                            ? Padding(
                          padding: EdgeInsets.only(
                            left: prefixIconPaddingLeft,
                            right: prefixIconPaddingRight,
                            top: prefixIconPaddingTop,
                            bottom: prefixIconPaddingBottom,
                          ),
                          child: IconTheme(
                            data: IconThemeData(color: prefixIconColor),
                            child: prefixIcon!,
                          ),
                        )
                            : null,
                      ),
// decoration: InputDecoration(
//   contentPadding: EdgeInsets.all(contentPadding),
//   hintStyle: TextStyle(
//     fontWeight: FontWeight.bold,
//     fontSize: hintFontSize,
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(borderRadius),
//     borderSide: BorderSide(
//       color: borderColor,
//       width: 1,
//     ),
//   ),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(borderRadius),
//     borderSide: BorderSide(
//       color: borderColor,
//       width: 2,
//     ),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderSide: BorderSide(
//       color: borderFocusColor,
//       width: 2.0,
//     ),
//     borderRadius: BorderRadius.circular(borderRadius),
//   ),
// ),
                      onChanged: (newValue) {
//  FocusScope.of(context).requestFocus(new FocusNode());
                        state.didChange(newValue);
                        return onChanged(newValue);
                      },
                      validator: (value) {
                        return onValidate(value);
                      },
                      items: lstData.map<DropdownMenuItem<String>>(
                            (dynamic data) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerRight,
                            value: data[optionValue].toString(),
                            child:  Padding(
                              padding: const EdgeInsets.only(right: 10,left: 10),
                              child: Text(
                                data[optionLabel],
                                style:  const TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20,),
            ],

          ),
        ),
      ),
    );
  }
}

