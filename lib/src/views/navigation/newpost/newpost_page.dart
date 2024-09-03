import 'package:flutter/material.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/validations/mixin_validation.dart';

class NewpostPage extends StatefulWidget {
  const NewpostPage({super.key});

  @override
  State<NewpostPage> createState() => _NewpostPageState();
}

class _NewpostPageState extends State<NewpostPage> with ValidationMixinClass {
  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Center(
                  child: Container(
                    color: Colors.red,
                    margin: const EdgeInsets.all(15.0),
                    width: responsive.width / 1.2,
                    height: MediaQuery.sizeOf(context).height / 1.2,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('data'),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              Text('Nova Postagem'),
            ],
          ),
        ),
      ),
    );
  }
}
