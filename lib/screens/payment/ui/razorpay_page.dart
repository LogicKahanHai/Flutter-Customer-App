import 'package:flutter/material.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPage extends StatefulWidget {
  final CreateOrderModel order;
  const RazorpayPage({super.key, required this.order});

  @override
  State<RazorpayPage> createState() => _RazorpayPageState();
}

class _RazorpayPageState extends State<RazorpayPage> {
  final _razorpay = Razorpay();

  final options = {};

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) {}

  _handlePaymentError(PaymentFailureResponse paymentFailureResponse) {}

  _handleExternalWallet(ExternalWalletResponse externalWalletResponse) {}
}
