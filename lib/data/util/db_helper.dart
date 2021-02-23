// import 'package:appihm/controller/services/bluetooth_service/service/deprecated_bluetooth_service.dart';
// import 'package:appihm/controller/services/serial_service/deprecated/another_deprecated_serial_service.dart';
// import 'package:appihm/controller/services/serial_service/serial_service.dart';
// import 'package:appihm/data/model/Imovel.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../../controller/services/bluetooth_service/service/bluetooth_service.dart';

// class DbHelper {
//   final int version = 2;
//   Database db;

//   static final DbHelper _dbHelper = DbHelper._internal();

//   DbHelper._internal();

//   factory DbHelper() {
//     return _dbHelper;
//   }

//   Future<void> showData() async {
//     List alarmes = await db.rawQuery('SELECT * FROM TB_ALARME');
//     alarmes.forEach((element) {
//       print('Alarme: $element');
//     });

//   }

//   Future<Database> openDb() async {
//     if (db == null) {
//       db = await openDatabase(
//         join(await getDatabasesPath(), 'DB_ENDPLORA.db'),
//         version: version,
//         onCreate: (db, version) async {
//           await db.execute(
//             '''
//           create table TB_TIPO_USUARIO
//           (
//             ID        integer primary key autoincrement
//                 constraint PK_TIPO_ALARME,
//             CODIGO    char(20) not null,
//             DESCRICAO text     not null
//           )
//           ''',
//           );
//           await db.execute('''
//           create unique index IN_TIPO_USUARIO_CODIGO
//           on TB_TIPO_USUARIO (CODIGO)
//           ''');
//           await db.execute('''
//               create table TB_USUARIO
//           (
//               ID         integer primary key autoincrement
//                   constraint PK_USUARIO,
//               MATRICULA char(10) not null,
//               NOME      char(50) not null,
//               EMAIL     char(30) not null,
//               SENHA     char(25) not null,
//               ID_TIPO_USUARIO integer
//                   constraint FK_USUARIO_TIPO_USUARIO
//                   references TB_TIPO_USUARIO (ID),
//               IS_EXCLUIDO  char (01) default ' ' not null
//                 check (IS_EXCLUIDO IN (' ', '*'))
//           )
//           ''');
//           await db.execute('''
//           create unique index IN_USUARIO_MATRICULA
//           on TB_USUARIO (MATRICULA)
//           ''');

