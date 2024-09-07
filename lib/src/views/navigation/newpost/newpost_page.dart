import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final GlobalKey<FormState> _keyForm = GlobalKey();
  final fireUid = FirebaseAuth.instance.currentUser!.uid;
  final supabase = Supabase.instance.client;
  // final _future = Supabase.instance.client.from('postagem').select('*').eq('id_fk_usuario', FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
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
                          child: Card(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(40.0),
                                width: (responsive.isMobile ||
                                        responsive.isTablet)
                                    ? MediaQuery.of(context).size.width *
                                        0.9 // 90% da largura da tela
                                    : 700,
                                child: Form(
                                  key: _keyForm,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormFieldComponent(
                                        iconP: const Icon(
                                            Icons.text_fields_rounded),
                                        controller: titleController,
                                        inputType: TextInputType.text,
                                        obscure: false,
                                        labelText: 'Título',
                                        validator: isNotEmpyt,
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormFieldComponent(
                                        iconP: const Icon(
                                            Icons.text_fields_rounded),
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
                                        iconP:
                                            const Icon(Icons.monetization_on),
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
                                      TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        controller: descriptionController,
                                        minLines: 10,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          hintText: 'Descrição',
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: isNotEmpyt,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        height: 80,
                                        width: responsive.isMobile
                                            ? double.infinity
                                            : 450,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_keyForm.currentState!
                                                .validate()) {
                                              String title = titleController
                                                  .value.text
                                                  .toString();
                                              String subtitle =
                                                  titleController.value.text
                                                      .toString();
                                              String local = localController
                                                  .value.text
                                                  .toString();
                                              String salary = salaryController
                                                  .value.text
                                                  .toString();
                                              String period = periodController
                                                  .value.text
                                                  .toString();
                                              String enterprise =
                                                  enterpriseController
                                                      .value.text
                                                      .toString();
                                              String description =
                                                  descriptionController
                                                      .value.text
                                                      .toString();
                                              sendPost(
                                                description: description,
                                                enterprise: enterprise,
                                                local: local,
                                                period: period,
                                                salary: salary,
                                                subtitle: subtitle,
                                                title: title,
                                              );
                                              _keyForm.currentState!.reset();
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            padding:
                                                const EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal: 10,
                                            ),
                                            backgroundColor:
                                                ColorSchemeManagerClass
                                                    .colorSecondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            foregroundColor:
                                                ColorSchemeManagerClass
                                                    .colorWhite,
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Postar vaga'),
                                              SizedBox(width: 10),
                                              Icon(Icons.send)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
        ],
      ),
    );
  }

  Future sendPost({
    required String title,
    required String subtitle,
    required String local,
    required String salary,
    required String description,
    required String period,
    required String enterprise,
  }) async {
    try {
      final response = await supabase.from('postagem').insert({
        'id_fk_usuario': fireUid.toString(),
        'titulo': title,
        'subtitulo': subtitle,
        'local': local,
        'salario': salary,
        'descricao': description,
        'periodo': period,
        'empresa': enterprise,
      });
      return 'Postagem enviada! $response';
    } catch (error) {
      return 'Erro ao criar usuário: $error';
    }
  }
}
