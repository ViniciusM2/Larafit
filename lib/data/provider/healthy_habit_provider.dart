import 'package:larafit/data/model/healthy_habit_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class HealthyHabitProvider {
  Database db = DbHelper().db;

  Future<void> addHabit(HealthyHabitModel habito) async {
    try {
      print("""INSERT INTO habitoSaudavel
            (
              idUser,
              nomeHabito,
              descricao,
              url
            ) 
            VALUES 
            (
              "${habito.autorhabitoINT ?? '1'}",
              "${habito.nomehabito}", 
              "${habito.descricaoTEXT}",
              "${habito.url}" 
            )
            """,);
      await db.execute("""
      INSERT INTO habitoSaudavel
            (
              idUser,
              nomeHabito,
              descricao,
              url
            ) 
            VALUES 
            (
              "${habito.autorhabitoINT ?? '1'}",
              "${habito.nomehabito}", 
              "${habito.descricaoTEXT}",
              "${habito.url}" 
            )
            """);
    } catch (e) {
      print(e);
      print('ERRO AO CADASTRAR HABITO');
    }
  }

  Future<List<HealthyHabitModel>> getAllHealthyHabits() async {
    try {
      List<Map<String, dynamic>> habitosMap =
          await db.rawQuery('select * from habitoSaudavel');
      // print('habitosMap: $habitosMap');
      List<HealthyHabitModel> habitosList =
          habitosMap.map((map) => HealthyHabitModel.fromJson(map)).toList();
      return habitosList;
    } catch (e) {
      print('ERRO AO PEDIR TODOS OS HABITOS: $e');
      return null;
    }
  }

  Future<HealthyHabitModel> getHealthyHabitById(int id) async {
    try {
      List<Map<String, dynamic>> habitosMap = await db.rawQuery(
          'SELECT * FROM habitoSaudavel WHERE habitoSaudavel.idHabito = ${id}');
      List<HealthyHabitModel> habito =
          habitosMap.map((map) => HealthyHabitModel.fromJson(map)).toList();

      if (habito.length == 0)
        return null;
      else {
        HealthyHabitModel habitoRetornado = habito[0];
        return habitoRetornado;
      }
    } catch (_) {
      print('ERRO AO PEDIR UM HABITO.');
      return null;
    }
  }

  Future<void> deleteHealthyHabitById(int id) async {
    try {
      await db.rawDelete(
          'DELETE FROM habitoSaudavel WHERE habitoSaudavel.idHabito = ${id}');
    } catch (_) {
      print('ERRO AO DELETAR UM USUÁRIO');
    }
  }

  Future<void> updateHealthyHabitById(
      HealthyHabitModel habitoNovo, int id) async {
    try {
      print(habitoNovo);
      await db.rawUpdate("""
        UPDATE habitoSaudavel SET nomeHabito = "${habitoNovo.nomehabito}", 
        idUser = "${habitoNovo.autorhabitoINT}",
        descricao = "${habitoNovo.descricaoTEXT}",
        url = "${habitoNovo.url}" WHERE habitoSaudavel.idHabito = "${id}"
        """);
    } catch (_) {
      print('NÃO FOI POSSIVEL EDITAR O HABITO.');
    }
  }
  // try {
  //     print(habitoNovo);
  //     await db.rawUpdate("""
  //       UPDATE habitoSaudavel SET nomeHabito = "${habitoNovo.nomehabito}", 
  //       idUser = "1",
  //       descricao = "${habitoNovo.descricaoTEXT}",
  //       url = "${habitoNovo.url}",  idHabito = "${id}" WHERE habitoSaudavel.idHabito = "${id}"
  //       """);
  //   } catch (_) {
  //     print('NÃO FOI POSSIVEL EDITAR O HABITO.');
  //   }

  Future<int> countHealthyHabits() async {
    try {
      int count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM habitoSaudavel'));
      return count;
    } catch (_) {
      print('ERRO AO PEDIR A CONTAGEM DE HABITOS');
      return null;
    }
  }
}
