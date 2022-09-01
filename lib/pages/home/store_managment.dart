
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class StoreManagement extends StatefulWidget {
  const StoreManagement({Key? key}) : super(key: key);

  @override
  State<StoreManagement> createState() => _StoreManagementState();
}

class _StoreManagementState extends State<StoreManagement> {
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('مدیریت انبار'),
    );
  }

}
