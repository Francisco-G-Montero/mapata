import 'dart:io';

import '../../data/util/NetResult.dart';

abstract class ImageStorageRepository{
  Future<DataResult<String>> uploadPostImage(File postImage);
}