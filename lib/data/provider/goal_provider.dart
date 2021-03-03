import 'package:larafit/data/model/goal_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';


class GoalProvider {
  final DbHelper helper = DbHelper();

  Future<void> addGoal(GoalModel goal) async {
    Database db = await helper.openDb();
    try{
    await db.execute(
      """INSERT INTO meta(idHabito, startDate, finalDate, state, url) VALUES 
      (${goal.idHabito},  
      ${goal.startDate}, 
      ${goal.startDate},
      0, ${goal.url})""");
      db.close();}
    catch(_){
      print('ERRO AO CADASTRAR META');
    }

  }
  Future<List<GoalModel>> getAllGoals() async {
    try {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> goalsMap =
        await db.rawQuery('select * from meta');
    List<GoalModel> goalsList =
        goalsMap.map((map) => GoalModel.fromJson(map)).toList();
    db.close();
    return goalsList;
    } catch (_) {
      print('ERRO AO PEDIR TODAS AS METAS.');
      return null;}
  }

  Future<GoalModel> getGoalById(int id) async{
    try {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> goalsMap =
        await db.rawQuery('SELECT * FROM meta WHERE meta.idMeta = ${id}');
    List<GoalModel> goalsList =
        goalsMap.map((map) => GoalModel.fromJson(map)).toList();
    db.close();
    if (goalsList.length == 0)
      return null;
    else{
      GoalModel meta = goalsList[0];
      return meta;
      }
      } catch (_) {print('ERRO AO PEDIR UMA META');
      return null;}
  }

  Future<void> deleteGoalById(int id) async  {
    try {
      Database db = await helper.openDb();
      await db.rawDelete('DELETE FROM meta WHERE meta.idMeta = ${id}');
      db.close();
    } catch (_) {
      print('ERRO AO DELETAR UMA META');}
  }


  Future<void> updateGoalById(GoalModel meta, int id) async{
    try {
      Database db = await helper.openDb();
        await db.rawUpdate("""
        UPDATE meta SET idHabito = "${meta.idHabito}", 
        startDate = "${meta.startDate}",
        finalDate = "${meta.finalDate}",
        state = "${meta.state}",
        url = "${meta.url}" WHERE meta.idMeta = "${id}"
        """);
        db.close();
        } catch (_) {print('NÃO FOI POSSIVEL EDITAR A META.');}
  }

  Future<int> countGoals() async{
   try {
      Database db = await helper.openDb();
      int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM meta'));
      return count;

    } catch (_) {print('ERRO AO PEDIR A CONTAGEM DE METAS');
    return null;
    }
  }

  Future<int> countSuccessfulGoals() async{
    try{
    Database db = await helper.openDb();
    int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM meta WHERE meta.state = 1'));
    return count;
    }
    catch(_){
      print('ERRO AO PEDIR AS METAS CONCLUIDAS');
      return null;}

  }
}
