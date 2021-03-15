import 'package:mongo_dart/mongo_dart.dart';

class Connecter {
  final String connectionString;
  Db db;
  Connecter(this.connectionString);

  Future<void> initialize() async {
    this.db = await Db.create(
        "mongodb+srv://<aure>:<n5arlmx4LWPgval1>@cluster0.kiq9v.mongodb.net/test");
    await this.db.open();
  }

  Stream<Map<String, dynamic>> findNoFilter() {
    DbCollection collection = this.db.collection("commerces");
    return collection.find();
  }
}