//           await db.execute(
//             '''
//             create table TB_CONDOMINIO
//             (
//                 ID            integer primary key autoincrement
//                               constraint PK_CONDOMINIO,
//                 IDENTIFICACAO char(10) not null,
//                 DESCRICAO     char(45) not null
//             )
//             ''',
//           );
//           await db.execute('''
//             create unique index IN_CONDOMINIO_IDENTIFICACAO
//             on TB_CONDOMINIO(IDENTIFICACAO)
//           ''');
//           await db.execute(
//             '''
//             create table TB_CONCENTRADOR
//             (
//                 ID             integer primary key autoincrement
//                     constraint PK_CONCENTRADOR,
//                 IDENTIFICADOR  char(10),
//                 ID_CONDOMINIO  integer
//                     constraint FK_CONCENTRADOR_CONDOMINIO
//                     references TB_CONDOMINIO (ID)
//             )
//             ''',
//           );
//           await db.execute(
//             '''
//             create table TB_IMOVEL
//             (
//                 ID            integer primary key autoincrement
//                               constraint PK_IMOVEL,
//                 RGI           char(10) not null,
//                 DESCRICAO     char(45) not null,
//                 ID_CONDOMINIO integer
//                               constraint FK_IMOVEL_CONDOMINIO
//                               references TB_CONDOMINIO (ID),
//                 FORMAL_STATUS char(1) default 'N' not null,
//                 IS_EXCLUIDO   char (01) default ' ' not null
//                               check (IS_EXCLUIDO IN (' ', '*'))
//             )
//             ''',
//           );
//           await db.execute(
//               '''create unique index IN_IMOVEL_RGI on TB_IMOVEL (RGI)''');
//           await db.execute(
//             '''
//             create table TB_ENDPOINT
//             (
//                 ID              integer primary key autoincrement
//                                 constraint PK_ENDPOINT,
//                 IDENTIFICACAO   char(10) not null,
//                 ID_CONCENTRADOR integer
//                                 constraint FK_ENDPOINT_CONCENTRADOR
//                                 references TB_CONCENTRADOR (ID),
//                 ID_IMOVEL       integer
//                                 constraint FK_ENDPOINT_IMOVEL
//                                 references TB_IMOVEL (ID)
//             )
//             ''',
//           );
//           await db.execute('''
//           create unique index IN_ENDPOINT_IDENTIFICACAO
//           on TB_ENDPOINT (IDENTIFICACAO)
//           ''');
//           await db.execute(
//             '''
//             create table TB_HIDROMETRO
//             (
//                 ID              integer primary key autoincrement
//                                 constraint PK_HIDROMETRO,
//                 IDENTIFICACAO   char(9)  not null,
//                 ID_ENDPOINT     integer  not null
//                                 constraint FK_HIDROMETRO_ENDPOINT
//                                 references TB_ENDPOINT (ID),
//                 LEITURA_INICIAL decimal (10, 2),
//                 INTERVALO_PULSO decimal(8, 1),
//                 VALOR_BASE      decimal(3),
//                 CONSUMO_JAN     decimal(10, 2),
//                 CONSUMO_FEV     decimal(10, 2),
//                 CONSUMO_MAR     decimal(10, 2),
//                 CONSUMO_ABR     decimal(10, 2),
//                 CONSUMO_MAI     decimal(10, 2),
//                 CONSUMO_JUN     decimal(10, 2),
//                 CONSUMO_JUL     decimal(10, 2),
//                 CONSUMO_AGO     decimal(10, 2),
//                 CONSUMO_SET     decimal(10, 2),
//                 CONSUMO_OUT     decimal(10, 2),
//                 CONSUMO_NOV     decimal(10, 2),
//                 CONSUMO_DEZ     decimal(10, 2),
//                 ULTIMA_LEITURA  decimal(10, 2),
//                 DATA_HORA_ULTIMA_LEITURA datetime,
//                 IS_AGUA_QUENTE  char(01) default 'N' not null,
//                                          check (IS_AGUA_QUENTE IN ('S', 'N'))
//             )
//             ''',
//           );
//           await db.execute('''
//           create unique index IN_HIDROMETRO_IDENTIFICACAO
//           on TB_HIDROMETRO (IDENTIFICACAO)
//           ''');
//           await db.execute(
//             '''
//             create table TB_LEITURA
//             (
//                 ID                integer primary key autoincrement
//                     constraint PK_LEITURA,
//                 IDENTIFICACAO     integer not null,
//                 DATA_HORA_LEITURA datetime,
//                 VALOR_LEITURA     decimal(10, 2),
//                 ID_HIDROMETRO     integer not null
//                     constraint FK_LEITURA_HIDROMETRO
//                     references TB_HIDROMETRO (ID),
//                 ID_ENDPOINT      integer not null
//                     constraint FK_LEITURA_ENDPOINT
//                     references TB_ENDPOINT (ID)
//             )
//             ''',
//           );
//           // await db.execute(
//           //   '''
//           //   create table TB_LOG
//           //   (
//           //       ID            integer primary key autoincrement
//           //           constraint PK_LOG,
//           //       DESCRICAO     char(50) not null,
//           //       DATA_HORA     datetime,
//           //       ID_HIDROMETRO integer
//           //           references TB_HIDROMETRO (ID),
//           //       ID_USUARIO integer not null
//           //         references TB_USUARIO (ID)
//           //   )
//           //   ''',
//           // );
//           await db.execute(
//             '''
//             create table TB_TIPO_ALARME
//             (
//                 ID        integer primary key autoincrement
//                     constraint PK_TIPO_ALARME,
//                 CODIGO    char(2) not null,
//                 DESCRICAO text    not null
//             )
//             ''',
//           );
//           await db.execute('''
//           create unique index IN_TIPO_ALARME_CODIGO
//                 on TB_TIPO_ALARME (CODIGO)
//           ''');
//           await db.execute(
//             '''
//             create table TB_ALARME
//             (
//                 ID             integer primary key autoincrement
//                     constraint PK_ALARME,
//                 DESCRICAO       text not null,
//                 ID_TIPO_ALARME  integer not null
//                     constraint FK_ALARME_TIPO_ALARME
//                     references TB_TIPO_ALARME (ID),
//                 ID_HIDROMETRO   integer  not null
//                     constraint FK_ALARME_HIDROMETRO
//                     references TB_HIDROMETRO (ID),
//                 DATA_HORA       datetime
//             )
//             ''',
//           );
//           await db.execute(
//             '''
//             create table TB_VALVULA
//             (
//                 ID            integer primary key autoincrement
//                     constraint PK_VALVULA,
//                 STATUS        CHAR(03) default 'ON' not null,
//                 ID_HIDROMETRO integer
//                     constraint FK_VALVULA_HIDROMETRO
//                     references TB_HIDROMETRO (ID),
//                 check (STATUS IN ('ON', 'OFF'))
//             )
//             ''',
//           );
//           // TODO: IMPLEMENTAR LÓGICA DE USUÁRIO

