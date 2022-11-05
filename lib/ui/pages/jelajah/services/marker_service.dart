import '../../../../core/services/base/base_services.dart';

class MarkerService extends BaseServices {
  //Get Object Point Service
  Future<dynamic> getObjectPoint(String floorId) async {
    var response = await request(
      "${api.getObjectPoint}?format=json&floor=$floorId",
      RequestType.GET,
      useJsonContent: true,
    );

    // if (response != null && response.containsKey('type')) {
    //   return MarkerModel.fromJson(response);
    // }
    return response;
  }
}
