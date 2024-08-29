import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:unijobs/src/breakpoints/display_responsive.dart';
import 'package:unijobs/src/components/textformfields/textformfield_component.dart';
import 'package:unijobs/src/theme/theme_color.dart';
import 'package:unijobs/src/validations/mixin_validation.dart';

class RegisterAuthentication extends StatefulWidget {
  const RegisterAuthentication({super.key});

  @override
  State<RegisterAuthentication> createState() => _RegisterAuthenticationState();
}

class _RegisterAuthenticationState extends State<RegisterAuthentication>
    with ValidationMixinClass {
  bool? isChecked = false;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController enterpriseController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/fundo_circulo.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: responsive.isMobile ? double.infinity : 450,
                  child: Form(
                    key: _keyForm,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Crie Sua Conta',
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Preencha os campos abaixo para criar sua conta e começar a usar nossos serviços. É rápido e fácil!',
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
                                    width: 2.0),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/google.png', height: 25),
                                const SizedBox(width: 10),
                                Text(
                                  'Cadastrar com google',
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
                              Expanded(child: Divider()),
                              Text("Ou"),
                              Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextFormFieldComponent(
                            controller: nameController,
                            inputType: TextInputType.text,
                            labelText: 'Nome',
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
                            controller: enterpriseController,
                            inputType: TextInputType.text,
                            labelText: 'Empresa',
                            validator: isNotEmpyt,
                            obscure: false,
                          ),
                          const SizedBox(height: 15),
                          TextFormFieldComponent(
                            controller: passwordController,
                            inputType: TextInputType.text,
                            labelText: 'Senha',
                            validator: isNotEmpyt,
                            obscure: true,
                          ),
                          const SizedBox(height: 15),
                          TextFormFieldComponent(
                            controller: passwordController,
                            inputType: TextInputType.text,
                            labelText: 'Confirmar senha',
                            validator: isNotEmpyt,
                            obscure: true,
                          ),
                          const SizedBox(height: 35),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Campos Validados'),
                                      duration: Duration(milliseconds: 4000),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                backgroundColor: ColorSchemeManagerClass.colorBlack,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
