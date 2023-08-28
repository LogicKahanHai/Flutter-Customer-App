// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';

import '../../../../common/blocs/export_blocs.dart';
import '../../../../models/models.dart';

class OtpPage extends StatefulWidget {
  final String phone;
  const OtpPage({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _innerAnimations;
  late TextEditingController _otpController;
  late FocusNode _otpFocusNode;
  late AnimationController _outerAnimations;
  final VerifyBloc _verifyBloc = VerifyBloc();
  final UserBloc _userBloc = UserBloc();

  @override
  void dispose() {
    _innerAnimations.dispose();
    _outerAnimations.dispose();
    _otpFocusNode.dispose();
    _otpController.dispose();
    _verifyBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    initialiseStuff();
    super.initState();
  }

  void initialiseStuff() {
    _verifyBloc.add(VerifyInitialEvent(phone: widget.phone));
    _innerAnimations = AnimationController(
      vsync: this,
      duration: 600.ms,
    );
    _outerAnimations = AnimationController(
      vsync: this,
      duration: 1500.ms,
    );
    _otpFocusNode = FocusNode();
    _otpFocusNode.addListener(() {
      setState(() {});
    });
    _otpController = TextEditingController();
    _innerAnimations.forward();
    _outerAnimations.forward();
  }

  @override
  Widget build(BuildContext context) {
    // try {} catch (e) {
    //   _innerAnimations.reset();
    //   _outerAnimations.reset();
    //   initialiseStuff();
    // }

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: PKTheme.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          color: PKTheme.primaryColor.withOpacity(0.42),
          border: Border.all(color: PKTheme.primaryColor, width: 2)),
    );

    void pushToHomePage() {
      Navigator.of(context)
          .pushAndRemoveUntil(
              RouteAnimations(
                      nextPage: const HomePage(),
                      animationDirection: AnimationDirection.RTL)
                  .createRoute(),
              (route) => false)
          .then((value) {
        _innerAnimations.reset();
        _outerAnimations.reset();
        initialiseStuff();
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<VerifyBloc, VerifyState>(
        bloc: _verifyBloc,
        listenWhen: (previous, current) => current is VerifyActionState,
        buildWhen: (previous, current) => current is! VerifyActionState,
        listener: (context, state) async {
          if (state is VerifyBackActionState) {
            Navigator.of(context).pop();
          } else if (state is VerifyCodeSentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 1),
              ),
            );
            Navigator.of(context).pop();
          } else if (state is VerifyFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: const Duration(seconds: 1),
              ),
            );
            await Future.delayed(const Duration(seconds: 1));
            _otpController.clear();
            _verifyBloc.add(VerifyFailureHandlerEvent(phone: widget.phone));
          } else if (state is VerifySuccess) {
            //DONE: Get User Id from the API response and add that to the user model
            _userBloc.add(
              UserLoginEvent(
                user: UserModel.fromLogin(
                  state.phone,
                  state.token,
                  state.uid,
                ),
              ),
            );
            _innerAnimations.reverse();
            await _outerAnimations.reverse();
            pushToHomePage();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case VerifyCodeSending:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: PKTheme.primaryColor,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Sending OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            case VerifyCodeSentSuccess:
              final String phone = (state as VerifyCodeSentSuccess).phone;
              final String rid = (state).rid;
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Patil Kaki welcomes you!',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            )
                                .animate(controller: _innerAnimations)
                                .fade(
                                  delay: 0.ms,
                                  duration: 400.ms,
                                  begin: 0.0,
                                  end: 1.0,
                                  curve: Curves.easeInOut,
                                )
                                .slideY(
                                  curve: Curves.easeInOut,
                                  duration: 400.ms,
                                  delay: 0.ms,
                                  begin: -0.1,
                                  end: 0.0,
                                ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Enter your Code',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.start,
                                  )
                                      .animate(controller: _innerAnimations)
                                      .fade(
                                        delay: 250.ms,
                                        duration: 400.ms,
                                        begin: 0.0,
                                        end: 1.0,
                                        curve: Curves.easeInOut,
                                      )
                                      .slideY(
                                        curve: Curves.easeInOut,
                                        duration: 400.ms,
                                        delay: 250.ms,
                                        begin: -0.1,
                                        end: 0.0,
                                      ),
                                  const SizedBox(height: 10.0),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Enter the 4 digit code sent to ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.grey,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: '+91*****${phone.substring(5)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  )
                                      .animate(controller: _innerAnimations)
                                      .fade(
                                        delay: 500.ms,
                                        duration: 400.ms,
                                        begin: 0.0,
                                        end: 1.0,
                                        curve: Curves.easeInOut,
                                      )
                                      .slideY(
                                        curve: Curves.easeInOut,
                                        duration: 400.ms,
                                        delay: 500.ms,
                                        begin: -0.1,
                                        end: 0.0,
                                      ),
                                  const SizedBox(height: 20.0),
                                  Form(
                                    key: _formKey,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Pinput(
                                        androidSmsAutofillMethod:
                                            AndroidSmsAutofillMethod
                                                .smsUserConsentApi,
                                        defaultPinTheme: defaultPinTheme,
                                        focusedPinTheme: focusedPinTheme,
                                        submittedPinTheme: submittedPinTheme,
                                        controller: _otpController,
                                        focusNode: _otpFocusNode,
                                        keyboardAppearance: Brightness.light,
                                        validator: (pin) {
                                          if (pin == null || pin.isEmpty) {
                                            return 'Please enter the code';
                                          }
                                          if (pin.length < 4) {
                                            return 'Please enter the complete pin';
                                          }
                                          return null;
                                        },
                                      )
                                          .animate(controller: _innerAnimations)
                                          .fade(
                                            delay: 750.ms,
                                            duration: 400.ms,
                                            begin: 0.0,
                                            end: 1.0,
                                            curve: Curves.easeInOut,
                                          )
                                          .slideY(
                                            curve: Curves.easeInOut,
                                            duration: 400.ms,
                                            delay: 750.ms,
                                            begin: -0.1,
                                            end: 0.0,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 40.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _verifyBloc.add(
                                          VerifyCodeEvent(
                                            phone: phone,
                                            code: _otpController.text,
                                            rid: rid,
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          const Size(double.infinity, 50.0),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 10.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                      .animate(controller: _innerAnimations)
                                      .fade(
                                        delay: 1000.ms,
                                        duration: 400.ms,
                                        begin: 0.0,
                                        end: 1.0,
                                        curve: Curves.easeInOut,
                                      )
                                      .slideY(
                                        curve: Curves.easeInOut,
                                        duration: 400.ms,
                                        delay: 750.ms,
                                        begin: -0.1,
                                        end: 0.0,
                                      ),
                                  const SizedBox(height: 20.0),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Resend Code',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  )
                                      .animate(controller: _innerAnimations)
                                      .fade(
                                        delay: 1250.ms,
                                        duration: 400.ms,
                                        begin: 0.0,
                                        end: 1.0,
                                        curve: Curves.easeInOut,
                                      )
                                      .slideY(
                                        curve: Curves.easeInOut,
                                        duration: 400.ms,
                                        delay: 1000.ms,
                                        begin: -0.1,
                                        end: 0.0,
                                      ),
                                  const SizedBox(height: 100.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/bottom-left-under.png')
                                .animate(controller: _outerAnimations)
                                .fade(
                                  delay: 100.ms,
                                  duration: 600.ms,
                                  begin: 0.0,
                                  end: 1.0,
                                  curve: Curves.easeInOut,
                                )
                            // .slide(
                            //   curve: Curves.elasticOut,
                            //   duration: 1500.ms,
                            //   delay: 250.ms,
                            //   begin: const Offset(-0.2, 0.2),
                            //   end: const Offset(0.0, 0.0),
                            // ),
                            ,
                            Positioned(
                              bottom: 0,
                              child: Image.asset(
                                      'assets/images/bottom-left-over.png')
                                  .animate(controller: _outerAnimations)
                                  .fade(
                                    delay: 0.ms,
                                    duration: 400.ms,
                                    begin: 0.0,
                                    end: 1.0,
                                    curve: Curves.easeInOut,
                                  )
                                  .slide(
                                    curve: Curves.elasticOut,
                                    duration: 1500.ms,
                                    delay: 100.ms,
                                    begin: const Offset(-0.2, 0.2),
                                    end: const Offset(0.0, 0.0),
                                  ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/top-right-under.png')
                                .animate(controller: _outerAnimations)
                                .fade(
                                  delay: 100.ms,
                                  duration: 600.ms,
                                  begin: 0.0,
                                  end: 1.0,
                                  curve: Curves.easeInOut,
                                )
                            // .slide(
                            //   curve: Curves.elasticOut,
                            //   duration: 1500.ms,
                            //   delay: 250.ms,
                            //   begin: const Offset(0.1, -0.1),
                            //   end: const Offset(0.0, 0.0),
                            // ),
                            ,
                            Positioned(
                              right: 0,
                              child: Image.asset(
                                      'assets/images/top-right-over.png')
                                  .animate(controller: _outerAnimations)
                                  .fade(
                                    delay: 0.ms,
                                    duration: 400.ms,
                                    begin: 0.0,
                                    end: 1.0,
                                    curve: Curves.easeInOut,
                                  )
                                  .slide(
                                    curve: Curves.elasticOut,
                                    duration: 1500.ms,
                                    delay: 100.ms,
                                    begin: const Offset(0.1, -0.1),
                                    end: const Offset(0.0, 0.0),
                                  ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case VerifyLoading:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: PKTheme.primaryColor,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Verifying OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const Center(
                //[ ]:Change this in prod.
                child: Text('Something went wrong! couldnt catch'),
              );
          }
        },
      ),
    );
  }
}
