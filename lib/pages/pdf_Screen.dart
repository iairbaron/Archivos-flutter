import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

import '../services/firebase_service.dart';

class PDFScreen extends StatefulWidget {
  static const String id = 'pdf_screen';

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late pw.Document pdf;
  late Uint8List archivoPdf;

  double sizeIcon1 = 45;
  double sizeIcon2 = 30;
  double sizeIcon3 = 30;

  @override
  void initState() {
    super.initState();
    initPDF();
    
  }

  Future<void> initPDF() async {
    archivoPdf = await generarPdf1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 25,
                  ),
                  child: Container(
                    child: PdfPreview(
                      build: (format) => archivoPdf,
                      useActions: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  await Printing.sharePdf(
                    bytes: archivoPdf,
                    filename: 'Documento.pdf',
                  );
                },
                child: Icon(
                  Icons.share,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }

Future<Uint8List> generarPdf1() async {
    pdf = pw.Document();

    List afiliaciones = await getCollectionWhere(
      'Afiliacion2023',
      'Usuario',
      'iairbaron@gmail.com',
    );

    for (var afiliacion in afiliaciones) {
      String nombre = afiliacion['Nombre'];
      String apellido = afiliacion['Apellido'];
      String dni = afiliacion['DNI'];
      String fechaNacimiento = afiliacion['Fecha nacimiento'];
      String celular = afiliacion['Celular'];
      String telefono = afiliacion['Telefono'];
      String direccion = afiliacion['Direccion'];
      String ciudad = afiliacion['Ciudad'];
      String provincia = afiliacion['Provincia'];
      String peso = afiliacion['Peso'];
      String arma = afiliacion['Arma'];
      String club = afiliacion['Club'];
      String maestro = afiliacion['Maestro'];
      String maestroInicio = afiliacion['Maestro inicio'];
      String codigoPostal = afiliacion['Código postal'];
      String telefonoEmergencia = afiliacion['Teléfono de emergencia'];
      String datosMedicos = afiliacion['Datos médicos que agregar'];
      String clubInicio = afiliacion['Club inicio'];
      String categoria = afiliacion['Categoría'];
      String logros = afiliacion['Logros'];

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero,
          header: (context) {
            return pw.Container(
              alignment: pw.Alignment.center,
              padding: pw.EdgeInsets.all(20),
            );
          },
           footer: (context) {
            if (context.pageNumber == 1) {
              // No mostrar el contenido del footer en la primera página
              return pw.Container();
            } else {
              return pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Column(
                          children: [
                            createTextWithPadding('Firma y Aclaración', 15),
                            createTextWithPadding('............', 15),
                            createTextWithPadding('Esgrimista', 15),
                          ],
                        ),
                        pw.Column(
                          children: [
                            createTextWithPadding('Firma Madre / Padre', 15),
                            createTextWithPadding('............', 15),
                            createTextWithPadding('En caso de ser menor', 15),
                          ],
                        ),
                      ],
                    ),
                    
                    createTextWithPadding('............', 15),
                    createTextWithPadding('Firma Presidente FAE', 15),
                  ],
                ),
              );

            }
          },
          build: (context) => [
            createTextWithPadding('Datos medicos', 50, PdfColors.blue),
            pw.SizedBox(height: 20),
            createTextWithPadding('Nombre: $nombre', 20),
            createTextWithPadding('Apellido: $apellido', 20),
            createTextWithPadding('DNI: $dni', 20),
            createTextWithPadding('Fecha de nacimiento: $fechaNacimiento', 20),
            createTextWithPadding('Celular: $celular', 20),
            createTextWithPadding('Teléfono: $telefono', 20),
            createTextWithPadding('Dirección: $direccion', 20),
            createTextWithPadding('Ciudad: $ciudad', 20),
            createTextWithPadding('Provincia: $provincia', 20),
            createTextWithPadding('Peso: $peso', 20),
            createTextWithPadding('Arma: $arma', 20),
            createTextWithPadding('Club: $club', 20),
            createTextWithPadding('Maestro: $maestro', 20),
            createTextWithPadding('Maestro inicio: $maestroInicio', 20),
            createTextWithPadding('Código postal: $codigoPostal', 20),
            createTextWithPadding( 'Teléfono de emergencia: $telefonoEmergencia', 20),
            createTextWithPadding('Datos médicos: $datosMedicos', 20),
            createTextWithPadding('Club inicio: $clubInicio', 20),
            createTextWithPadding('Categoría: $categoria', 20),
            createTextWithPadding('Logros: $logros', 20),
          ],
        ),
      );
    }

    return pdf.save();
  }


  pw.Padding createTextWithPadding(String text, double fontSize,
      [PdfColor? color, pw.TextAlign? textAlign]) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: fontSize,
          color: color ?? PdfColors.black,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
