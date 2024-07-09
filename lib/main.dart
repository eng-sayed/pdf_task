import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/general/general_cubit.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

import 'core/Router/Router.dart';
import 'core/utils/Locator.dart';
import 'core/utils/responsive_framework_widget.dart';
import 'core/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // bloc observer
  Bloc.observer = MyBlocObserver();
  // dotenv.load();
  await setupLocator();
  // Utils.getToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => GeneralCubit(),
        child: BlocConsumer<GeneralCubit, GeneralState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          // listenWhen: (previous, current)=>cubit. ,
          builder: (context, state) {
            final cubit = GeneralCubit.get(context);
            return MaterialApp(
              title: 'Retm',
              themeAnimationDuration: const Duration(milliseconds: 700),
              themeAnimationCurve: Curves.easeInOutCubic,
              navigatorKey: Utils.navigatorKey(),
              debugShowCheckedModeBanner: false,
              builder: (_, child) {
                SystemChrome.setSystemUIOverlayStyle(
                  cubit.isLightMode
                      ? SystemUiOverlayStyle.dark
                      : SystemUiOverlayStyle.light,
                );
                return AppResponsiveWrapper(
                  child: child,
                );
              },
              onGenerateRoute: RouteGenerator.getRoute,
              // themeMode: cubit.isLightMode ? ThemeMode.light : ThemeMode.dark,
              // theme: cubit.isLightMode ? LightTheme.getTheme() : DarkTheme.getTheme(),
              themeMode: ThemeMode.light,
              theme: LightTheme.getTheme(),
              darkTheme: DarkTheme.getTheme(),
              initialRoute: Routes.TaskScreen,
            );
          },
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType} -- $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType} -- $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType} -- $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType} -- $error -- $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    print('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
