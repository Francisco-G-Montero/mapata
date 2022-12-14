import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mapata/src/injector.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/presentation/blocs/viewPost/PostBloc.dart';
import 'package:mapata/src/presentation/navigation/AppRoutes.dart';
import 'package:mapata/src/presentation/views/MainView.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'src/data/util/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signInAnonymously();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => injector()..add),
        BlocProvider<CreatePostBloc>(create: (context) => injector()..add),
        BlocProvider<PostBloc>(create: (context) => injector()..add),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppTitle,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          //Locale(kLANG_EN, ''), // English, no country code
          Locale(kLANG_ES, ''), // Spanish, no country code
        ],
        //onGenerateRoute: AppRoutes.onGenerateRoutes,
        //initialRoute: kRouteHome,
        home: MainView(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }
}
