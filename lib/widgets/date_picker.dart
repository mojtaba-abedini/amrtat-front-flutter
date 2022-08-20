import 'package:flutter/material.dart';
import 'package:amertat/libraries/persian_date_picker/persian_datetime_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key, required this.title, required this.callback})
      : super(key: key);

  final String title;
  final Function callback;

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late TextEditingController pickedDate = TextEditingController();
  var persianLabel;
  var georgianLabel;

  void refreshDate() {
    pickedDate.text = persianLabel;
    widget.callback(persianLabel, georgianLabel);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 600
            ? MediaQuery.of(context).size.width
            : 600,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(5),
              child: Stack(children: [
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: pickedDate,
                  cursorColor: Colors.grey,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        Jalali? picked = await showPersianDatePicker(
                          context: context,
                          initialDate: Jalali.now(),
                          firstDate: Jalali(1385, 8),
                          lastDate: Jalali(1450, 9),
                        );

                        Jalali j = Jalali(picked?.year as int,
                            picked?.month as int, picked?.day as int);

                        persianLabel = "${j.year}-${j.month}-${j.day}";
                        Gregorian g = Gregorian.fromJalali(j);
                        georgianLabel = "${g.year}-${g.month}-${g.day}";

                        refreshDate();
                      },
                      icon: const Icon(Icons.date_range),
                      color: Theme.of(context).primaryColor,
                    ),
                    contentPadding: kIsWeb
                        ? const EdgeInsets.only(left: 15, top: 18, bottom: 18)
                        : const EdgeInsets.only(left: 13, top: 13, bottom: 13),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.9, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.9, color: Colors.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}