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
        title: Text("Mi CRUD"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deletePeople(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direcion) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Estas seguro que quieres eliminar a ${snapshot.data?[index]['name']}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Si estoy seguro"),
                            ),
                          ],
                        );
                      },
                    );

                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    onTap: (() async {
                      await Navigator.pushNamed(
                        context,
                        '/edit',
                        arguments: {
                          "name": snapshot.data?[index]['name'],
                          "uid": snapshot.data?[index]['uid'],
                        },
                      );
                      setState(() {});
                    }),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("Cargando..."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}