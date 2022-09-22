import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  static const orderApiUrl = OrderApi;
  static const tarafHesabApiUrl = TarafHesabApi;
  static const jensApiUrl = JensApi;
  static const sizeApiUrl = SizeApi;
  List _loadedOrder =[];
  List _loadedSize =[];
  List _loadedJens =[];
  List _loadedTarafHesab =[];
  bool _isLoading = true;
  String? tarafHesabId;

  Future<void> _fetch() async {
    final responseOrder = await http.get(Uri.parse(orderApiUrl));
    final dataOrder = json.decode(responseOrder.body);

    final responseTarafHesab = await http.get(Uri.parse(tarafHesabApiUrl));
    final dataTarafHesab = json.decode(responseTarafHesab.body);

    final responseJens = await http.get(Uri.parse(jensApiUrl));
    final dataJens = json.decode(responseJens.body);

    final responseSize = await http.get(Uri.parse(sizeApiUrl));
    final dataSize = json.decode(responseSize.body);

    setState(() {
      _loadedOrder = dataOrder['data'];
      _loadedTarafHesab = dataTarafHesab['data'];
      _loadedJens =  dataJens ['data'];
      _loadedSize=  dataSize['data'];

    });
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }


  String getTarafHesabNameById(int tarafHesabId) {
    final foundedTarafHesab =
    _loadedTarafHesab.singleWhere((element) => element['id'] == tarafHesabId);
    return foundedTarafHesab['name'];
  }

  String getJensNameById(int jensId) {
    final foundedTarafHesab =
    _loadedJens.singleWhere((element) => element['id'] == jensId);
    return foundedTarafHesab['name'];
  }

  String getSizeNameById(int sizeId) {
    final foundedTarafHesab =
    _loadedSize.singleWhere((element) => element['id'] == sizeId);
    return foundedTarafHesab['name'];
  }










  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width < 600
            ? MediaQuery.of(context).size.width
            : 600,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30, bottom: 30, right: 20, left: 20),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: _loadedOrder.isNotEmpty
                  ? ListView.builder(
                itemCount: _loadedOrder.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          onPrimary:
                          Theme.of(context).primaryColor,
                          elevation: 4,
                          primary: Colors.white,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'شماره سفارش : ${_loadedOrder[index]['order_number']}',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryColor,
                                  fontFamily: 'IranYekan',
                                  fontSize: 12,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getTarafHesabNameById(_loadedOrder[index]['taraf_hesab_id']),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'IranYekan',
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  "${getJensNameById(_loadedOrder[index]['jens_id'])} - ${getSizeNameById(_loadedOrder[index]['size_id'])}",
                                  style:  TextStyle(
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontFamily: 'IranYekan',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black87,
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  : const Text(
                'سایزی یافت نشد',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
