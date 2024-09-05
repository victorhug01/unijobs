import 'package:flutter/material.dart';
import 'package:unijobs/src/components/textformfields/textformfield_component.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/theme/theme_color.dart';
import 'package:unijobs/src/validations/mixin_validation.dart';

class NewpostPage extends StatefulWidget {
  const NewpostPage({super.key});

  @override
  State<NewpostPage> createState() => _NewpostPageState();
}

class _NewpostPageState extends State<NewpostPage> with ValidationMixinClass {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController periodController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController localController = TextEditingController();
  final TextEditingController enterpriseController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Material(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(40.0),
                          width: (responsive.isMobile || responsive.isTablet)
                              ? 1.5
                              : 700,
                          child: Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormFieldComponent(
                                  iconP: const Icon(Icons.text_fields_rounded),
                                  controller: titleController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Título',
                                  validator: isNotEmpyt,
                                ),
                                const SizedBox(height: 15),
                                TextFormFieldComponent(
                                  iconP: const Icon(Icons.text_fields_rounded),
                                  controller: subtitleController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Subtítulo',
                                  validator: isNotEmpyt,
                                ),
                                const SizedBox(height: 15),
                                TextFormFieldComponent(
                                  iconP: const Icon(Icons.location_on),
                                  controller: localController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Local',
                                  validator: isNotEmpyt,
                                ),
                                const SizedBox(height: 15),
                                TextFormFieldComponent(
                                  iconP: const Icon(Icons.monetization_on),
                                  controller: salaryController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Salário',
                                  validator: isNotEmpyt,
                                ),
                                const SizedBox(height: 15),
                                TextFormFieldComponent(
                                  iconP: const Icon(Icons.date_range),
                                  controller: periodController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Período',
                                  validator: isNotEmpyt,
                                ),
                                const SizedBox(height: 15),
                                TextFormFieldComponent(
                                  iconP: const Icon(Icons.apartment),
                                  controller: enterpriseController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Nome empresa',
                                  validator: isNotEmpyt,
                                ),
                                const SizedBox(height: 25),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  controller: descriptionController,
                                  minLines: 10,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Descrição',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  width: responsive.isMobile
                                      ? double.infinity
                                      : 450,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 10,
                                      ),
                                      backgroundColor:
                                          ColorSchemeManagerClass.colorBlack,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      foregroundColor:
                                          ColorSchemeManagerClass.colorWhite,
                            
                                    ),
                                    child: const Text('data'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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