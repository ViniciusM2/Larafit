import 'package:larafit/data/model/goal_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

// class UserProvider {
//   final DbHelper helper = DbHelper();

//   Future salvar(GoalModel meta) async {
//     Database db = await helper.openDb();
//     await db.execute(
//         """INSERT INTO usuario() VALUES (${meta.}, 
//         ${usuario.bornDate}, 
//         ${usuario.sex}, 
//         ${usuario.weight}, 
//         ${usuario.height})""");
//     db.close();
//   }
  
//   Future<List<UserModel>> lerTodos() async {
//     Database db = await helper.openDb();
//     List<Map<String, dynamic>> usuariosMap =
//         await db.rawQuery('select * from usuario');
//     List<UserModel> usuariosList =
//         usuariosMap.map((map) => UserModel.fromJson(map)).toList();
//     db.close();
//     return usuariosList;
//   }

//   Future<UserModel> lerPeloId(int id) async {
//     Database db = await helper.openDb();
//     List<Map<String, dynamic>> usuarioMap =
//         await db.rawQuery('select * from usuario where usuario.IdUser = ${id}');
//     List<UserModel> usuario =
//         usuarioMap.map((map) => UserModel.fromJson(map)).toList();
//     db.close();
//     if (usuario.length == 0)
//       return null;
//     else
//       return usuario[0];
//   }

//   Future deletarPeloId(int id) async {
//     Database db = await helper.openDb();
//     await db.rawDelete('DELETE FROM usuario WHERE usuario.IdUser = ${id}');
//     db.close();
//   }

//   Future deletarTodos() async {
//     Database db = await helper.openDb();
//     await db.rawDelete('DELETE FROM usuario');
//     db.close();
//   }

//   Future alterarPeloId(int id, UserModel novoUsuario) async {
//     Database db = await helper.openDb();
//     await db.rawUpdate("""
//         UPDATE usuario SET NameUser = ${novoUsuario.nameUser}, 
//         BornDate = ${novoUsuario.bornDate},
//         Sex = ${novoUsuario.sex}, 
//         Weight = ${novoUsuario.weight}, 
//         Height = ${novoUsuario.height} WHERE usuario.IdUser = ${id}""");
//     db.close();
//   }
// }

class GoalProvider {
  Future<List<GoalModel>> getAllGoals() async {
    try {} catch (_) {}
  }

  Future<GoalModel> getGoalById() async{
    try {} catch (_) {}
  }

  Future<GoalModel> deleteGoalById() {
    try {} catch (_) {}
  }

  Future<GoalModel> updateGoalById() {
    try {} catch (_) {}
  }

  Future<int> countGoals() {
    return Future.delayed(Duration(milliseconds: 500)).then((value) => 9);
  }

  Future<int> countSuccessfulGoals() {
    return Future.delayed(Duration(milliseconds: 500)).then((value) => 8);
  }
}
