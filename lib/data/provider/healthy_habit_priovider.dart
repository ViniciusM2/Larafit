import 'package:larafit/data/model/healthy_habit_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider {
  final DbHelper helper = DbHelper();

  Future salvar(HealthyHabitModel habito) async {
    Database db = await helper.openDb();
    await db.execute(
        """INSERT INTO habitoSaudavel("idUser", "nomeHabito", "descricao") 
        VALUES ("${habito.autorhabitoINT}", 
        "${habito.nomehabito}", 
        "${habito.descricaoTEXT}")""");
    db.close();
  }

  Future<List<HealthyHabitModel>> lerTodos() async {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> habitosMap =
        await db.rawQuery('select * from habitoSaudavel');
    List<HealthyHabitModel> habitosList =
        habitosMap.map((map) => HealthyHabitModel.fromJson(map)).toList();
    db.close();
    return habitosList;
  }

  Future<HealthyHabitModel> lerPeloId(int id) async {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> habitosMap =
        await db.rawQuery('SELECT * FROM habitoSaudavel WHERE habitoSaudavel.idHabito = ${id}');
    List<HealthyHabitModel> habito =
        habitosMap.map((map) => HealthyHabitModel.fromJson(map)).toList();
    db.close();
    if (habito.length == 0)
      return null;
    else
      return habito[0];
  }

  Future deletarPeloId(int id) async {
    Database db = await helper.openDb();
    await db.rawDelete('DELETE FROM habitoSaudavel WHERE habitoSaudavel.idHabito = ${id}');
    db.close();
  }

  Future deletarTodos() async {
    Database db = await helper.openDb();
    await db.rawDelete('DELETE FROM habitoSaudavel');
    db.close();
  }

  Future alterarPeloId(int id, HealthyHabitModel habitoNovo) async {
    Database db = await helper.openDb();
    await db.rawUpdate("""
        UPDATE habitoSaudavel SET nomeHabito = "${habitoNovo.nomehabito}", 
        idUser = "${habitoNovo.autorhabitoINT}",
        descricao = "${habitoNovo.descricaoTEXT}", 
        """);
    db.close();
  }
}
