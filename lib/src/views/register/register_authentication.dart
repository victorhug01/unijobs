import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/components/textformfields/textformfield_component.dart';
import 'package:unijobs/src/services/authentication_service.dart';
import 'package:unijobs/src/theme/theme_color.dart';
import 'package:unijobs/src/validations/mixin_validation.dart';

class RegisterAuthentication extends StatefulWidget {
  const RegisterAuthentication({super.key});

  @override
  State<RegisterAuthentication> createState() => _RegisterAuthenticationState();
}

class _RegisterAuthenticationState extends State<RegisterAuthentication> with ValidationMixinClass {
  bool? isChecked = false;
  final AuthenticationService _authService = AuthenticationService();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('loginAuthentication');
        },
        child: Icon(Icons.adaptive.arrow_back),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/fundo_circulo.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Container(
                    color: ColorSchemeManagerClass.colorWhite,
                    width: responsive.isMobile ? double.infinity : 450,
                    child: Form(
                      key: _keyForm,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Image.asset(
                                'assets/unimar_black.png',
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const Text(
                              'Crie Sua Conta',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Preencha os campos abaixo para criar sua conta e começar a usar nossos serviços. É rápido e fácil!',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            const Row(
                              children: <Widget>[
                                Expanded(child: Divider()),
                                Text("Ou"),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 15),
                            TextFormFieldComponent(
                              controller: nameController,
                              inputType: TextInputType.text,
                              labelText: 'Nome completo',
                              validator: isNotEmpyt,
                              obscure: false,
                            ),
                            const SizedBox(height: 10),
                            TextFormFieldComponent(
                              obscure: false,
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              labelText: 'Email',
                              validator: (value) =>
                                  EmailValidator.validate(value.toString())
                                      ? null
                                      : "Email inválido",
                            ),
                            const SizedBox(height: 15),
                            TextFormFieldComponent(
                              controller: passwordController,
                              inputType: TextInputType.text,
                              labelText: 'Senha',
                              validator: (value) => combine([
                                () => isNotEmpyt(value),
                                () => hasSixChars(value),
                                () => value.toString() !=
                                        confirmPasswordController.text
                                    ? "Senhas diferentes"
                                    : null
                              ]),
                              obscure: true,
                            ),
                            const SizedBox(height: 15),
                            TextFormFieldComponent(
                              controller: confirmPasswordController,
                              inputType: TextInputType.text,
                              labelText: 'Confirmar senha',
                              validator: (value) => combine([
                                () => isNotEmpyt(value),
                                () => hasSixChars(value),
                                () =>
                                    value.toString() != passwordController.text
                                        ? "Senhas diferentes"
                                        : null
                              ]),
                              obscure: true,
                            ),
                            const SizedBox(height: 35),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_keyForm.currentState!.validate()) {
                                    final sm = ScaffoldMessenger.of(context);
                                    final navigation = Navigator.of(context);
                                    String name = nameController.text;
                                    String email = emailController.text;
                                    String password = passwordController.text;

                                    
                                    showDialog(
                                      context: context,
                                      barrierDismissible:
                                          false, 
                                      builder: (BuildContext context) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );

                                    try {
                                      
                                      await _authService.registerUser(
                                        name: name,
                                        email: email,
                                        password: password,
                                      );

                                      
                                      sm.showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              ColorSchemeManagerClass
                                                  .colorCorrect,
                                          content:
                                              const Text('Cadastro concluído!'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    } catch (e) {
                                      
                                      sm.showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Erro ao registrar usuário: $e'),
                                        ),
                                      );
                                    } finally {
                                      
                                      navigation.pop();

                                      
                                      navigation.pushReplacementNamed(
                                          'loginAuthentication');
                                    }

                                    
                                    _keyForm.currentState!.reset();
                                  }
                                },
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
                                ),
                                child: Text(
                                  'Conectar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: ColorSchemeManagerClass.colorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
