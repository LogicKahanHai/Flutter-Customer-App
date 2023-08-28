import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/reusable/common_components.dart';
import 'package:pk_customer_app/screens/home/bloc/home_bloc.dart';
import 'package:pk_customer_app/screens/home/ui/components/home_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final HomeBloc _homeBloc = HomeBloc();
  void initialiseStuff() {
    _homeBloc.add(HomeInitialEvent());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void refresh() {
    setState(() {
      isUpdating = !isUpdating;
    });
  }

  @override
  void initState() {
    initialiseStuff();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) {
        return current is HomeActionState;
      },
      listener: (context, state) {
        if (state is HomeAddToCartSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to cart'),
              backgroundColor: PKTheme.primaryColor,
              duration: Duration(milliseconds: 500),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoading:
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: PKTheme.primaryColor,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Tasty Home made food is just a click away...',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case HomeLoadedFailure:
            final failureState = state as HomeLoadedFailure;
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (failureState.type == HomeLoadedFailureType.other)
                        const Icon(
                          Icons.error_outline,
                          color: PKTheme.primaryColor,
                          size: 80,
                        )
                      else
                        const Icon(
                          Icons.location_off,
                          color: PKTheme.primaryColor,
                          size: 80,
                        ),
                      const SizedBox(height: 20),
                      if (failureState.type == HomeLoadedFailureType.other)
                        const Text(
                          'Aw Snap!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'We need that ',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(
                                text: 'Location Permission',
                                style: TextStyle(
                                  color: PKTheme.primaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' to serve you better.',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                      Text(
                        failureState.type == HomeLoadedFailureType.locDenied
                            ? 'Location permission denied'
                            : failureState.type ==
                                    HomeLoadedFailureType.locDeniedForever
                                ? 'Please enable Location Permission from Settings'
                                : 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          _animationController.reset();
                          if (failureState.type ==
                              HomeLoadedFailureType.locDeniedForever) {
                            final settingsOpened = await openAppSettings();
                            if (settingsOpened) {
                              _homeBloc.add(HomeInitialEvent());
                            }
                          } else {
                            _homeBloc.add(HomeInitialEvent());
                          }
                        },
                        child: Text(
                          failureState.type ==
                                  HomeLoadedFailureType.locDeniedForever
                              ? 'Open Settings'
                              : 'Retry',
                          style: const TextStyle(
                            color: PKTheme.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case HomeLoadedSuccess:
            final successState = state as HomeLoadedSuccess;
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocProvider(
                    create: (context) => HomeBloc(),
                    child: Column(
                      children: [
                        AddressContainer(
                          shouldRefresh: isUpdating,
                          tempAddress: successState.address,
                        )
                            .animate(controller: _animationController)
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
                        const SizedBox(height: 20),
                        const HomeSearchComponent()
                            .animate(controller: _animationController)
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
                        const HomeOffersCarousel()
                            .animate(controller: _animationController)
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
                        const SizedBox(height: 20),
                        const HomeCategoryList()
                            .animate(controller: _animationController)
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
                        const SizedBox(height: 20),
                        HomeFavProducts(refresh: refresh)
                            .animate(controller: _animationController)
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
                        const SizedBox(height: 20),
                        const HomeAbout()
                            .animate(controller: _animationController)
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
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: bottomNavBar(
                      currentIndex: 0, context: context, currentPage: 'home')
                  .animate(controller: _animationController)
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
                    begin: 0.1,
                    end: 0.0,
                  ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