//           await db.execute('''
//           create table TB_LOG
//           (
//               ID            integer primary key autoincrement
//                   constraint PK_LOG,
//               DESCRICAO_LOG     char(50) not null,
//               DATA_HORA     datetime,
//               ID_HIDROMETRO integer
//                   references TB_HIDROMETRO (ID),
//               ID_USUARIO integer not null
//     	            references TB_USUARIO (ID)
//           )
//           ''');

//           /////////////////////////////////////////////////////// INSERTS

//           await db.execute(
//             '''
//       insert into TB_CONDOMINIO (IDENTIFICACAO, DESCRICAO) values ("ZXCVB12345", "Alexandria")
//       ''',
//           );

//           // CRIAR CONCENTRADOR NO BANCO DE DADOS

//           await db.execute('''
//       insert into TB_CONCENTRADOR (IDENTIFICADOR, ID_CONDOMINIO) values ("0379628752", 1)
//       ''');

//           // CRIAR IMÓVEIS NO BANCO DE DADOS

//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("0634653823", "Casa n1", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("3031441608", "Casa n2", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("8557990921", "Casa n3", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("8676913723", "Casa n4", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("7002901415", "Casa n5", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("9658307067", "Casa n6", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("0897654309", "Casa n7", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("3887876385", "Casa n8", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("0063404212", "Casa n9", 1)
//     ''');
//           await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("4265312640", "Casa n10", 1)
//     ''');

//           // CRIAR ENDPOINTS NO BANCO DE DADOS
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("ZJW2ILZVVS", 1, 1)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO,	ID_CONCENTRADOR ,ID_IMOVEL) values ("3OQ2KML4BU", 1, 2)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("YSY7F8UPWO", 1, 3)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("D1RBGXLVP7", 1, 4)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("2DZZT5VFKC", 1, 5)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("PBAONROLEU", 1, 6)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("VWGNFMXPOO", 1, 7)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("P2WG2R30H5", 1, 8)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("KW1ZNRGGDW", 1, 9)
//     ''');
//           await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("XHUACOO6XV", 1, 10)
//     ''');

