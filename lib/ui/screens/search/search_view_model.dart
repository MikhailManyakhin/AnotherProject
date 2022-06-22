import 'package:flutter/foundation.dart';
import 'package:vedita_learning_project/domain/entity/nasa_photos.dart';
import 'package:vedita_learning_project/domain/service/nasa_service.dart';

class NasaPhoto {
  String title;
  String link;
  NasaPhoto({required this.title, required this.link});
}

class SearchViewModel extends ChangeNotifier {
  final NasaService _nasaService = NasaService();
  List<NasaPhoto> _nasaPhotosList = [];

  List<NasaPhoto> get nasaPhotosList => _nasaPhotosList;

  SearchViewModel() {
    _loadPhotos();
  }
  _loadPhotos() async {
    final allData = await _nasaService.searchNasaPhotos('moon');
    final filteredData = (allData.collection?.items ?? [])
        .where((item) => (item.data ?? []).first.mediaType == 'image')
        .toList();
    _nasaPhotosList = filteredData.map(_nasaToLocalPhotos).toList();
  }

  NasaPhoto _nasaToLocalPhotos(Item item) {
    return NasaPhoto(
        title: item.data?.first.title ?? '',
        link: item.links?.first.href ?? '');
  }
}
