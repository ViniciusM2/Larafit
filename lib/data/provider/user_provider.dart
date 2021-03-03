import 'package:larafit/data/model/user_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class UserProvider {
  final DbHelper helper = DbHelper();

  Future<UserModel> save(UserModel usuario) async {
    Database db = await helper.openDb();
    await db.execute(
        """INSERT INTO usuario(nome, datanasc, sexo, peso, altura, url) VALUES ("${usuario.nameUser}", 
        "${usuario.bornDate}", 
        "${usuario.sex}", 
        "${usuario.weight}", 
        "${usuario.height}",
        "${usuario.url}")""");
    db.close();
  }

  Future<List<UserModel>> getAllUsers() async {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> usuariosMap =
        await db.rawQuery('select * from usuario');
    List<UserModel> usuariosList =
        usuariosMap.map((map) => UserModel.fromJson(map)).toList();
    db.close();
    return usuariosList;
  }

  Future<UserModel> getUserById(int id) async {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> usuarioMap =
        await db.rawQuery('select * from usuario where usuario.IdUser = ${id}');
    List<UserModel> usuario =
        usuarioMap.map((map) => UserModel.fromJson(map)).toList();
    db.close();
    if (usuario.length == 0)
      return null;
    else
      return usuario[0];
  }

  Future<void> deleteUserById(int id) async {
    Database db = await helper.openDb();
    await db.rawDelete('DELETE FROM usuario WHERE usuario.IdUser = ${id}');
    db.close();
  }

  // Future deletarTodos() async {
  //   Database db = await helper.openDb();
  //   await db.rawDelete('DELETE FROM usuario');
  //   db.close();
  // }

  Future<void> updateUserById(int id, UserModel novoUsuario) async {
    Database db = await helper.openDb();
    await db.rawUpdate("""
        UPDATE usuario SET nome = "${novoUsuario.nameUser}", 
        datanasc = "${novoUsuario.bornDate}",
        sexo = "${novoUsuario.sex}", 
        peso = "${novoUsuario.weight}", 
        altura = "${novoUsuario.height},
        url = "${novoUsuario.url}" WHERE usuario.IdUser = ${id}""");
    db.close();
  }

  Future<UserModel> getUser() async {
    UserModel userModel =
        await Future.delayed(Duration(milliseconds: 500)).then(
      (value) => UserModel(
        bornDate: '13/03/2003',
        height: 1.74,
        nameUser: 'Vinícius de Carvalho',
        sex: 'M',
        weight: 50.0,
        age:16,
      ),
    );
    return userModel;
  }
}