//           // CRIAR HIDROMETROS NO BANCO DE DADOS
//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("95BPJFQQM",1,0,25.3,300.0,1000.1,2000.2,3946.3,4523.4,57450.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-09-04")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA, IS_AGUA_QUENTE) values
//      ("95BPJAAAA",1,0,25.3,300.99,1000.19,2000.29,3946.39,4523.4,57450.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-09-04", "S")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("MYHOSOT1J",2,0,25.3,300.0,1000.1,2486.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,187.67,"2020-08-04")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("PFFIF3P15",3,0,25.3,300.0,1000.1,2000.2,3000.3,4456.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-07")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA, IS_AGUA_QUENTE) values
//      ("PFFIFAAAA",3,0,25.399,300.999,1000.1,2000.2,3000.39,4456.4,5000.5,6000.69,7000.79,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-07", "S")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("IN8KTNPA1",4,0,25.3,300.0,1000.1,2000.2,3000.3,4764.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,156.67,"2020-06-04")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("TB7Y0WF6K",5,0,25.3,300.0,1000.1,2345.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-05-05")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("Q0TS63SVN",6,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5000.5,6345.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,169.67,"2020-10-04")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("OH8OHZVDU",7,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-09")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("V23PUBVZ8",8,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5876.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,195.67,"2020-02-04")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("0WNGCQIWH",9,0,25.3,300.0,1000.1,2934.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-04")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA, IS_AGUA_QUENTE) values
//      ("0WNGCAAAA",9,0,258.399,300.999,1000.199,2934.2,3000.3,4000.499,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-04", "S")''');

//           await db.execute(
//               '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("XDUJOG8C3",10,0,25.3,300.0,1000.1,2000.2,3000.3,4786.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,137.67,"2020-05-04")''');

//           // CRIAR LEITURAS NO BANCO DE DADOS

//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (1, "2020-05-06", 345354.9, 1, 1)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (2, "2020-05-06", 75834.9, 2, 1)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (3, "2020-02-06", 364354.9, 3, 2)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (4, "2020-06-06", 3478554.9, 4, 3)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (5, "2020-06-06", 3477644.9, 5, 3)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (6, "2020-03-06", 345834.9, 6, 4)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (7, "2020-07-06", 361254.9, 7, 5)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (8, "2020-03-06", 763454.9, 8, 6)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (9, "2020-05-06", 345367.9, 9, 7)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (10, "2020-06-06", 345354.9, 10, 8)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (11, "2020-05-06", 382464.9, 11, 9)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (12, "2020-05-06", 372344.9, 12, 9)''');
//           await db.execute(
//               '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (13, "2020-01-06", 349464.9, 13, 10)''');

//           // CRIAR VALVULAS NO BANCO DE DADOS

//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",1)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",2)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",3)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",4)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",5)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",6)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",7)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",8)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",9)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",10)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",11)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",12)''');
//           await db.execute(
//               '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",13)''');

//           // CRIAR TIPOS DE ALARME NO BANCO DE DADOS

//           await db.execute(
//               'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("D6", "Chave de Acesso não confere")');
//           await db.execute(
//               'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("D8", "Violação de lacre lógico")');
//           await db.execute(
//               'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("F1", "Possível vazamento")');
//           await db.execute(
//               'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("G2", "Bateria fraca")');

//           // CRIAR ALARMES NO BANCO DE DADOS

