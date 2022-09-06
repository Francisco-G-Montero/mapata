import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';
import 'package:mapata/src/domain/usecases/remote/GetAnimalMarkersUseCase.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';

import 'data/datasource/remote/RealtimeDatabaseService.dart';
import 'data/repository/AnimalMarkersRepositoryImpl.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //dio retrofit
  injector.registerSingleton<Dio>(Dio());
  //services
  injector.registerSingleton<RealtimeDatabaseService>(RealtimeDatabaseService());
  //repoimpl
  injector.registerSingleton<AnimalMarkersRepository>(AnimalMarkersRepositoryImpl(injector()));
  //usecases
  injector.registerSingleton<GetAnimalMarkersUseCase>(GetAnimalMarkersUseCase(injector()));
  //blocs
  injector.registerFactory<HomeBloc>(() => HomeBloc(injector()));
}
