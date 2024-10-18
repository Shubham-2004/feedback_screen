import 'package:feedback/applink/go_router.dart';
import 'package:flutter/material.dart';
import 'applink/app_link_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppLinkHandler _appLinkHandler;

  @override
  void initState() {
    super.initState();
    _appLinkHandler = AppLinkHandler(router: appRouter);
    _appLinkHandler.initLinkHandling();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}
