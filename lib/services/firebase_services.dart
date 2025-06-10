import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getFresas() async {
  List fresas = [];
  CollectionReference collectionReferenceFresas = db.collection("Fresas");
  QuerySnapshot queryFresas = await collectionReferenceFresas.get();
  for (var doc in queryFresas.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final Fresas = {
      "id": data['id'],
      "uid": doc.id,
      "nombre": data['nombre'],
      "tipo": data['tipo'],
      "encargado": data['encargado'],
      "servicio": data['servicio'],
      "ganancias": data['ganancias'],
    };
    fresas.add(Fresas);
  }
  await Future.delayed(const Duration(seconds: 5));
  return fresas;
}

Future<void> addFresa(
  String id, 
  String nombre, 
  String tipo, 
  String encargado, 
  String servicio, 
  String ganancias,
) async {
  await FirebaseFirestore.instance.collection('Fresas').doc().set({
    'id': id,
    'nombre': nombre,
    'tipo': tipo,
    'encargado': encargado,
    'servicio': servicio,
    'ganancias': ganancias,
  });
}

Future<void> updateFresa(
  String uid,
  String newid,
  String newnombre,
  String newtipo,
  String newencargado,
  String newservicio,
  String newganancias,
) async {
  await db.collection("Fresas").doc(uid).update({
    "id": newid,
    "nombre": newnombre,
    "tipo": newtipo,
    "encargado": newencargado,
    "servicio": newservicio,
    "ganancias": newganancias,
  });
}

Future<void> deleteFresa(String uid) async {
  await db.collection("Fresas").doc(uid).delete();
}
