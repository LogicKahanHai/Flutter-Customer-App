import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';

class CreateProfilePage extends StatefulWidget {
  final String phone;
  final String uid;
  final String token;
  const CreateProfilePage(
      {super.key, required this.phone, required this.uid, required this.token});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage>
    with TickerProviderStateMixin {
  final userBloc = UserBloc();

  late AnimationController _innerAnimations;
  late AnimationController _outerAnimations;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;

  final _formKey = GlobalKey<FormState>();

  void initialiseStuff() {
    userBloc.add(UserGetProfileEvent());
    _innerAnimations = AnimationController(
      vsync: this,
      duration: 600.ms,
    );
    _outerAnimations = AnimationController(
      vsync: this,
      duration: 1500.ms,
    );
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();

    _firstNameFocusNode.addListener(() {
      setState(() {});
    });

    _lastNameFocusNode.addListener(() {
      setState(() {});
    });

    _innerAnimations.forward();
    _outerAnimations.forward();
  }

  @override
  void dispose() {
    _innerAnimations.dispose();
    _outerAnimations.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initialiseStuff();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<UserBloc, UserState>(
        bloc: userBloc,
        listenWhen: (previous, current) =>
            current is UserProfileSuccessState ||
            current is UserProfileErrorState,
        buildWhen: (previous, current) =>
            current is UserLoadingState ||
            current is UserProfileDoesNotExistState,
        listener: (context, state) {
          if (state is UserProfileSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                RouteAnimations(
                        nextPage: const HomePage(),
                        animationDirection: AnimationDirection.RTL)
                    .createRoute(),
                (route) => false);
          } else if (state is UserProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Something went wrong!'),
                duration: 2.seconds,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case UserProfileDoesNotExistState:
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
                              'Create your Profile',
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
                                    'Enter your Details',
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
                                  const SizedBox(height: 20.0),
                                  Form(
                                    key: _formKey,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _firstNameController,
                                            focusNode: _firstNameFocusNode,
                                            keyboardType: TextInputType.name,
                                            keyboardAppearance: Brightness.dark,
                                            textInputAction:
                                                TextInputAction.next,
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
                                              label: const Text('First Name'),
                                              labelStyle: TextStyle(
                                                color:
                                                    _firstNameFocusNode.hasFocus
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      'First Name',
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your First Name';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20.0),
                                          TextFormField(
                                            controller: _lastNameController,
                                            focusNode: _lastNameFocusNode,
                                            keyboardType: TextInputType.name,
                                            keyboardAppearance: Brightness.dark,
                                            textInputAction:
                                                TextInputAction.done,
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
                                              label: const Text('Last Name'),
                                              labelStyle: TextStyle(
                                                color:
                                                    _lastNameFocusNode.hasFocus
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      'Last Name',
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
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter your Last Name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
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
                                        userBloc.add(UserUpdateProfileEvent(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                        ));
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
            case UserLoadingState:
              return const Center(child: CircularProgressIndicator());
            default:
              return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
