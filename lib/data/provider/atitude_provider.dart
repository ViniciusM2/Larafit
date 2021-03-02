import 'package:larafit/data/model/atitude_model.dart';

class AtitudeProvider {
  Future<List<AtitudeModel>> getAllAtitudes() async {
    try {} catch (_) {}
  }

  Future<AtitudeModel> getAtitudeById() {
    try {} catch (_) {}
  }

  Future<AtitudeModel> deleteAtitudeById() {
    try {} catch (_) {}
  }

  Future<AtitudeModel> updateAtitudeById() {
    try {} catch (_) {}
  }

  Future<int> countAtitudes() {
    return Future.delayed(Duration(milliseconds: 500)).then((value) => 94);
  }
}
