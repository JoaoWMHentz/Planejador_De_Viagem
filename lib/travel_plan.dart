import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'travel_detail.dart';
import 'dart:io';

class TravelPlan extends StatefulWidget {
  @override
  _TravelPlanState createState() => _TravelPlanState();
}

class _TravelPlanState extends State<TravelPlan> {
  final List<Map<String, dynamic>> _plans = [];
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _addPlan() {
    if (_destinationController.text.isNotEmpty && _budgetController.text.isNotEmpty) {
      setState(() {
        _plans.add({
          'destination': _destinationController.text,
          'budget': double.parse(_budgetController.text),
          'activities': [],
          'image': _image,
        });
        _destinationController.clear();
        _budgetController.clear();
        _image = null; // Limpa a imagem após adicionar o plano
      });
    }
  }

  void _navigateToDetails(Map<String, dynamic> plan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TravelDetail(plan: plan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planejador de Viagens'),
      ),
      body: ListView.builder(
        itemCount: _plans.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_plans[index]['destination']),
              subtitle: Text('Orçamento: \$${_plans[index]['budget']}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _navigateToDetails(_plans[index]),
              leading: _plans[index]['image'] != null
                  ? Image.file(
                _plans[index]['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF1693A5),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Adicionar Plano de Viagem'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _destinationController,
                      decoration: InputDecoration(
                        labelText: 'Destino',
                        labelStyle: TextStyle(color: Colors.black), // Cor da label
                      ),
                      style: TextStyle(color: Colors.black), // Cor do texto
                    ),

                    TextField(
                      controller: _budgetController,
                      decoration: InputDecoration(
                        labelText: 'Orçamento',
                        labelStyle: TextStyle(color: Colors.black), // Cor da label

                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black), // Cor do texto
                    ),

                    SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF1693A5),
                      ),
                      onPressed: _pickImage,
                      child: Text('Selecionar Imagem', style:  TextStyle(color: Colors.white)),
                    ),
                    if (_image != null)
                      Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: Color(0xFF1693A5),
                    ),
                    onPressed: () {
                      _addPlan();
                      Navigator.of(context).pop();
                    },
                    child: Text('Adicionar', style:  TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: Color(0xFF1693A5),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancelar', style:  TextStyle(color: Colors.white),),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
