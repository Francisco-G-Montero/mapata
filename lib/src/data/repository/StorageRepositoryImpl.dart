import 'dart:io';

import 'package:mapata/src/data/util/NetResult.dart';
import 'package:mapata/src/domain/repository/StorageRepository.dart';

import '../datasource/remote/PostStorage.dart';

class StorageRepositoryImpl implements StorageRepository {
  final PostStorage _postStorage;

  StorageRepositoryImpl(this._postStorage);

  @override
  Future<DataResult<String>> uploadPostImage(String file) {
    final File imageFile = File(file);
    return _postStorage.uploadPostImageById(imageFile);
  }
}