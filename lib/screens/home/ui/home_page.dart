import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/common/components/common_components.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/reusable/bottom_nav_bar.dart';
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
              body: const Center(
                child: CircularProgressIndicator(
                  color: PKTheme.primaryColor,
                  strokeWidth: 3,
                ),
              ),
            );
          case HomeLoadedSuccess:
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: BlocProvider(
                    create: (context) => HomeBloc(),
                    child: Column(
                      children: [
                        const AddressContainer()
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
                        const HomeFavProducts()
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
