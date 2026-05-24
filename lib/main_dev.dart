import 'package:test1/core/config/app_config.dart';
import 'package:test1/core/config/environment.dart';

import 'main.dart';

void main()
{
  AppConfig.initialize(Environment.dev);
  startApp();
}