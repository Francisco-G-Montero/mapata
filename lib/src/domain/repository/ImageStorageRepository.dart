import 'dart:html';

import '../../data/util/NetResult.dart';

abstract class ImageStorageRepository{
  Future<DataResult<String>> uploadPostImage(ImageBitmap postImage);
}