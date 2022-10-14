import 'dart:html';

import 'package:mapata/src/data/util/NetResult.dart';
import 'package:mapata/src/domain/repository/ImageStorageRepository.dart';

class ImageStorageRepositoryImpl implements ImageStorageRepository {

  ImageStorageRepositoryImpl();

  @override
  Future<DataResult<String>> uploadPostImage(ImageBitmap postImage) {
    return Future(() => DataResult.success("TODOOOOO"));
  }
}