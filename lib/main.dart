import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
