import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database db;
  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'larafit.db'),
          onCreate: (database, version) async {
        // await database.execute(
        //     'CREATE TABLE usuario(idUser INTEGER PRIMARY KEY, nome TEXT, datanasc TEXT, sexo TEXT, peso REAL, altura REAL)');
        await database.execute("""
          CREATE TABLE usuario(
            idUser INTEGER PRIMARY KEY,
            nome TEXT,
            datanasc TEXT,
            sexo TEXT,
            peso REAL,
            altura REAL,
            url TEXT
          )
        """);
        await database.execute("""
            CREATE TABLE habitoSaudavel(
              idHabito INTEGER PRIMARY KEY,
              idUser INTEGER,
              nomeHabito TEXT,
              descricao TEXT,
              FOREIGN KEY(idUser) REFERENCES usuario(idUser),
              url TEXT
            )
            """);
        // await database.execute(
        //     'CREATE TABLE habitoSaudavel(idHabito INTEGER PRIMARY KEY, nomeHabito TEXT, descricao TEXT, ' +
        //         'FOREIGN KEY(idUser) REFERENCES usuario(idUser) )');
        await database.execute("""
            CREATE TABLE meta(
              idMeta INTEGER PRIMARY KEY,
              idHabito INTEGER,
              startDate TEXT, 
              finalDate TEXT, 
              FOREIGN KEY(idHabito) REFERENCES habitoSaudavel(idHabito), 
              url TEXT,
              state INTEGER
	          )
            """);
        await database.execute("""
            CREATE TABLE atitude(
              idAtitude INTEGER PRIMARY KEY,
              idMeta INTEGER,
              nomeAtitude TEXT,
              atitudeDuration INTEGER, 
            FOREIGN KEY(idMeta) REFERENCES meta(idMeta),
            url TEXT
            )
            """);
        // await database.execute(
        //     'CREATE TABLE atitude(idAtitude INTEGER PRIMARY KEY, nomeAtitude TEXT, atitudeDuration INTEGER, startDate TEXT, ' +
        //         'FOREIGN KEY(idMeta) REFERENCES meta(idMeta))');
      }, version: version);
    }
    return db;
  }
}
