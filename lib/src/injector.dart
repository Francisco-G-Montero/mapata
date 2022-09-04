import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //dio retrofit
  injector.registerSingleton<Dio>(Dio());
  //blocs
  injector.registerFactory<HomeBloc>(() => HomeBloc());
}
