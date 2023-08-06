import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';
import 'package:pk_customer_app/screens/welcome/ui/welcome_page.dart';

//TODO: Figure a way to make the Bottom Navbar stay after the home page animation. pages change in the above portion of the code but the navbar stays the same.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const AppRoot());
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()..add(UserInitEvent())),
        BlocProvider(create: (_) => CartBloc()..add(CartInitEvent())),
      ],
      child: MaterialApp(
        theme: PKTheme.themeData,
        debugShowCheckedModeBanner: false,
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserAuthState) {
                if (state.user == null) {
                  return const WelcomePage();
                }
                return const HomePage();
              }
              return const WelcomePage();
            },
          ),
        ),
      ),
    );
  }
}
