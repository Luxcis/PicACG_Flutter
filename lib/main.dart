import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:picacg/features/home/home.dart';
import 'package:picacg/l10n/app_localizations.dart';
import 'package:picacg/providers/language_provider.dart';
import 'package:picacg/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const defaultColorTheme = Colors.blue;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'Template',
          theme: ThemeData(
            colorScheme:
                lightDynamic ??
                ColorScheme.fromSeed(
                  seedColor: defaultColorTheme,
                  brightness: Brightness.light,
                ),
          ),
          darkTheme: ThemeData(
            colorScheme:
                darkDynamic ??
                ColorScheme.fromSeed(
                  seedColor: defaultColorTheme,
                  brightness: Brightness.dark,
                ),
          ),
          themeMode: themeProvider.themeMode,
          locale: languageProvider.language.toLocale(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const HomePage(),
        );
      },
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final entry = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ],
    child: const MyApp(),
  );
  runApp(entry);
}
