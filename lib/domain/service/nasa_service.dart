import 'package:vedita_learning_project/domain/api_client/nasa_api_client.dart';
import 'package:vedita_learning_project/domain/entity/nasa_photos.dart';

class NasaService{
  final NasaApiClient _nasaApiClient = NasaApiClient();
  Future<NasaPhotos> searchNasaPhotos(String searchName) async{
    return await _nasaApiClient.searchNasaPhotoGallery(searchName);
  }
}