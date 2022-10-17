import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mapata/src/data/datasource/services/StorageService.dart';

import '../../util/NetResult.dart';

class PostStorage {
  final StorageService _storageService;

  PostStorage(this._storageService);

  Future<DataResult<String>> uploadPostImageById(File file) async {
    try {
      final uploadResult = await _storageService.getImagePostReference().putFile(file);
      if (uploadResult.state == TaskState.success) {
        return DataResult.success(uploadResult.ref.fullPath);
      } else {
        return DataResult.failure(GenericFailure());
      }
    } on FirebaseException catch (e) {
      return DataResult.failure(GenericFailure());
    }
  }
}
