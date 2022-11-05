import '../../../../core/services/base/base_services.dart';

class AudioService extends BaseServices {
  //Get Object Point Service
  Future<dynamic> getAudioPerRuangan(String name) async {
    var response = await request(
      "${api.getAudioRuangan}/$name",
      RequestType.GET,
      useJsonContent: true,
    );

    // if (response != null && response.containsKey('type')) {
    //   return MarkerModel.fromJson(response);
    // }
    return response;
  }
}
