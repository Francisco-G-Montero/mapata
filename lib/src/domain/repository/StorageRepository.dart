import '../../data/util/NetResult.dart';

abstract class StorageRepository {
  Future<DataResult<String>> uploadPostImage(String imagePath);
  Future<DataResult<void>> deletePostImage(String imagePath);
}