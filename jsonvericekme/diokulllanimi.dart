import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jsonvericekme/photomodel.dart';

class Diokulllanimi extends StatelessWidget {
  const Diokulllanimi({super.key});

  Future<List<Photo>> _getphotos() async {
    try {
      final dio = Dio();
      var url = "https://jsonplaceholder.typicode.com/photos";
      var response = await dio.get(
        url,
        options: Options(headers: {"Accept": "application/json"}),
      );
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Photo> photolist = data
            .map((element) => Photo.fromJson(element))
            .toList();
        return photolist;
      } else {
        return [];
      }
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getphotos();
    return Scaffold(
      body: FutureBuilder(
        future: _getphotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var photoList = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                var oankieleman = photoList[index];
                return ExpansionTile(
                  title: Text(oankieleman.title),
                  leading: CircleAvatar(
                    child: Text(oankieleman.albumId.toString()),
                  ),
                  children: [Image.network(oankieleman.url)],
                );
              },
              itemCount: photoList.length,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
