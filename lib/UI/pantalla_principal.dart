import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Logic/calculo_porcentaje.dart';

class pantallaPrincipal extends StatefulWidget {
  @override
  State<pantallaPrincipal> createState() => pantallaPrincipalState();
}

class pantallaPrincipalState extends State<pantallaPrincipal> {
  //Logica
  final TextEditingController _hombresController = TextEditingController();
  final TextEditingController _mujeresController = TextEditingController();

  double _porcentajeHombres = 0.0;
  double _porcentajeMujeres = 0.0;
  String _errorMessage = '';

  void _calcularPorcentajes() {

    setState(() {
      _errorMessage = '';
    });


    final String hombresText = _hombresController.text.trim();
    final String mujeresText = _mujeresController.text.trim();

    if (hombresText.isEmpty || mujeresText.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingrese valores para ambos campos';
      });
      return;
    }

    if (!_esNumeroValido(hombresText) || !_esNumeroValido(mujeresText)) {
      setState(() {
        _errorMessage = 'Solo se permiten numeros enteros positivos';
      });
      return;
    }

    final int hombres = int.parse(hombresText);
    final int mujeres = int.parse(mujeresText);

    if (hombres < 0 || mujeres < 0) {
      setState(() {
        _errorMessage = 'Los numeros no pueden ser negativos';
      });
      return;
    }

    if (hombres == 0 && mujeres == 0) {
      setState(() {
        _porcentajeHombres = 0.0;
        _porcentajeMujeres = 0.0;
        _errorMessage = 'Ingrese al menos un valor mayor a cero';
      });
      return;
    }

    final calcularPorcentaje = calculoPorcentaje();
    setState(() {
      _porcentajeHombres = calcularPorcentaje.calcularPorcentaje(hombres, hombres + mujeres);
      _porcentajeMujeres = calcularPorcentaje.calcularPorcentaje(mujeres, hombres + mujeres);
    });
  }


  bool _esNumeroValido(String valor) {
    return RegExp(r'^[0-9]+$').hasMatch(valor);
  }

  void _limpiarCampos() {
    setState(() {
      _hombresController.clear();
      _mujeresController.clear();
      _porcentajeHombres = 0.0;
      _porcentajeMujeres = 0.0;
      _errorMessage = '';
    });
  }

  // Diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo de Porcentajes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _hombresController,
              decoration: InputDecoration(
                labelText: 'Total de Hombres',
                prefixIcon: const Icon(Icons.male),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _mujeresController,
              decoration: InputDecoration(
                labelText: 'Total de Mujeres',
                prefixIcon: const Icon(Icons.female),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            // Error message display
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _calcularPorcentajes,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calcular',
                    style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _limpiarCampos,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpiar',
                    style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Porcentaje de Hombres: ${_porcentajeHombres.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Porcentaje de Mujeres: ${_porcentajeMujeres.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}