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

  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchPosts();
  }

  Future<List<Map<String, dynamic>>> _fetchPosts() async {
    final response = await supabase
        .from('postagem')
        .select('*')
        .eq('id_fk_usuario', fireUid);

    print('Dados retornados: $response');

    return response as List<Map<String, dynamic>>;
  }

  Future<void> _deletePost(int postId) async {
    try {
      final response =
          await supabase.from('postagem').delete().eq('id_postagem', postId);
      if (response.error == null) {
        setState(() {
          _future =
              _fetchPosts(); 
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Postagem excluída com sucesso!')),
        );
      } else {
        print('Erro ao excluir postagem: ${response.error!.message}');
      }
    } catch (error) {
      print('Erro ao excluir postagem: $error');
    }
  }

  Future<void> _addPost({
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
      if (response.error == null) {
        setState(() {
          _future = _fetchPosts();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Postagem criada com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Erro ao criar postagem: ${response.error!.message}')),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                                    ? MediaQuery.of(context).size.width * 0.9
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
                                          hintText: 'Descrição (coloque formas de contato)',
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
                                              String title =
                                                  titleController.value.text;
                                              String subtitle =
                                                  subtitleController.value.text;
                                              String local =
                                                  localController.value.text;
                                              String salary =
                                                  salaryController.value.text;
                                              String period =
                                                  periodController.value.text;
                                              String enterprise =
                                                  enterpriseController
                                                      .value.text;
                                              String description =
                                                  descriptionController
                                                      .value.text;
                                              _addPost(
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
                                              Navigator.pushReplacementNamed(context, 'roteadorScreen');
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            padding: const EdgeInsets.symmetric(
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
                                              Icon(Icons.send),
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
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final posts = snapshot.data!;
                return Center(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorSchemeManagerClass.colorPrimary.withOpacity(0.8),
                                ColorSchemeManagerClass.colorSecondary.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            tileColor: Colors.transparent,
                            title: Text(post['titulo']),
                            subtitle: Text(post['empresa']),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmar Exclusão'),
                                      content: const Text(
                                          'Tem certeza de que deseja excluir esta postagem?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancelar'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Excluir'),
                                          onPressed: () {
                                            final idStr =
                                                post['id_postagem']?.toString();
                                            if (idStr != null && idStr.isNotEmpty) {
                                              final postId = int.tryParse(
                                                  post['id_postagem']?.toString() ??
                                                      '');
                                              if (postId != null) {
                                                _deletePost(postId);
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'ID da postagem está vazio')),
                                              );
                                            }
                                            Navigator.of(context).pop();
                                            Navigator.pushReplacementNamed(context, 'roteadorScreen');
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(post['titulo']),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text('Empresa: ${post['empresa']}'),
                                          Text('Local: ${post['local']}'),
                                          Text('Descrição: ${post['descricao']}'),
                                          Text('Período: ${post['periodo']}'),
                                          Text('Salário: ${post['salario']}'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Fechar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
