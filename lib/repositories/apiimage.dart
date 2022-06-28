import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:social_app/model/imageApi.dart';

class Api {
  final String apikey = "5IFGi9p0CqcZxupJ1ZV9ZUAoXddSBuRGYMW2cjKEvv8";

  Future<GetApiAll?> getApiImage({required String query}) async {
    String Url =
        "https://api.unsplash.com/search/photos/?client_id=$apikey&page=2&query=$query";

    try {
      final dio = Dio();
      Response reponse = await dio.get(Url);
      if (reponse.statusCode == 200) {
        return GetApiAll.fromJson(reponse.data);
      } else {
        print("erros");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> dowlaodImage({required String url}) async {
    final dio = Dio();
    final response =
        await dio.get(url, options: Options(responseType: ResponseType.bytes));
    try {
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 80,
          name: "ImageDowload");
    } catch (e) {}
  }
}
