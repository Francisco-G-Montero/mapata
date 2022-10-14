import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mapata/src/data/datasource/remote/MarkersDatabase.dart';
import 'package:mapata/src/data/datasource/remote/PostDatabase.dart';
import 'package:mapata/src/domain/repository/AnimalMarkersRepository.dart';
import 'package:mapata/src/domain/repository/PostRepository.dart';
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
  //repoimpl
  injector.registerSingleton<AnimalMarkersRepository>(AnimalMarkersRepositoryImpl(injector()));
  injector.registerSingleton<PostRepository>(PostRepositoryImpl(injector()));
  //usecases
  injector.registerSingleton<GetAnimalMarkersUseCase>(GetAnimalMarkersUseCase(injector()));
  //blocs
  injector.registerFactory<HomeBloc>(() => HomeBloc(injector()));
  injector.registerFactory<CreatePostBloc>(() => CreatePostBloc());
  injector.registerFactory<PostBloc>(() => PostBloc());
}
