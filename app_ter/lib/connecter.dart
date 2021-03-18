import 'package:mongo_dart/mongo_dart.dart';

class Connecter {
  final String connectionString;
  Db _db;
  Connecter(this.connectionString);

  Future<void> initialize() async {
    this._db = await Db.create(this.connectionString);
    await this._db.open();
  }

  Stream<Map<String, dynamic>> findNoFilter() {
    DbCollection collection = this._db.collection("commerces");
    return collection.find();
  }
}
