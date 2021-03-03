import 'package:larafit/data/model/atitude_model.dart';
import 'package:larafit/data/util/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class AtitudeProvider {
  final DbHelper helper = DbHelper();
  
  Future<void> addAtitude(AtitudeModel atitude) async {
    Database db = await helper.openDb();
    try{
    await db.execute(
      """INSERT INTO atitude(idMeta, nomeAtitude, atitudeDuration, url) VALUES 
      (${atitude.idMeta}, 
      ${atitude.atitudeName}, 
      ${atitude.atitudeDuration}, 
      ${atitude.url}
)""");
      db.close();}
    catch(_){
      print('ERRO AO CADASTRAR ATITUDE');
    }

  }

  Future<List<AtitudeModel>> getAllAtitudes() async {
    try {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> atitudesMap =
        await db.rawQuery('select * from atitude ');
    List<AtitudeModel> atitudesList =
        atitudesMap.map((map) => AtitudeModel.fromJson(map)).toList();
    db.close();
    return atitudesList;
    } catch (_) {
      print('ERRO AO PEDIR TODAS AS ATITUDES.');
      return null;}
  }
  
  Future<AtitudeModel> getAtitudeById(int id) async {
    try {
    Database db = await helper.openDb();
    List<Map<String, dynamic>> atitudesMap =
        await db.rawQuery('SELECT * FROM meta WHERE meta.idMeta = ${id}');
    List<AtitudeModel> atitudesList =
        atitudesMap.map((map) => AtitudeModel.fromJson(map)).toList();
    db.close();
    if (atitudesList.length == 0)
      return null;
    else{
      AtitudeModel meta = atitudesList[0];
      return meta;
      }
      } catch (_) {print('ERRO AO PEDIR UMA ATITUDE');
      return null;}
  }
 
  Future<void> deleteAtitudeById(int id) async {
    try {
      Database db = await helper.openDb();
      await db.rawDelete('DELETE FROM atitude WHERE atitude.idAtitude = ${id}');
      db.close();
    } catch (_) {
      print('ERRO AO DELETAR UMA ATITUDE');}
  }
   // CREATE TABLE atitude(
  //             idAtitude INTEGER PRIMARY KEY,
  //             idMeta INTEGER,
  //             nomeAtitude TEXT,
  //             atitudeDuration INTEGER, 
  //           FOREIGN KEY(idMeta) REFERENCES meta(idMeta),
  //           url TEXT
  //           )
  Future<void> updateAtitudeById(int id, AtitudeModel atitude) async {
    try {
      Database db = await helper.openDb();
        await db.rawUpdate("""
        UPDATE atitude SET idMeta = "${atitude.idMeta}", 
        nomeAtitude = "${atitude.atitudeName}",
        atitudeDuration = "${atitude.atitudeDuration}",
        url = "${atitude.url}" WHERE atitude.idAtitude = "${id}"
        """);
        db.close();
        } catch (_) {print('NÃO FOI POSSIVEL EDITAR A ATITUDE.');}
  }

  Future<int> countAtitudes() async{
    try {
      Database db = await helper.openDb();
      int count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM atitude'));
      return count;

    } catch (_) {print('ERRO AO PEDIR A CONTAGEM DE ATITUDES');
    return null;
    }
  }
}