//           await db.execute(
//               'INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Não confere", 1, 1, "2020-10-09 13:47:03")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Violação", 2, 2, "2020-10-07 15:34:01")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Possível vazamento", 3, 1, "2020-10-03 13:47:03")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Bateria fraca", 4, 2, "2020-10-01 14:27:01")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Não confere", 1, 1, "2020-10-09 17:29:03")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Violação", 2, 1, "2020-10-07 19:35:07")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Possível vazamento", 3, 1, "2020-10-03 21:24:53")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Bateria fraca", 4, 1, "2020-10-01 09:17:33")');
//           /////////////////////////////////////////////////////
//           await db.execute(
//               'INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Não confere", 1, 7, "2020-10-09 13:47:03")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Violação", 2, 7, "2020-10-07 15:34:01")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Possível vazamento", 3, 7, "2020-10-03 13:47:03")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Bateria fraca", 4, 5, "2020-10-01 14:27:01")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Não confere", 1, 9, "2020-10-09 17:29:03")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Violação", 2, 4, "2020-10-07 19:35:07")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Possível vazamento", 3, 6, "2020-10-03 21:24:53")');
//           await db.execute(
//               '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Bateria fraca", 4, 9, "2020-10-01 09:17:33")');
//           // CRIAR LOGS NO BANCO DE DADOS
// //           create table TB_LOG
// // -- (
// // --     ID            integer primary key autoincrement
// // --         constraint PK_LOG,
// // --     DESCRICAO     char(50) not null,
// // --     DATA_HORA     datetime,
// // --     ID_HIDROMETRO integer
// // --         references TB_HIDROMETRO (ID),
// // --     ID_USUARIO integer not null
// // --     	references TB_USUARIO (ID)
// // -- );
//           // TODO: IMPLEMENTAR LÓGICA DE USUÁRIO
//           await db.execute(
//               'INSERT INTO TB_LOG (DESCRICAO_LOG, DATA_HORA, ID_HIDROMETRO , ID_USUARIO) VALUES ("Log de Teste 1", "2020-10-07 19:35:07", 1, 1)');
//           await db.execute(
//               'INSERT INTO TB_LOG (DESCRICAO_LOG, DATA_HORA, ID_HIDROMETRO, ID_USUARIO) VALUES ("Log de Teste 2", "2020-12-05 19:35:07", 2, 1)');
//           await db.execute(
//               'INSERT INTO TB_LOG (DESCRICAO_LOG, DATA_HORA, ID_HIDROMETRO, ID_USUARIO) VALUES ("Log de Teste 3", "2020-11-07 19:35:07", 3, 1)');
//           await db.execute(
//               'INSERT INTO TB_LOG (DESCRICAO_LOG, DATA_HORA, ID_HIDROMETRO, ID_USUARIO) VALUES ("Log de Teste 5", "2020-05-09 19:35:07", 4, 1)');
//           // USUÁRIOS
//           await db.execute(
//               'INSERT INTO TB_TIPO_USUARIO (CODIGO, DESCRICAO) VALUES ("123","123")');
//           await db.execute(
//               'INSERT INTO TB_USUARIO (MATRICULA, NOME, EMAIL, SENHA, ID_TIPO_USUARIO) VALUES ("123","345","678","910",1)');
//         },
//       );
//     }
//     // try {
//     //   Get.find<SerialService>();
//     // } catch (e) {
//     //   Get.putAsync(
//     //     () => SerialService().init(),
//     //   );
//     // }
//     try {
//       Get.find<SerialService>();
//     } catch (e) {
//       Get.putAsync(
//         () => SerialService().init(),
//       );
//     }

//     return db;
//   }

//   Future<List<AutonomousUnitModel>> testGetAllAutonomousUnits() async {
//     final List<Map<String, dynamic>> maps = await db.query('TB_IMOVEL');
//     return maps.map((map) => AutonomousUnitModel.fromMap(map)).toList();
//   }

//   Future<void> testDb() async {
//     db = await openDb();
//     // CRIAR CONDOMINIO NO BANCO DE DADOS

//     //ValveProvider().turnOffValvesByRgi('0634653823');

//     // if (true) {
//     //   var teste = await AlarmProvider().getListOfAllAlarmDisplayModels();
//     //   print('TESTE 3: $teste');
//     // }

//     if (false) {
//       await db.execute(
//           'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("D6", "Chave de Acesso não confere")');
//       await db.execute(
//           'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("D8", "Violação de lacre lógico")');
//       await db.execute(
//           'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("F1", "Possível vazamento")');
//       await db.execute(
//           'INSERT INTO TB_TIPO_ALARME (CODIGO, DESCRICAO) VALUES ("G2", "Bateria fraca")');
//     }

