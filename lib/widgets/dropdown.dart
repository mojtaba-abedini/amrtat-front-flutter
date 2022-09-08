import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown(
      {Key? key,
      required this.title,
      required this.mapVariabale,
      required this.mapFeild,
      required this.callback,
      required this.initIndex,
      required this.initStateIndex,
      this.isRefresh})
      : super(key: key);

  final String title;
  final List mapVariabale;
  final String mapFeild;
  final Function callback;
  final Function initIndex;
  final Function initStateIndex;
  final bool? isRefresh;

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  late TextEditingController pickedDate = TextEditingController();
  late String dropdownValue = widget.initIndex() as String;


  @override
  void initState() {
    super.initState();
    widget.initStateIndex();
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
                style: const TextStyle(color: Colors.black87, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width < 600
                    ? MediaQuery.of(context).size.width
                    : 600,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButton<String>(
                    icon: const Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    value: dropdownValue,
                    elevation: 16,
                    iconSize: 0,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        widget.callback(newValue);
                      });

                      // setState(() {
                      //   widget.mapVariabale;
                      //   dropdownValue = newValue!;
                      //   widget.callback(newValue);
                      //   //print("map variable ${widget.mapVariabale}");
                      // });
                    },
                    items: widget.mapVariabale.map((value) {
                      // setState(() {
                      //   dropdownValue = widget.mapVariabale[0]['name'];
                      // });
                      return DropdownMenuItem<String>(
                        alignment: Alignment.center,
                        value: value[widget.mapFeild] as String,
                        child: Text(
                          value[widget.mapFeild] as String,
                          style: const TextStyle(
                              fontFamily: 'IranYekan', fontSize: 17),
                        ),
                      );
                    }).toList(),
                    underline: Container(),
                  ),
                ),
              ),
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
