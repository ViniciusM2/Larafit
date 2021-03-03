import 'package:larafit/data/model/healthy_habit_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class HealthyHabitProvider {
  final DbHelper helper = DbHelper();

  Future<void> addHabit(HealthyHabitModel habito) async {
    Database db = await helper.openDb();
    try{
    await db.execute(
      """INSERT INTO meta(idUser, nomeHabito, descricao,url) VALUES (${habito.autorhabitoINT}, 
      ${habito.nomehabito}, 
      ${habito.descricaoTEXT},
      ${habito.url} )""");
      db.close();}
    catch(_){
      print('ERRO AO CADASTRAR HABITO');
    }

  }
  
  Future<List<HealthyHabitModel>> getAllHealthyHabits() async {
    try {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> habitosMap =
        await db.rawQuery('select * from habitoSaudavel');
    List<HealthyHabitModel> habitosList =
        habitosMap.map((map) => HealthyHabitModel.fromJson(map)).toList();
    db.close();
    return habitosList;
    } catch (_) {
      print('ERRO AO PEDIR TODOS OS HABITOS.');
      return null;}
  }

  Future<HealthyHabitModel> getHealthyHabitById(int id) async {
    try {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> habitosMap =
        await db.rawQuery('SELECT * FROM habitoSaudavel WHERE habitoSaudavel.idHabito = ${id}');
    List<HealthyHabitModel> habito =
        habitosMap.map((map) => HealthyHabitModel.fromJson(map)).toList();
    db.close();
    if (habito.length == 0)
      return null;
    else{
      HealthyHabitModel habitoRetornado = habito[0];
      return habitoRetornado;
      }
      } catch (_) {print('ERRO AO PEDIR UM HABITO.');
      return null;}
  }

  Future<void> deleteHealthyHabitById(int id) async {
    try {
      Database db = await helper.openDb();
      await db.rawDelete('DELETE FROM habitoSaudavel WHERE habitoSaudavel.idHabito = ${id}');
      db.close();
    } catch (_) {
      print('ERRO AO DELETAR UM USUÁRIO');}
  }

  Future<void> updateHealthyHabitById(HealthyHabitModel habitoNovo, int id) async {
    try {
      Database db = await helper.openDb();
        await db.rawUpdate("""
        UPDATE habitoSaudavel SET nomeHabito = "${habitoNovo.nomehabito}", 
        idUser = "${habitoNovo.autorhabitoINT}",
        descricao = "${habitoNovo.descricaoTEXT}",
        url = "${habitoNovo.url}" WHERE habitoSaudavel.IdHabito = ${id}
        """);
        db.close();
        } catch (_) {print('NÃO FOI POSSIVEL EDITAR O HABITO.');}
  }

  Future<int> countHealthyHabits() async{
    try {
      Database db = await helper.openDb();
      int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM habitoSaudavel'));
      return count;

    } catch (_) {print('ERRO AO PEDIR A CONTAGEM DE HABITOS');
    return null;}
  }
}