//     if (false) {
//       await db.execute(
//           'INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Não confere", 1, 1, "2020-10-09 13:47:03")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Violação", 2, 2, "2020-10-07 15:34:01")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Possível vazamento", 3, 1, "2020-10-03 13:47:03")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Bateria fraca", 4, 2, "2020-10-01 14:27:01")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Não confere", 1, 1, "2020-10-09 17:29:03")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Violação", 2, 1, "2020-10-07 19:35:07")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Possível vazamento", 3, 1, "2020-10-03 21:24:53")');
//       await db.execute(
//           '	INSERT INTO TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) VALUES ("Bateria fraca", 4, 1, "2020-10-01 09:17:33")');
//     }

//     if (false) {
//       await db.execute(
//         '''
//       insert into TB_CONDOMINIO (IDENTIFICACAO, DESCRICAO) values ("ZXCVB12345", "Alexandria")
//       ''',
//       );

//       // CRIAR CONCENTRADOR NO BANCO DE DADOS

//       await db.execute('''
//       insert into TB_CONCENTRADOR (IDENTIFICADOR, ID_CONDOMINIO) values ("0379628752", 1)
//       ''');

//       // CRIAR IMÓVEIS NO BANCO DE DADOS

//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("0634653823", "Casa nº 1", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("3031441608", "Casa nº 2", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("8557990921", "Casa nº 3", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("8676913723", "Casa nº 4", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("7002901415", "Casa nº 5", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("9658307067", "Casa nº 6", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("0897654309", "Casa nº 7", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("3887876385", "Casa nº 8", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("0063404212", "Casa nº 9", 1)
//     ''');
//       await db.execute('''
//     insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values ("4265312640", "Casa nº 10", 1)
//     ''');

//       // CRIAR ENDPOINTS NO BANCO DE DADOS
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("ZJW2ILZVVS", 1, 1)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO,	ID_CONCENTRADOR ,ID_IMOVEL) values ("3OQ2KML4BU", 1, 2)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("YSY7F8UPWO", 1, 3)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("D1RBGXLVP7", 1, 4)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("2DZZT5VFKC", 1, 5)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("PBAONROLEU", 1, 6)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("VWGNFMXPOO", 1, 7)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("P2WG2R30H5", 1, 8)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("KW1ZNRGGDW", 1, 9)
//     ''');
//       await db.execute('''
//     insert into TB_ENDPOINT (IDENTIFICACAO, ID_CONCENTRADOR ,ID_IMOVEL) values ("XHUACOO6XV", 1, 10)
//     ''');

//       // CRIAR HIDROMETROS NO BANCO DE DADOS
//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("95BPJFQQM",1,0,25.3,300.0,1000.1,2000.2,3946.3,4523.4,57450.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-09-04")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA, IS_AGUA_QUENTE) values
//      ("95BPJAAAA",1,0,25.3,300.99,1000.19,2000.29,3946.39,4523.4,57450.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-09-04", "S")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("MYHOSOT1J",2,0,25.3,300.0,1000.1,2486.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,187.67,"2020-08-04")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("PFFIF3P15",3,0,25.3,300.0,1000.1,2000.2,3000.3,4456.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-07")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA, IS_AGUA_QUENTE) values
//      ("PFFIFAAAA",3,0,25.399,300.999,1000.1,2000.2,3000.39,4456.4,5000.5,6000.69,7000.79,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-07", "S")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("IN8KTNPA1",4,0,25.3,300.0,1000.1,2000.2,3000.3,4764.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,156.67,"2020-06-04")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("TB7Y0WF6K",5,0,25.3,300.0,1000.1,2345.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-05-05")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("Q0TS63SVN",6,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5000.5,6345.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,169.67,"2020-10-04")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("OH8OHZVDU",7,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-09")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("V23PUBVZ8",8,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5876.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,195.67,"2020-02-04")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("0WNGCQIWH",9,0,25.3,300.0,1000.1,2934.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-04")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA, IS_AGUA_QUENTE) values
//      ("0WNGCAAAA",9,0,258.399,300.999,1000.199,2934.2,3000.3,4000.499,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,"2020-04-04", "S")''');

