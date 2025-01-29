import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_pro/Themes/styles.dart';
import 'package:store_pro/l10n/l10n.dart';
import 'package:store_pro/product_store/views/login_view.dart';
import 'package:velocity_x/velocity_x.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return VxApp(
      store: MyStore(),
      builder: (context, vxData) => VxAdaptive(
        scaleType: VxAdaptiveScaleType.width,
        designWidth: Vx.isMobileOS ? context.screenWidth : 1000,
        builder: (context, scaled) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.robotoSlabTextTheme(),
            useMaterial3: true,
            brightness: vxData.isDarkMode ? Brightness.dark : Brightness.light,
            colorScheme:
                vxData.isDarkMode ? Styles.darkScheme() : Styles.lightScheme(),
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginView(),
        ),
      ),
    );
  }
}

class MyStore extends VxStore {}
