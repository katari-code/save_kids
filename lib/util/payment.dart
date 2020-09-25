import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final String appID = 'safe_kids_ui2001';
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  bool _available = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _initialize() async {
    _available = await _iap.isAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
