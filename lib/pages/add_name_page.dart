import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddName extends StatefulWidget {
  const AddName({super.key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController encargadoController = TextEditingController();
  TextEditingController servicioController = TextEditingController();
  TextEditingController gananciasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AGREGAR FRESA", style: TextStyle(color: Colors.white)),
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
              // Campos de texto con un diseño más moderno y estético
              _buildTextField(idController, "Ingrese Id de la Plataforma"),
              _buildTextField(nombreController, "Ingrese Nombre de la Plataforma"),
              _buildTextField(tipoController, "Ingrese Tipo de Plataforma"),
              _buildTextField(encargadoController, "Ingrese Encargado de la Plataforma"),
              _buildTextField(servicioController, "Ingrese Servicio de la Plataforma"),
              _buildTextField(gananciasController, "Ingrese Ganancias de la Plataforma"),

              // Botón de guardar con un diseño atractivo
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
                    await addFresa(
                      idController.text,
                      nombreController.text,
                      tipoController.text,
                      encargadoController.text,
                      servicioController.text,
                      gananciasController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Guardar", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for text fields with modern design
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
