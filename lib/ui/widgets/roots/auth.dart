import 'package:digdes_ui/ui/widgets/roots/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                flex: 5,
                child: Container(),
              ),
              TextField(
                controller: viewModel.loginText,
                decoration: const InputDecoration(
                    hintText: "Enter Login",
                    icon: Icon(Icons.account_circle_outlined)),
              ),
              TextField(
                controller: viewModel.passwordText,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Enter Password", icon: Icon(Icons.key)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: viewModel.checkFields() ? viewModel.login : null,
                  child: const Text("Login")),
              if (viewModel.state.isLoading) const CircularProgressIndicator(),
              if (viewModel.state.errorText != null)
                Text(viewModel.state.errorText!),
              Expanded(flex: 5, child: Container()),
              Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: viewModel.toSignUp,
                    child: const Text("Create new account")),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<AuthViewModel>(
        create: (context) => AuthViewModel(context: context),
        child: const Auth(),
      );
}
