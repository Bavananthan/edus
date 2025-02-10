import 'package:get_it/get_it.dart';

import '../common/app.dart';
import '../common/app_color.dart';
import '../common/app_text.dart';
import '../common/validation.dart';
import 'customer_provider.dart';

GetIt locator = GetIt.instance;

final customerProvider = locator<CustomerProvider>();
final colors = locator<AppColor>();
final app = locator<App>();
final texts = locator<AppText>();
final validation = locator<Validation>();

void setup() {
  locator.registerLazySingleton<CustomerProvider>(
    () => CustomerProvider(),
  );

  locator.registerLazySingleton<AppColor>(
    () => AppColor(),
  );
  locator.registerLazySingleton<App>(
    () => App(),
  );
  locator.registerLazySingleton<AppText>(
    () => AppText(),
  );
  locator.registerLazySingleton<Validation>(
    () => Validation(),
  );
}
