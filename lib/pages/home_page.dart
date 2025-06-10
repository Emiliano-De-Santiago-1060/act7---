import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plataformas De Venta", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.red[700], // Rojo fuerte
        elevation: 5,
      ),
      body: FutureBuilder(
        future: getFresas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteFresa(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                    setState(() {});
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Eliminar ${snapshot.data?[index]['nombre']}",
                          ),
                          content: Text("¿Estás seguro?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text("No", style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text("Sí", style: TextStyle(color: Colors.green)),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red[400], // Rojo medio
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.red[50], // Fondo suave
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      title: Text(
                        snapshot.data?[index]['id'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.red[800],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.key, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text('ID: ${snapshot.data?[index]['id'] ?? ''}', style: TextStyle(color: Colors.red[600])),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.sell, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text('Nombre: ${snapshot.data?[index]['nombre'] ?? ''}', style: TextStyle(color: Colors.red[600])),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.category, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text('Tipo: ${snapshot.data?[index]['tipo'] ?? ''}', style: TextStyle(color: Colors.red[600])),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text('Encargado: ${snapshot.data?[index]['encargado'] ?? ''}', style: TextStyle(color: Colors.red[600])),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.money, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text('Ganancias: ${snapshot.data?[index]['ganancias'] ?? ''}', style: TextStyle(color: Colors.red[600])),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.accessibility, size: 18, color: Colors.red[600]),
                              const SizedBox(width: 8),
                              Text('Servicio: ${snapshot.data?[index]['servicio'] ?? ''}', style: TextStyle(color: Colors.red[600])),
                            ],
                          ),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(context, "/edit", arguments: {
                          'id': snapshot.data?[index]['id'],
                          'nombre': snapshot.data?[index]['nombre'],
                          'tipo': snapshot.data?[index]['tipo'],
                          'encargado': snapshot.data?[index]['encargado'],
                          'servicio': snapshot.data?[index]['servicio'],
                          'ganancias': snapshot.data?[index]['ganancias'],
                          'uid': snapshot.data?[index]['uid'],
                        });
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        backgroundColor: Colors.red[400], // Rojo más suave para el FAB
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
