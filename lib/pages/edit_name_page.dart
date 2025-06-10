import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController encargadoController = TextEditingController();
  TextEditingController servicioController = TextEditingController();
  TextEditingController gananciasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Obtener los argumentos pasados a esta pantalla
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // Rellenar los controladores con los valores existentes
    idController.text = arguments['id'];
    nombreController.text = arguments['nombre'];
    tipoController.text = arguments['tipo'];
    encargadoController.text = arguments['encargado'];
    servicioController.text = arguments['servicio'];
    gananciasController.text = arguments['ganancias'];

    return Scaffold(
      appBar: AppBar(
        title: Text("EDITAR FRESA", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.red[700], // Rojo fuerte para el AppBar
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo de texto con diseño estético
              _buildTextField(idController, "Edite el ID de la Fresa"),
              _buildTextField(nombreController, "Edite el Nombre de la Fresa"),
              _buildTextField(tipoController, "Edite el Tipo de la Fresa"),
              _buildTextField(encargadoController, "Edite el Encargado de la Fresa"),
              _buildTextField(servicioController, "Edite el Servicio de la Fresa"),
              _buildTextField(gananciasController, "Edite las Ganancias de la Fresa"),

              // Botón para actualizar con estilo moderno
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600], // Rojo suave para el botón
                    foregroundColor: Colors.white, // Color del texto
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Bordes redondeados
                    ),
                  ),
                  onPressed: () async {
                    // Obtener los argumentos de la pantalla
                    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

                    // Actualizar la fresa con los nuevos datos
                    await updateFresa(
                      arguments['uid'],
                      idController.text,
                      nombreController.text,
                      tipoController.text,
                      encargadoController.text,
                      servicioController.text,
                      gananciasController.text,
                    );

                    // Regresar a la pantalla anterior
                    Navigator.pop(context);
                  },
                  child: const Text("Actualizar", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reutilizable para campos de texto con diseño moderno
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.red[50], // Fondo suave para los campos de texto
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
