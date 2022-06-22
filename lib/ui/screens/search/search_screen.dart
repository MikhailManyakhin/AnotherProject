import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vedita_learning_project/ui/screens/search/search_view_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NasaPhoto> nasaPhotos = context.select((SearchViewModel vm) => vm.nasaPhotosList);
    return Scaffold(
      appBar: AppBar(title: const Text('Nasa gallery'),),
      body: ListView.builder(
        itemBuilder: (context, index) {
        return Column(
          children:  [
            Image.network(nasaPhotos[index].link),
            Text(nasaPhotos[index].title),
          ],
        );
      }, itemCount: nasaPhotos.length,),
    );
  }
}
