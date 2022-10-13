import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';
import 'package:mapata/src/domain/usecases/remote/GetAnimalMarkersUseCase.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';
import 'package:mapata/src/presentation/blocs/viewPost/PostBloc.dart';

import 'data/datasource/remote/RealtimeDatabaseService.dart';
import 'data/repository/AnimalMarkersRepositoryImpl.dart';
import 'domain/usecases/remote/GetAnimalMarkersUseCase2.dart';

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
  injector.registerSingleton<GetAnimalMarkersUseCase2>(GetAnimalMarkersUseCase2(injector()));
  //blocs
  injector.registerFactory<HomeBloc>(() => HomeBloc(injector(),injector()));
  injector.registerFactory<CreatePostBloc>(() => CreatePostBloc());
  injector.registerFactory<PostBloc>(() => PostBloc());
}
