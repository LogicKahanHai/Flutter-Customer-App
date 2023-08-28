import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/auth/login/bloc/login_bloc.dart';
import 'package:pk_customer_app/screens/auth/verify/ui/otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late TextEditingController _phoneController;
  late FocusNode _phoneFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _innerAnimations;
  late AnimationController _outerAnimations;
  final LoginBloc _loginBloc = LoginBloc();

  void initialiseStuff() {
    _loginBloc.add(LoginInitialEvent());
    _innerAnimations = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _outerAnimations = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _phoneFocusNode = FocusNode();
    _phoneFocusNode.addListener(() {
      setState(() {});
    });
    _phoneController = TextEditingController();
  }

  @override
  void initState() {
    initialiseStuff();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.removeListener(() {});
    _phoneFocusNode.dispose();
    _innerAnimations.dispose();
    _outerAnimations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listenWhen: (previous, current) => current is LoginActionState,
        buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is LoginOtpSentState) {
            Navigator.of(context)
                .push(
              RouteAnimations(
                      nextPage: OtpPage(
                        phone: state.phone,
                      ),
                      animationDirection: AnimationDirection.RTL)
                  .createRoute(),
            )
                .then((value) {
              _innerAnimations.reset();
              _outerAnimations.reset();
              initialiseStuff();
            });
          }
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'OTP could not be sent. Please try again.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: PKTheme.primaryColor,
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoginLoadingState:
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: PKTheme.primaryColor,
                  semanticsLabel: 'Loading Login Page',
                ),
              );
            case LoginLoadedState:
              return SingleChildScrollView(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: Image.asset(
                                            'assets/images/pk-logo-min.png')
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
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Enter your phone number',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                      const SizedBox(height: 20),
                                      const Text(
                                        'You will receive a 4 digit code for phone number verification',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
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
                                      const SizedBox(height: 40),
                                      Form(
                                        key: _formKey,
                                        child: TextFormField(
                                          controller: _phoneController,
                                          focusNode: _phoneFocusNode,
                                          keyboardType: TextInputType.phone,
                                          keyboardAppearance: Brightness.dark,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 2.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: PKTheme.primaryColor,
                                                width: 2.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            label: const Text('Phone Number'),
                                            labelStyle: TextStyle(
                                              color: _phoneFocusNode.hasFocus
                                                  ? PKTheme.primaryColor
                                                  : Colors.grey,
                                            ),
                                            prefixIcon: Container(
                                              height: 20.0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0,
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(width: 10.0),
                                                  Text(
                                                    '+91',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  VerticalDivider(
                                                    color: Colors.grey,
                                                    thickness: 1.0,
                                                    width: 1.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (value.length == 10) {
                                              _phoneFocusNode.unfocus();
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a phone number';
                                            }
                                            if (value.length < 10 ||
                                                value.length > 10 ||
                                                int.tryParse(value) == null) {
                                              return 'Please enter a valid phone number';
                                            }
                                            return null;
                                          },
                                        )
                                            .animate(
                                              controller: _innerAnimations,
                                            )
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
                                      const SizedBox(height: 40),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 52,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _innerAnimations.reverse();
                                              await _outerAnimations.reverse();
                                              _loginBloc.add(
                                                  LoginOtpContinueEvent(
                                                      phone: _phoneController
                                                          .text));
                                            }
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                          .animate(
                                            controller: _innerAnimations,
                                          )
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
                                            delay: 1000.ms,
                                            begin: -0.1,
                                            end: 0.0,
                                          ),
                                    ],
                                  ),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Continue as a Guest',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                        .animate(
                                          controller: _innerAnimations,
                                        )
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
                                          delay: 1250.ms,
                                          begin: -0.1,
                                          end: 0.0,
                                        ),
                                  ),
                                  const SizedBox(height: 60)
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Stack(
                              children: [
                                Image.asset(
                                        'assets/images/bottom-left-under.png')
                                    .animate(controller: _outerAnimations)
                                    .fade(
                                      delay: 0.ms,
                                      duration: 400.ms,
                                      begin: 0.0,
                                      end: 1.0,
                                      curve: Curves.easeInOut,
                                    )
                                // .slide(
                                //   curve: Curves.elasticOut,
                                //   duration: 1000.ms,
                                //   delay: 250.ms,
                                //   begin: const Offset(0.0, 0.0),
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
                                        begin: const Offset(-0.1, 0.1),
                                        end: const Offset(0.0, 0.0),
                                      ),
                                ),
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
                                      delay: 0.ms,
                                      duration: 400.ms,
                                      begin: 0.0,
                                      end: 1.0,
                                      curve: Curves.easeInOut,
                                    )
                                // .slide(
                                //   curve: Curves.elasticOut,
                                //   duration: 1000.ms,
                                //   delay: 250.ms,
                                //   begin: const Offset(0.0, 0.0),
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            default:
              return const Center(
                child: Text('Something went wrong'),
              );
          }
        },
      ),
    );
  }
}
