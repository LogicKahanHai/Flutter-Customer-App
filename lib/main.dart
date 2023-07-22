import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pk_customer_app/common/blocs/persistance/bloc/persist_bloc.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';
import 'package:pk_customer_app/screens/welcome/ui/welcome_page.dart';

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
  final PersistBloc _persistBloc = PersistBloc();

  @override
  void initState() {
    _persistBloc.add(PersistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersistBloc(),
      child: BlocBuilder<PersistBloc, PersistState>(
        bloc: _persistBloc,
        buildWhen: (previous, current) =>
            current is PersistStateEmpty || current is PersistStateHasData,
        builder: (context, state) {
          switch (state.runtimeType) {
            case PersistStateEmpty:
              return MaterialApp(
                theme: PKTheme.themeData,
                debugShowCheckedModeBanner: false,
                home: const AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  child: HomePage(),
                ),
              );
            case PersistStateHasData:
              return MaterialApp(
                theme: PKTheme.themeData,
                debugShowCheckedModeBanner: false,
                home: const AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  child: HomePage(),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

///[ ]: Product Model is not able to retrieve data from Map... Map<String, String> v/s Map<String, dynamic> ka locha hai
///[ ]: Jab product model sahi ho jaayega then cart se products ko update karna hai.. ig ho gaya hai just ye upar wala error rehta hai... 
///[ ]: Ya to User Data persist ho rahi hai ya phir cart... to iska jugaad lagana hai ab.