// Importamos el paquete cloud_firestore que nos permite interactuar con Cloud Firestore

import "package:cloud_firestore/cloud_firestore.dart";

// Creamos una instancia de Firestore que nos permite acceder a la base de datos de Firestore
FirebaseFirestore db = FirebaseFirestore.instance;

// Función asincornica para obtener la lista de  que querramos
Future<List> getColeccion(String coleccion) async {
  List documentos = [];

  CollectionReference collectionReference = db.collection(coleccion);

  QuerySnapshot querySnapshot = await collectionReference.get();

  for (var documento in querySnapshot.docs) {
    documentos.add(documento.data());
    // ignore: avoid_print
  }

  return documentos;
}

Future<List> getCollectionWhere(String collection, String field, dynamic value) async {
  List documents = [];

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collection);

  QuerySnapshot querySnapshot =
      await collectionReference.where(field, isEqualTo: value).get();

  for (var document in querySnapshot.docs) {
    documents.add(document.data());
  }

  return documents;
}

Future<void> updateData( String coleccion, Map<String, dynamic> datos, dynamic value
) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(coleccion);

  QuerySnapshot querySnapshot =
      await collectionReference.where("Usuario", isEqualTo: value).get();

  for (var documento in querySnapshot.docs) {
    await collectionReference.doc(documento.id).update(datos);
  }
}

Future<void> addDatos({
  required String collection,
  required Map<String, dynamic> data,
}) async {
  await FirebaseFirestore.instance.collection(collection).add(data);
}



