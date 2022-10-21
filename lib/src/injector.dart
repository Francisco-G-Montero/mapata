import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mapata/src/data/datasource/remote/MarkersDatabase.dart';
import 'package:mapata/src/data/datasource/remote/PostDatabase.dart';
import 'package:mapata/src/data/datasource/remote/PostStorage.dart';
import 'package:mapata/src/data/datasource/services/GeolocationService.dart';
import 'package:mapata/src/data/datasource/services/StorageService.dart';
import 'package:mapata/src/data/repository/StorageRepositoryImpl.dart';
import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';
import 'package:mapata/src/domain/repository/StorageRepository.dart';
import 'package:mapata/src/domain/repository/PostRepository.dart';
import 'package:mapata/src/domain/usecases/remote/CreatePostUseCase.dart';
import 'package:mapata/src/domain/usecases/remote/EditPostUseCase.dart';
import 'package:mapata/src/domain/usecases/remote/GetAnimalMarkersUseCase.dart';
import 'package:mapata/src/domain/usecases/remote/GetPostUseCase.dart';
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
  injector.registerSingleton<GeolocationService>(GeolocationService());
  injector.registerSingleton<StorageService>(StorageService());
  //Backend Access
  injector.registerSingleton<MarkersDatabase>(MarkersDatabase(injector()));
  injector.registerSingleton<PostsDatabase>(PostsDatabase(injector()));
  injector.registerSingleton<PostStorage>(PostStorage(injector()));
  //repoimpl
  injector.registerSingleton<AnimalMarkersRepository>(AnimalMarkersRepositoryImpl(injector()));
  injector.registerSingleton<PostRepository>(PostRepositoryImpl(injector()));
  injector.registerSingleton<StorageRepository>(StorageRepositoryImpl(injector()));
  //usecases
  injector.registerSingleton<GetAnimalMarkersUseCase>(GetAnimalMarkersUseCase(injector()));
  injector.registerSingleton<CreatePostUseCase>(
      CreatePostUseCase(injector(), injector(), injector(), injector()));
  injector.registerSingleton<EditPostUseCase>(
      EditPostUseCase(injector(), injector()));
  injector.registerSingleton<GetPostUseCase>(
      GetPostUseCase(injector()));
  //blocs
  injector.registerFactory<HomeBloc>(() => HomeBloc(injector()));
  injector.registerFactory<CreatePostBloc>(() => CreatePostBloc(injector(), injector()));
  injector.registerFactory<PostBloc>(() => PostBloc(injector()));
}
