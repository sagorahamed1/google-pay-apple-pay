import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:google_pay/payment_config.dart';  // Assume this contains your JSON payment configurations

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Demo',
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    // Apple Pay button configuration (for iOS)
    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      )
    ];

   var applePayButton =  ApplePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(
          defaultApplePay),
      paymentItems: _paymentItems,
      style: ApplePayButtonStyle.black,
      type: ApplePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: (result)=> print("========$result"),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );

   var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(
    defaultGooglePay),
    paymentItems: _paymentItems,
    type: GooglePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result)=> print("=======> $result"),
    loadingIndicator: const Center(
    child: CircularProgressIndicator(),
    ),
    );

     onApplePayResult(paymentResult) {

    }

     onGooglePayResult(paymentResult) {
      print(';');
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Demo')),
      body: Center(
        child: Platform.isIOS ? applePayButton : googlePayButton,
      ),
    );
  }
}
