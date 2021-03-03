import 'package:get/get.dart';
import 'package:larafit/data/model/user_model.dart';
import 'package:larafit/data/repository/dashboard_repository.dart';
import 'package:meta/meta.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;
  DashboardController({@required this.repository}) : assert(repository != null);

  Future<UserModel> getUser() async {
    return await repository.getUser();
  }

  final _nameOfUser = ''.obs;
  get nameOfUser => this._nameOfUser.value;
  set nameOfUser(value) => this._nameOfUser.value = value;

  final _weight = ''.obs;
  String get weight => this._weight.value;
  set weight(value) => this._weight.value = value;

  final _age = ''.obs;
  String get age => this._age.value;
  set age(value) => this._age.value = value;

  final _sex = ''.obs;
  String get sex => this._sex.value;
  set sex(value) => this._sex.value = value;

  final _height = ''.obs;
  String get height => this._height.value;
  set height(value) => this._height.value = value;

  final _imc = ''.obs;
  String get imc => this._imc.value;
  set imc(value) => this._imc.value = value;

  final _numberOfSuccessfulGoals = ''.obs;
  get numberOfSuccessfulGoals => this._numberOfSuccessfulGoals.value;
  set numberOfSuccessfulGoals(value) =>
      this._numberOfSuccessfulGoals.value = value;

  final _numberOfAtitudes = ''.obs;
  get numberOfAtitudes => this._numberOfAtitudes.value;
  set numberOfAtitudes(value) => this._numberOfAtitudes.value = value;

  onInit() async {
    // repository.getUser().then((user) => this.weight = '${user.weight}');
    var user = await repository.getUser();
    nameOfUser = '${user.nameUser}';
    weight = '${user.weight}';
    age = '${user.age}';
    sex = '${user.sex}';
    height = '${user.height}';
    imc = '${(user.weight / (user.height * user.height)).toStringAsFixed(2)}';
    var __numberOfSuccessfulGoals = await repository.countSuccessfulGoals();
    numberOfSuccessfulGoals = '$__numberOfSuccessfulGoals';
    var __numberOfAtitudes = await repository.countAtitudes();
    numberOfAtitudes = '$__numberOfAtitudes';

    super.onInit();
  }
}
