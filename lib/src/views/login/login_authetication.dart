import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:unijobs/src/responsive/display_responsive.dart';
import 'package:unijobs/src/components/textformfields/textformfield_component.dart';
import 'package:unijobs/src/services/authentication_service.dart';
import 'package:unijobs/src/theme/theme_color.dart';
import 'package:unijobs/src/validations/mixin_validation.dart';

class LoginAuthentication extends StatefulWidget {
  const LoginAuthentication({super.key});

  @override
  State<LoginAuthentication> createState() => _LoginAuthenticationState();
}

class _LoginAuthenticationState extends State<LoginAuthentication>
    with ValidationMixinClass {
  bool? isChecked = false;
  final GlobalKey<FormState> _keyForm = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final sm = ScaffoldMessenger.of(context);
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.sizeOf(context).height,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Image.asset(
                                  'assets/unimar_escrito_black.png',
                                  width: 200,
                                ),
                              ),
                              SizedBox(
                                width: responsive.isMobile ? double.infinity : 450,
                                child: Form(
                                  key: _keyForm,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Bem-vindo(a) à Unijobs',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Sua nova plataforma de contratação exclusiva de alunos da unimar.',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      const Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Divider(),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Entar"),
                                          ),
                                          Expanded(
                                            child: Divider(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormFieldComponent(
                                        obscure: false,
                                        controller: emailController,
                                        inputType: TextInputType.emailAddress,
                                        labelText: 'Email',
                                        validator: (value) =>
                                            EmailValidator.validate(
                                                    value.toString())
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
                                        ]),
                                        obscure: true,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                activeColor:
                                                    ColorSchemeManagerClass
                                                        .colorBlack,
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value;
                                                  });
                                                },
                                              ),
                                              const Text('Relebrar senha'),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed('forgotPassword');
                                            },
                                            child: Text(
                                              'Esqueci minha senha',
                                              style: TextStyle(
                                                color: ColorSchemeManagerClass
                                                    .colorBlack,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 35),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_keyForm.currentState!
                                                .validate()) {
                                              String email =
                                                  emailController.text;
                                              String password =
                                                  passwordController.text;
                                              final navigation =
                                                  Navigator.of(context);
                          
                                              // Exibe o CircularProgressIndicator enquanto o processo está em andamento
                                              showDialog(
                                                context: context,
                                                barrierDismissible:
                                                    false, // Impede que o usuário feche o diálogo tocando fora
                                                builder:
                                                    (BuildContext context) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              );
                          
                                              try {
                                                // Executa o processo de login
                                                String? error =
                                                    await _authService
                                                        .signInUsers(
                                                            email: email,
                                                            password: password);
                          
                                                // Caso haja erro, exibe um SnackBar com a mensagem
                                                if (error != null) {
                                                  sm.showSnackBar(
                                                    SnackBar(
                                                      backgroundColor:
                                                          ColorSchemeManagerClass
                                                              .colorDanger,
                                                      content: Text(error),
                                                      duration: const Duration(
                                                          seconds: 3),
                                                    ),
                                                  );
                                                }
                                              } catch (e) {
                                                // Lida com erros inesperados
                                                sm.showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        ColorSchemeManagerClass
                                                            .colorDanger,
                                                    content: Text(
                                                        'Erro ao fazer login: $e'),
                                                    duration: const Duration(
                                                        seconds: 3),
                                                  ),
                                                );
                                              } finally {
                                                // Fecha o CircularProgressIndicator após o processo
                                                navigation.pop();
                                              }
                                              _keyForm.currentState!.reset();
                                              navigation.pushReplacementNamed(
                                                  'roteadorScreen');
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
                                                    .colorBlack,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          child: Text(
                                            'Conectar',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: ColorSchemeManagerClass
                                                  .colorWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Não tem uma conta?'),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              padding: const EdgeInsets.all(2),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  'registerAuthetication');
                                            },
                                            child: const Text(
                                              'clique aqui para criar uma conta',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      (responsive.isMobile ||
                              responsive.isTablet ||
                              responsive.isTabletLarge)
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: SizedBox(
                                child: Image.asset(
                                  'assets/unimarblue.jpg',
                                  fit: BoxFit.cover,
                                  height: constraints.maxHeight,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
