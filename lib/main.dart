import 'package:flutter/material.dart';

import 'app.dart';
import 'core/config/constants/app.locator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocator().setupLocator();
  runApp(const App());
}
