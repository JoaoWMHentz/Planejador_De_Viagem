import 'package:flutter/material.dart';

class TravelDetail extends StatefulWidget {
  final Map<String, dynamic> plan;

  TravelDetail({required this.plan});

  @override
  _TravelDetailState createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  final TextEditingController _activityController = TextEditingController();

  void _addActivity() {
    if (_activityController.text.isNotEmpty) {
      setState(() {
        widget.plan['activities'].add({'activity': _activityController.text, 'completed': false});
        _activityController.clear();
      });
    }
  }

  void _toggleActivity(int index) {
    setState(() {
      widget.plan['activities'][index]['completed'] = !widget.plan['activities'][index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plan['destination']),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Orçamento: \$${widget.plan['budget']}', style: TextStyle(fontSize: 20)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.plan['activities'].length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(widget.plan['activities'][index]['activity']),
                  value: widget.plan['activities'][index]['completed'],
                  onChanged: (bool? value) {
                    _toggleActivity(index);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _activityController,
                    decoration: InputDecoration(labelText: 'Adicionar Atividade'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addActivity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