//       await db.execute(
//           '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//      ("XDUJOG8C3",10,0,25.3,300.0,1000.1,2000.2,3000.3,4786.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,137.67,"2020-05-04")''');

//       // CRIAR LEITURAS NO BANCO DE DADOS

//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (1, "2020-05-06", 345354.9, 1, 1)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (2, "2020-05-06", 75834.9, 2, 1)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (3, "2020-02-06", 364354.9, 3, 2)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (4, "2020-06-06", 3478554.9, 4, 3)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (5, "2020-06-06", 3477644.9, 5, 3)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (6, "2020-03-06", 345834.9, 6, 4)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (7, "2020-07-06", 361254.9, 7, 5)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (8, "2020-03-06", 763454.9, 8, 6)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (9, "2020-05-06", 345367.9, 9, 7)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (10, "2020-06-06", 345354.9, 10, 8)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (11, "2020-05-06", 382464.9, 11, 9)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (12, "2020-05-06", 372344.9, 12, 9)''');
//       await db.execute(
//           '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     (13, "2020-01-06", 349464.9, 13, 10)''');

//       // CRIAR VALVULAS NO BANCO DE DADOS

//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",1)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",2)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",3)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",4)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",5)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",6)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",7)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",8)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("OFF",9)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",10)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",11)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",12)''');
//       await db.execute(
//           '''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values ("ON",13)''');
//     }
//     /////////

//     // CRIAR ALARMES NO BANCO DE DADOS

//     // '''
//     //   create table TB_ALARME
//     //   (
//     //       ID                integer primary key autoincrement
//     //                         constraint PK_ALARME,
//     //       DESCRICAO         text not null,
//     //       ID_TIPO_ALARME    integer not null
//     //                         constraint FK_ALARME_TIPO_ALARME
//     //                         references TB_TIPO_ALARME (ID),
//     //       ID_HIDROMETRO     integer  not null
//     //                         constraint FK_ALARME_HIDROMETRO
//     //                         references TB_HIDROMETRO (ID),
//     //       DATA_HORA         datetime
//     //   )
//     // ''',

//     //await db.execute('insert into TB_ALARME (DESCRICAO, ID_TIPO_ALARME, ID_HIDROMETRO, DATA_HORA) values ("válvula se rompeu", 1, 1)');

//     // CRIAR TIPO_ALARME NO BANCO DE DADOS

//     // await db.execute('''insert into TB_TIPO_ALARME (CODIGO, DESCRICAO) values
//     //      ("A1", "O lacre lógico se rompeu")''');
//     // await db.execute('''insert into TB_TIPO_ALARME (CODIGO, DESCRICAO) values
//     //      ("A2", "O lacre lógico foi reestabelecido")''');

//     // CRIAR IMÓVEIS NO BANCO DE DADOS

//     // await db
//     //     .execute('''insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values
//     //      ("1234567890", "Uma bela casa", 123)''');

//     // await db
//     //     .execute('''insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values
//     //      ("0192837465", "Uma outra bela casa", 124)''');

//     // await db
//     //     .execute('''insert into TB_IMOVEL (RGI, DESCRICAO, ID_CONDOMINIO) values
//     //      ("8576490321", "Mais outra bela casa...", 125)''');

//     // CRIAR ENDPOINTS NO BANCO DE DADOS

//     // await db.execute(
//     //     '''insert into  TB_ENDPOINT ( IDENTIFICACAO, ID_CONCENTRADOR, ID_IMOVEL) values
//     //     ("ABCDE12345", 1, 1)
//     //     ''');

