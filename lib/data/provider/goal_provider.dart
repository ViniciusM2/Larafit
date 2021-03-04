import 'package:larafit/data/model/goal_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class GoalProvider {
   Database db  = DbHelper().db;

  Future<void> addGoal(GoalModel goal) async {
    try {
      await db.execute(
          """INSERT INTO meta
          ( 
            startDate,
            finalDate,
            state,
            url,
            description
            ) 
            VALUES 
      ( 
        "${goal.startDate}", 
        "${goal.finalDate}",
        0,
        "${goal.url}",
        "${goal.description}"
        )
        """,);
     
    } catch (e) {
      print('ERRO AO CADASTRAR META $e');
    }
  }

  Future<List<GoalModel>> getAllGoals() async {
    try {
      List<Map<String, dynamic>> goalsMap =
          await db.rawQuery('select * from meta');
          print(goalsMap);
      List<GoalModel> goalsList =
          goalsMap.map((map) => GoalModel.fromJson(map)).toList();
      
      return goalsList;
    } catch (e) {
      print('ERRO AO PEDIR TODAS AS METAS $e.');
      return [];
    }
  }

  Future<GoalModel> getGoalById(int id) async {
    try {
      List<Map<String, dynamic>> goalsMap =
          await db.rawQuery('SELECT * FROM meta WHERE meta.idMeta = ${id}');
      List<GoalModel> goalsList =
          goalsMap.map((map) => GoalModel.fromJson(map)).toList();
     
      if (goalsList.length == 0)
        return null;
      else {
        GoalModel meta = goalsList[0];
        return meta;
      }
    } catch (e) {
      print('ERRO AO PEDIR UMA META $e');
      return null;
    }
  }

  Future<void> deleteGoalById(int id) async {
    try {
      await db.rawDelete('DELETE FROM meta WHERE meta.idMeta = ${id}');
     
    } catch (e) {
      print('ERRO AO DELETAR UMA META $e');
    }
  }

  Future<void> updateGoalById(GoalModel meta, int id) async {
    try {
    print('$meta e $id');
      await db.rawUpdate("""
        UPDATE meta SET  
        startDate = "${meta.startDate}",
        finalDate = "${meta.finalDate}",
        state = "${meta.state}",
        url = "${meta.url}",
        description = "${meta.description}"
        WHERE meta.idMeta = "${id}"
        """);
     
    } catch (e) {
      print('NÃO FOI POSSIVEL EDITAR A META. $e');
    }
  }

  Future<int> countGoals() async {
    try {
      int count =
          Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM meta'));
      return count;
    } catch (e) {
      print('ERRO AO PEDIR A CONTAGEM DE METAS $e');
      return null;
    }
  }

  Future<int> countSuccessfulGoals() async {
    try {
      int count = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM meta WHERE meta.state = 1'));
      return count;
    } catch (e) {
      print('ERRO AO PEDIR AS METAS CONCLUIDAS $e');
      return null;
    }
  }
}
