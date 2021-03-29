import 'package:B7/manager/global_manager.dart';
import 'package:B7/screen/home.dart';
import 'package:B7/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider.value(value: GlobalManager()..init()),
      ],
    ),
  );

  Utils.setAndroidOverlayStyle(Colors.transparent, Brightness.light);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '听青',
      home: HomePage(),
    );
  }
}
