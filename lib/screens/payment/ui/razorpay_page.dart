import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/payment/ui/final_success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPage extends StatefulWidget {
  final OrderModel order;
  const RazorpayPage({super.key, required this.order});

  @override
  State<RazorpayPage> createState() => _RazorpayPageState();
}

class _RazorpayPageState extends State<RazorpayPage> {
  final _razorpay = Razorpay();

  Map<String, dynamic> options = {
    'key': 'rzp_live_tiyng6DKzOzWDR',
    'prefill': {
      'email': 'contact@patilkaki.com',
    }
  };

  void retry() {
    options['order_id'] = widget.order.razorpayOrderId;
    options['prefill']['contact'] = UserRepo.user.phone;
    _razorpay.open(options);
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    options['order_id'] = widget.order.razorpayOrderId;
    options['prefill']['contact'] = UserRepo.user.phone;
    _razorpay.open(options);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: PKTheme.primaryColor,
          strokeWidth: 2,
        ),
      ),
    );
  }

  _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) {
    BlocProvider.of<CartBloc>(context).add(CartClearEvent());
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      RouteAnimations(
        nextPage: FinalSuccess(
          order: widget.order,
        ),
        animationDirection: AnimationDirection.RTL,
      ).createRoute(),
    );
  }

  _handlePaymentError(PaymentFailureResponse paymentFailureResponse) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: const Text('Please retry payment'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              retry();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  _handleExternalWallet(ExternalWalletResponse externalWalletResponse) {
    print('External Wallet');
  }
}
