import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/firebase_service.dart';
import '../utils/dialog_utils.dart';
import '../utils/validations.dart';

class AfiliacionAnual extends StatefulWidget {
  @override
  _AfiliacionAnualState createState() => _AfiliacionAnualState();
}

class _AfiliacionAnualState extends State<AfiliacionAnual> {
  final _formKey = GlobalKey<FormState>();

  AuthService _authService = AuthService();
  TextEditingController nameController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController ciudadController = TextEditingController();
  TextEditingController provinciaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController maestroController = TextEditingController();
  TextEditingController clubController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController weaponController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController maestroInicioController = TextEditingController();
  TextEditingController codigoPostalController = TextEditingController();
  TextEditingController telefonoEmergenciaController = TextEditingController();
  TextEditingController nombreMadreController = TextEditingController();
  TextEditingController datosMedicosController = TextEditingController();
  TextEditingController clubInicioController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController logrosController = TextEditingController();
  TextEditingController nombrePadreController = TextEditingController();

  String? email;

  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  Future<void> _getEmail() async {
    final emailValue = await _authService.readEmail();
    setState(() {
      email = emailValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Afiliación Anual',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            FutureBuilder(
              future: getCollectionWhere("UsuarioPrueba", "Usuario", "$email"),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final datos = snapshot.data?[0] as Map<String, dynamic>;
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          initialValue: datos["Nombre"],
                          decoration:
                              const InputDecoration(labelText: "Nombre"),
                          onChanged: (value) {
                            datos["Nombre"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Apellido"],
                          decoration:
                              const InputDecoration(labelText: "Apellido"),
                          onChanged: (value) {
                            datos["Apellido"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Celular"],
                          decoration:
                              const InputDecoration(labelText: "Celular"),
                          onChanged: (value) {
                            datos["Celular"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Ciudad"],
                          decoration:
                              const InputDecoration(labelText: "Ciudad"),
                          onChanged: (value) {
                            datos["Ciudad"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Club"],
                          decoration: const InputDecoration(labelText: "Club"),
                          onChanged: (value) {
                            datos["Club"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["DNI"],
                          enabled: false,
                          decoration: const InputDecoration(labelText: "DNI"),
                          onChanged: (value) {
                            datos["DNI"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Direccion"],
                          decoration:
                              const InputDecoration(labelText: "Direccion"),
                          onChanged: (value) {
                            datos["Direccion"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Estado civil"],
                          decoration:
                              const InputDecoration(labelText: "Estado civil"),
                          onChanged: (value) {
                            datos["Estado civil"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Fecha nacimiento"],
                          decoration: const InputDecoration(
                            labelText: "Fecha nacimiento",
                          ),
                          enabled: false, // Desactiva el campo
                          onChanged: (value) {
                            // El campo está desactivado, por lo que este código no se ejecutará
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Maestro"],
                          enabled: false,
                          decoration: const InputDecoration(
                              labelText: "Maestro actual"),
                          onChanged: (value) {
                            datos["Maestro"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Peso"],
                          decoration: const InputDecoration(labelText: "Peso"),
                          onChanged: (value) {
                            datos["Peso"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Provincia"],
                          decoration:
                              const InputDecoration(labelText: "Provincia"),
                          onChanged: (value) {
                            datos["Provincia"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Sexo"],
                          enabled: false,
                          decoration: const InputDecoration(labelText: "Sexo"),
                          onChanged: (value) {
                            datos["Sexo"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Pais"],
                          decoration: const InputDecoration(labelText: "Pais"),
                          onChanged: (value) {
                            datos["Pais"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Telefono"],
                          decoration:
                              const InputDecoration(labelText: "Telefono"),
                          onChanged: (value) {
                            datos["Telefono"] = value;
                          },
                        ),
                        TextFormField(
                          initialValue: datos["Arma"],
                          enabled: false, // Desactiva el campo
                          decoration: const InputDecoration(labelText: "Arma"),
                          onChanged: (value) {
                            datos["Arma"] = value;
                          },
                        ),
                        TextFormField(
                          controller: maestroInicioController,
                          decoration: const InputDecoration(
                              labelText: 'Maestro inicio'),
                          onChanged: (value) {
                            datos['Maestro inicio'] = value;
                          },
                          validator: Validator.validateOthers,
                        ),
                        TextFormField(
                          controller: codigoPostalController,
                          decoration:
                              const InputDecoration(labelText: 'Código postal'),
                          onChanged: (value) {
                            datos['Código postal'] = value;
                          },
                          validator: (value) =>
                              Validator.validateNumber(value, 8),
                        ),
                        TextFormField(
                          controller: telefonoEmergenciaController,
                          decoration: const InputDecoration(
                              labelText: 'Teléfono de emergencia'),
                          onChanged: (value) {
                            datos['Teléfono de emergencia'] = value;
                          },
                          validator: (value) =>
                              Validator.validateNumber(value, 8),
                        ),
                        TextFormField(
                          controller: nombreMadreController,
                          decoration:
                              const InputDecoration(labelText: 'Nombre madre'),
                          onChanged: (value) {
                            datos['Nombre madre'] = value;
                          },
                          validator: Validator.validateName,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Nombre del padre '),
                          onChanged: (value) {
                            datos['Nombre padre'] = value;
                          },
                          validator: Validator.validateName,
                        ),
                        TextFormField(
                          controller: datosMedicosController,
                          decoration: const InputDecoration(
                              labelText: 'Datos médicos que agregar'),
                          onChanged: (value) {
                            datos['Datos médicos que agregar'] = value;
                          },
                          validator: Validator.validateOthers,
                        ),
                        TextFormField(
                          controller: clubInicioController,
                          decoration:
                              const InputDecoration(labelText: 'Club inicio'),
                          onChanged: (value) {
                            datos['Club inicio'] = value;
                          },
                          validator: Validator.validateOthers,
                        ),
                        TextFormField(
                          controller: categoriaController,
                          decoration:
                              const InputDecoration(labelText: 'Categoría'),
                          onChanged: (value) {
                            datos['Categoría'] = value;
                          },
                          validator: Validator.validateOthers,
                        ),
                        TextFormField(
                          controller: logrosController,
                          decoration:
                              const InputDecoration(labelText: 'Logros'),
                          onChanged: (value) {
                            datos['Logros'] = value;
                          },
                          validator: Validator.validateOthers,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final usuarioData = {
                              "Nombre": datos["Nombre"],
                              "Apellido": datos["Apellido"],
                              "DNI": datos["DNI"],
                              "Fecha nacimiento": datos["Fecha nacimiento"],
                              "Celular": datos["Celular"],
                              "Telefono": datos["Telefono"],
                              "Direccion": datos["Direccion"],
                              "Ciudad": datos["Ciudad"],
                              "Provincia": datos["Provincia"],
                              "Peso": datos["Peso"],
                              "Arma": datos["Arma"],
                              "Club": datos["Club"],
                              "Maestro": datos["Maestro"],
                              "Usuario": email ?? "",
                              "Maestro inicio": maestroInicioController.text,
                              "Código postal": codigoPostalController.text,
                              "Teléfono de emergencia":
                                  telefonoEmergenciaController.text,
                              "Nombre madre": nombreMadreController.text,
                              "Datos médicos que agregar":
                                  datosMedicosController.text,
                              "Club inicio": clubInicioController.text,
                              "Categoría": categoriaController.text,
                              "Logros": logrosController.text,
                            };
                            showAlertDialog(context, 'Información',
                                'Se envio tu formulario');
                            await addDatos(
                                collection: "Afiliacion2023",
                                data: usuarioData);
                            Navigator.pushReplacementNamed(
                                context, '/Afiliacion2023');
                          },
                          child: Text('Guardar cambios'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
