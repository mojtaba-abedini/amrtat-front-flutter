import 'package:amertat/store.dart';
import 'package:flutter/material.dart';
import 'package:amertat/libraries/persian_date_picker/persian_datetime_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyDatePicker extends StatefulWidget {
  MyDatePicker(
      {Key? key, required this.title, required this.callback, this.initialDate})
      : super(key: key);

  String? initialDate;
  String title;
  Function callback;

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late TextEditingController pickedDate = TextEditingController();

  String? persianLabel, georgianLabel, persianInitDate;
  List? initDate;
  Jalali? persianInitDateJalali;

  void getInitPersianDateFromGeorgian() {
    if (widget.initialDate != null) {
      initDate = widget.initialDate!.split('-');
      Gregorian g = Gregorian(int.parse(initDate![0]), int.parse(initDate![1]),
          int.parse(initDate![2]));
      persianInitDateJalali = Jalali.fromGregorian(g);

      Jalali j = Jalali(
          persianInitDateJalali?.year as int,
          persianInitDateJalali?.month as int,
          persianInitDateJalali?.day as int);

      persianInitDate = "${j.year}-${j.month}-${j.day}";

      setState(() {
        pickedDate.text = persianInitDate!;
      });
    }
  }

  void refreshDate() {
    pickedDate.text = persianLabel!;
    widget.callback(persianLabel, georgianLabel);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       getInitPersianDateFromGeorgian();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
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
                    widget.title,
                    style: const TextStyle(
                        color: Palette.myFirstColor, fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: Material(
                    // elevation: 3,
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(children: [
                      TextField(
                        // keyboardType: TextInputType.multiline,
                        // maxLines: null,
                        readOnly: true,
                        controller: pickedDate,
                        cursorColor: Colors.grey,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: IconButton(
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
                                // persianLabel=picked?.formatCompactDate();
                                Gregorian g = Gregorian.fromJalali(j);
                                georgianLabel = "${g.year}-${g.month}-${g.day}";

                                refreshDate();
                              },
                              icon: const Icon(Icons.date_range),
                              color: Palette.myFirstColor,
                            ),
                          ),
                          contentPadding: kIsWeb
                              ? const EdgeInsets.only(
                                  left: 15, top: 18, bottom: 18, right: 15)
                              : const EdgeInsets.only(
                                  left: 15, top: 13, bottom: 13, right: 15),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.9, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.9,
                                color: Palette.myFirstColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ]),
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
