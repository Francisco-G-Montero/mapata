import '../../data/util/NetResult.dart';

abstract class StorageRepository {
  Future<DataResult<String>> uploadPostImage(String imagePath);
}