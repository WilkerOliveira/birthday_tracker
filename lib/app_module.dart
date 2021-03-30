import 'package:birthday_tracker/business/home/home_business.dart';
import 'package:birthday_tracker/controllers/home/home_controller.dart';
import 'package:birthday_tracker/controllers/login/login_controller.dart';
import 'package:birthday_tracker/repository/home/home_repository.dart';
import 'package:birthday_tracker/service/notifications/CalendarNotification.dart';
import 'package:birthday_tracker/ui/screens/home/home_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'business/login/login_business.dart';
import 'repository/login/login_repository.dart';
import 'ui/screens/login/login_screen.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginRepository()),
        Bind((i) => LoginBusiness(i.get<LoginRepository>())),
        Bind((i) => LoginController(i.get<LoginBusiness>())),
        Bind((i) => HomeRepository()),
        Bind((i) => CalendarNotification()),
        Bind(
          (i) => HomeBusiness(
            i.get<HomeRepository>(),
            i.get<CalendarNotification>(),
          ),
        ),
        Bind((i) => HomeController(i.get<HomeBusiness>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => LoginScreen()),
        ChildRoute('/home', child: (_, __) => HomeScreen()),
      ];
}
