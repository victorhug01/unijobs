import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:unijobs/src/breakpoints/display_responsive.dart';
import 'package:unijobs/src/components/textformfields/textformfield_component.dart';
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
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: responsive.isMobile ? double.infinity : 450,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _keyForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bem-vindo(a) à Unijobs',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Sua nova plataforma de contratação exclusiva de alunos da unimar.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: ColorSchemeManagerClass.colorBlack,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/google.png', height: 25),
                                const SizedBox(width: 10),
                                Text(
                                  'Login com google',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: ColorSchemeManagerClass.colorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(),
                              ),
                              Text("Ou"),
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
                                EmailValidator.validate(value.toString())
                                    ? null
                                    : "Email inválido",
                          ),
                          const SizedBox(height: 15),
                          TextFormFieldComponent(
                            controller: passwordController,
                            inputType: TextInputType.text,
                            labelText: 'Senha',
                            validator: isNotEmpyt,
                            obscure: true,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor:
                                        ColorSchemeManagerClass.colorBlack,
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
                                    color: ColorSchemeManagerClass.colorBlack,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  const snackBar = SnackBar(
                                    content: Text('Campos Validados'),
                                    duration: Duration(milliseconds: 4000),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não tem uma conta?'),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(2),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('registerAuthetication');
                                },
                                child: const Text(
                                  'clique aqui para criar uma conta',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
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
                ),
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
                      fit: BoxFit.fill,
                      height: double.infinity,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