//     // await db.execute(
//     //     '''insert into  TB_ENDPOINT ( IDENTIFICACAO, ID_CONCENTRADOR, ID_IMOVEL) values
//     //     ("12345ABCDE", 1, 2)
//     //     ''');

//     // CRIAR HIDROMETROS NO BANCO DE DADOS

//     // await db.execute(
//     //     '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//     //  ("ABCD1234A",1,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,2020-10-04)
//     // ''');
//     // await db.execute(
//     //     '''insert into TB_HIDROMETRO (IDENTIFICACAO, ID_ENDPOINT, LEITURA_INICIAL,INTERVALO_PULSO,VALOR_BASE,CONSUMO_JAN,CONSUMO_FEV,CONSUMO_MAR,CONSUMO_ABR,CONSUMO_MAI,CONSUMO_JUN,CONSUMO_JUL,CONSUMO_AGO,CONSUMO_SET,CONSUMO_OUT,CONSUMO_NOV,CONSUMO_DEZ,ULTIMA_LEITURA,DATA_HORA_ULTIMA_LEITURA) values
//     //  ("ABCD1234A",2,0,25.3,300.0,1000.1,2000.2,3000.3,4000.4,5000.5,6000.6,7000.7,8000.8,9000.9,1000.10,11000.11,12000.12,123.67,2020-10-04)
//     // ''');

//     // CRIAR LEITURAS NO BANCO DE DADOS

//     // await db.execute(
//     //     '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     // (123, "2020-10-04", 345354.9, 1, 1)
//     // ''');
//     // await db.execute(
//     //     '''insert into TB_LEITURA (IDENTIFICACAO, DATA_HORA_LEITURA, VALOR_LEITURA, ID_HIDROMETRO, ID_ENDPOINT ) values
//     // (321, "2020-10-04", 82353.33, 2, 2)
//     // ''');

//     // CRIAR VÁLVULAS NO BANCO DE DADOS

//     // await db.execute('''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values
//     // ("ON",3)
//     // ''');
//     // await db.execute('''insert into TB_VALVULA (STATUS, ID_HIDROMETRO) values
//     // ("OFF",4)
//     // ''');

//     // TESTAR PRESENÇA DOS DADOS NO BANCO DE DADOS

//     //TODO: Remover  o que está abaixo, está aí apenas para propósito de debug
//     if (false) {
//       List condominios = await db.rawQuery('SELECT * FROM TB_CONDOMINIO');
//       condominios.forEach((element) {
//         print(element);
//       });

//       List concentradores = await db.rawQuery('SELECT * FROM TB_CONDOMINIO');
//       concentradores.forEach((element) {
//         print(element);
//       });

//       List imoveis = await db.rawQuery('SELECT * FROM TB_IMOVEL');
//       imoveis.forEach((element) {
//         print('Imóvel: $element\n');
//       });

//       List endpoints = await db.rawQuery('SELECT * FROM TB_ENDPOINT');
//       endpoints.forEach((element) {
//         print('Endpoint : $element\n');
//       });

//       List hidrometros = await db.rawQuery('SELECT * FROM TB_HIDROMETRO');
//       hidrometros.forEach((element) {
//         print('Hidrômetro: $element\n');
//       });

//       List leituras = await db.rawQuery('SELECT * FROM TB_LEITURA');
//       leituras.forEach((element) {
//         print('Leitura: $element\n');
//       });

//       List valvulas = await db.rawQuery('SELECT * FROM TB_VALVULA');
//       valvulas.forEach((element) {
//         print('Válvula: $element\n');
//       });

//       List tiposAlarme = await db.rawQuery('SELECT * FROM TB_TIPO_ALARME');
//       tiposAlarme.forEach((element) {
//         print('Tipo Alarme: $element');
//       });

//       List alarmes = await db.rawQuery('SELECT * FROM TB_ALARME');
//       alarmes.forEach((element) {
//         print('Alarme: $element');
//       });
//     }
//   }
// }
