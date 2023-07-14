import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/auth/login/ui/login_page.dart';
import 'package:pk_customer_app/screens/welcome/bloc/welcome_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  final WelcomeBloc _welcomeBloc = WelcomeBloc();
  late AnimationController _innerAnimations;
  late AnimationController _outerAnimations;

  //This function is only so that if the user clicks the back button, the page reloads properly.

  void initialiseStuff() {
    _welcomeBloc.add(WelcomeInitialEvent());
    _innerAnimations = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _outerAnimations = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void initState() {
    initialiseStuff();
    super.initState();
  }

  @override
  void dispose() {
    _innerAnimations.dispose();
    _outerAnimations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WelcomeBloc, WelcomeState>(
        bloc: _welcomeBloc,
        listenWhen: (previous, current) => current is WelcomeActionState,
        buildWhen: (previous, current) => current is! WelcomeActionState,
        listener: (context, state) {
          if (state is WelcomeLoginActionState) {
            Navigator.of(context)
                .push(
              RouteAnimations(
                      nextPage: const LoginPage(),
                      animationDirection: AnimationDirection.leftToRight)
                  .createRoute(),
            )
                .then((value) {
              _innerAnimations.reset();
              _outerAnimations.reset();
              initialiseStuff();
            });
          } else if (state is WelcomeRegisterActionState) {
            Navigator.of(context)
                .push(
              RouteAnimations(
                      nextPage: const LoginPage(),
                      animationDirection: AnimationDirection.leftToRight)
                  .createRoute(),
            )
                .then((value) {
              _innerAnimations.reset();
              _outerAnimations.reset();
              initialiseStuff();
            });
          } else if (state is WelcomeGuestActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Do guest'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WelcomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(
                  color: PKTheme.primaryColor,
                ),
              );
            case WelcomeLoadedState:
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                            Image.asset('assets/images/pk-logo-min.png')
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
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    _innerAnimations.reverse();
                                    await _outerAnimations.reverse();
                                    _welcomeBloc.add(WelcomeLoginEvent());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 52.0),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
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
                                const SizedBox(height: 20.0),
                                ElevatedButton(
                                  onPressed: () {
                                    _welcomeBloc.add(WelcomeRegisterEvent());
                                  },
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => const Color.fromRGBO(
                                                255, 107, 0, 0.42)),
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.transparent),
                                    foregroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => PKTheme.primaryColor),
                                    minimumSize: MaterialStateProperty
                                        .resolveWith((states) =>
                                            const Size(double.infinity, 52.0)),
                                    shape: MaterialStateProperty.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                          color: PKTheme.primaryColor,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    shadowColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.transparent),
                                  ),
                                  child: const Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
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
                                      delay: 250.ms,
                                      begin: -0.1,
                                      end: 0.0,
                                    ),
                              ]
                                  .animate(interval: 250.ms)
                                  .fade(
                                    duration: 400.ms,
                                    begin: 0.0,
                                    end: 1.0,
                                    curve: Curves.easeInOut,
                                  )
                                  .slideY(
                                    curve: Curves.easeInOut,
                                    duration: 400.ms,
                                    begin: -0.1,
                                    end: 0.0,
                                  ),
                            ).animate(controller: _innerAnimations),
                            TextButton(
                              onPressed: () {
                                _welcomeBloc.add(WelcomeGuestEvent());
                              },
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: const Text(
                                'Continue as a guest',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
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
                                .slide(
                                  curve: Curves.elasticOut,
                                  duration: 1500.ms,
                                  delay: 250.ms,
                                  begin: const Offset(-0.2, 0.2),
                                  end: const Offset(0.0, 0.0),
                                ),
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
                                .slide(
                                  curve: Curves.elasticOut,
                                  duration: 1500.ms,
                                  delay: 250.ms,
                                  begin: const Offset(0.1, -0.1),
                                  end: const Offset(0.0, 0.0),
                                ),
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
            default:
              return const Center(
                child: Text('Something went wrong!'),
              );
          }
        },
      ),
    );
  }
}
