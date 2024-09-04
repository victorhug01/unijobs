import 'package:flutter/material.dart';
import 'package:unijobs/src/components/textformfields/textformfield_component.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
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
                return Center(
                  child: Material(
                    child: SizedBox(
                      width: responsive.width / 1.2,
                      height: MediaQuery.sizeOf(context).height / 1.2,
                      child: Form(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(70.0),
                            child: Column(
                              children: [
                                TextFormFieldComponent(
                                  controller: titleController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Título',
                                  validator: isNotEmpyt,
                                ),
                                TextFormFieldComponent(
                                  controller: subtitleController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Subtítulo',
                                  validator: isNotEmpyt,
                                ),
                                TextFormFieldComponent(
                                  controller: localController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Local',
                                  validator: isNotEmpyt,
                                ),
                                TextFormFieldComponent(
                                  controller: salaryController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Salário',
                                  validator: isNotEmpyt,
                                ),
                                TextFormFieldComponent(
                                  controller: periodController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Período',
                                  validator: isNotEmpyt,
                                ),
                                TextFormFieldComponent(
                                  controller: enterpriseController,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  labelText: 'Nome empresa',
                                  validator: isNotEmpyt,
                                ),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  controller: descriptionController,
                                  minLines: 10,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Descrição',
                                    border: OutlineInputBorder(),
                                  ),
                                )
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

/*
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://swqmvhzmtijusbsdsbme.supabase.co',
    anonKey:
        '',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final _future = Supabase.instance.client.from('user').select();
    Future<void> updateCountry() async {
      try {
        final response = await Supabase.instance.client
            .from('user')
            .update({'name': 'Pão d macaxeira'}).eq('id', 1);

        if (response.error != null) {
          // Lidar com erros, por exemplo, mostrar um snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.error.message),
            ),
          );
        } else {
          // Atualização realizada com sucesso
          print('País atualizado com sucesso!');
        }
      } catch (error) {
        // Lidar com outras exceções
        print('Erro ao atualizar o país: $error');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body: ElevatedButton(onPressed: () {updateCountry();}, child: Text('Atualizar')),
      // body: FutureBuilder(
      //   future: _future,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final countries = snapshot.data!;
      //     return ListView(
      //       children: countries
      //            .map((user) => ListTile(
      //               title: Text(user['name']),
      //               subtitle: Text(user['uid']),
      //               leading: Text(user['enterprise_name']),
      //             ))
      //            .toList(),
      //     );
      // return ListView.builder(
      //   itemCount: countries.length,
      //   itemBuilder: ((context, index) {
      //     final country = countries[index];
      //     return ListTile(
      //       title: Text(country['name']),
      //       subtitle: Text(country['uid']),
      //       leading: Text(country['enterprise_name']),
      //     );
      //   }),
      // );
      // },
      // ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: GridView.builder(
          controller: ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: 10,
          itemBuilder: ((context, index) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              height: 200,
              color: Colors.red,
            );
          }),
        ),
      ),
    );
  }
}
*/
