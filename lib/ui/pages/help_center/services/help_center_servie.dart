import '../../../../core/services/base/base_services.dart';
import '../models/help_center_model.dart';

class HelpCenterService extends BaseServices {
  Future<List<HelpCenterModel>>? getFaq() async {
    var response = await request(
      api.getFaq,
      RequestType.GET,
      useJsonContent: true,
    );
    List<HelpCenterModel> items = [];

    if (response != null && response.containsKey('data')) {
      final data = response['data'];
      if (data is List) {
        items = (response['data'] as List)
            .map((e) => HelpCenterModel.fromJson(e))
            .toList();
      }
    }
    return items;
  }
}
