part of 'service.dart';

class InformationService {
  static Future<List<InformationModel>> getInformationList() async {
    try {
      var response = await AppClient.instance().get(
        urlGalleryList,
      );
      return List<InformationModel>.from((response.data['data'] as List)
          .map((e) => InformationModel.fromJson(e))).toList();
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<InformationModel>> getInformationSearch(
      {required term}) async {
    try {
      var response = await AppClient.instance().get(
        urlGallerySearch(term),
      );
      return List<InformationModel>.from((response.data['data'] as List)
          .map((e) => InformationModel.fromJson(e))).toList();
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }
}
