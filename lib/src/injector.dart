import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mapata/src/data/datasource/remote/MarkersDatabase.dart';
import 'package:mapata/src/data/datasource/remote/PostDatabase.dart';
import 'package:mapata/src/data/datasource/services/GeolocationService.dart';
import 'package:mapata/src/data/repository/ImageStorageRepositoryImpl.dart';
import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';
import 'package:mapata/src/domain/repository/ImageStorageRepository.dart';
import 'package:mapata/src/domain/repository/PostRepository.dart';
import 'package:mapata/src/domain/usecases/remote/CreatePostUseCase.dart';
import 'package:mapata/src/domain/usecases/remote/GetAnimalMarkersUseCase.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/home/HomeBloc.dart';
import 'package:mapata/src/presentation/blocs/viewPost/PostBloc.dart';

import 'data/datasource/services/RealtimeDatabaseService.dart';
import 'data/repository/AnimalMarkersRepositoryImpl.dart';
import 'data/repository/PostRepositoryImpl.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //dio retrofit
  injector.registerSingleton<Dio>(Dio());
  //services
  injector.registerSingleton<RealtimeDatabaseService>(RealtimeDatabaseService());
  injector.registerSingleton<MarkersDatabase>(MarkersDatabase(injector()));
  injector.registerSingleton<PostsDatabase>(PostsDatabase(injector()));
  injector.registerSingleton<GeolocationService>(GeolocationService());
  //repoimpl
  injector.registerSingleton<AnimalMarkersRepository>(AnimalMarkersRepositoryImpl(injector()));
  injector.registerSingleton<PostRepository>(PostRepositoryImpl(injector()));
  injector.registerSingleton<ImageStorageRepository>(ImageStorageRepositoryImpl());
  //usecases
  injector.registerSingleton<GetAnimalMarkersUseCase>(GetAnimalMarkersUseCase(injector()));
  injector.registerSingleton<CreatePostUseCase>(
      CreatePostUseCase(injector(), injector(), injector(), injector()));
  //blocs
  injector.registerFactory<HomeBloc>(() => HomeBloc(injector()));
  injector.registerFactory<CreatePostBloc>(() => CreatePostBloc(injector()));
  injector.registerFactory<PostBloc>(() => PostBloc());
}
