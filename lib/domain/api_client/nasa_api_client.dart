import 'package:vedita_learning_project/domain/api_client/network_client.dart';
import 'package:vedita_learning_project/domain/entity/nasa_photos.dart';

class NasaApiClient {
  final NetworkClient _networkClient = NetworkClient();
  Future<NasaPhotos> searchNasaPhotoGallery(String searchName) {
    NasaPhotos parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = NasaPhotos.fromJson(jsonMap);
      print(response);
      return response;
    }
    final result = _networkClient
        .get('https://images-api.nasa.gov/search', parser, {'q': searchName});
    return result;
  }
}
