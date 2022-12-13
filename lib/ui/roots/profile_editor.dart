import 'package:digdes_ui/data/services/api_service.dart';
import 'package:digdes_ui/domain/models/user.dart';
import 'package:digdes_ui/internal/config/app_config.dart';
import 'package:digdes_ui/internal/config/shared_preferences.dart';
import 'package:digdes_ui/internal/config/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

const List<String> list = <String>['Male', 'Female', 'Prefer not to say'];

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  _ViewModel({required this.context}) {
    asyncInit();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Map<String, String>? headers;

  void asyncInit() async {
    var token = TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
    user = await SharedPrefs.getStoredUser();
  }
}

// TODO : try make it stateful
class ProfileEditor extends StatelessWidget {
  const ProfileEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    var username = TextEditingController();
    var firstName = TextEditingController();
    var lastName = TextEditingController();
    var bio = TextEditingController();
    var gender = TextEditingController();
    var phone = TextEditingController();
    var email = TextEditingController();
    var maskFormatter = MaskTextInputFormatter(
        mask: '+# (###) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    ImageProvider img = const AssetImage("assets/images/noavatar.png");
    final apiService = ApiService();

    if (viewModel.user != null && viewModel.headers != null) {
      username.text = viewModel.user!.username;
      firstName.text = viewModel.user!.firstName;
      lastName.text = viewModel.user!.lastName;
      bio.text = viewModel.user!.bio;
      gender.text = viewModel.user!.gender;
      phone.text = viewModel.user!.phone;
      email.text = viewModel.user!.email;

      if (viewModel.user!.avatarLink != null) {
        img = NetworkImage("$baseUrl2 ${viewModel.user!.avatarLink}",
            headers: viewModel.headers);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            onPressed: () {
              apiService.editProfile(
                  username.text,
                  firstName.text,
                  lastName.text,
                  bio.text,
                  gender.text,
                  phone.text,
                  email.text,
                  // FIXME
                  DateTime(2017, 9, 7, 17).toUtc(),
                  true);
            },
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: (viewModel.user != null)
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const CircleBorder(),
                      child: InkWell(
                        // TODO: edit avatar method
                        onTap: () {},
                        child: Ink.image(
                          image: img,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text("Username")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: username,
                              decoration: InputDecoration(
                                hintText: viewModel.user!.username,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text("First Name")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: firstName,
                              decoration: InputDecoration(
                                hintText: viewModel.user!.firstName,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text("Last Name")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: lastName,
                              decoration: InputDecoration(
                                hintText: viewModel.user!.lastName,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text("Bio")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: bio,
                              decoration: InputDecoration(
                                hintText: viewModel.user!.bio,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(flex: 1, child: Text("Gender")),
                        Expanded(flex: 2, child: DropdownButtonGender())
                      ],
                    ),
                    Row(
                      children: [
                        // TODO : add mask phone
                        const Expanded(flex: 1, child: Text("Phone")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: phone,
                              decoration: InputDecoration(
                                hintText: viewModel.user!.phone,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        // TODO : add mask phone
                        const Expanded(flex: 1, child: Text("Phone")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            inputFormatters: [maskFormatter],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        // TODO : add mask email
                        const Expanded(flex: 1, child: Text("Email")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: viewModel.user!.email,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(flex: 1, child: Text("Birth Date")),
                        Expanded(
                          flex: 2,
                          child: DatePicker(),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Expanded(flex: 1, child: Text("Private account")),
                        Expanded(
                          flex: 2,
                          child: Switcher(),
                        )
                      ],
                    ),
                  ]),
            )
          : null,
    );
  }

  static Widget create() {
    return ChangeNotifierProvider(
        create: (BuildContext context) => _ViewModel(context: context),
        child: const ProfileEditor());
  }
}

class DropdownButtonGender extends StatefulWidget {
  const DropdownButtonGender({Key? key}) : super(key: key);

  @override
  State<DropdownButtonGender> createState() => _DropdownButtonGenderState();
}

class _DropdownButtonGenderState extends State<DropdownButtonGender> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // TODO : adapt to common design
      value: dropdownValue,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    var initialDate = DateTime.now().year - 18;

    String formattedBirthDate = "";
    if (viewModel.user != null) {
      var time = DateFormat("yyyy-MM-ddTHH:mm:ss")
          .parse(viewModel.user!.birthDate, true);
      formattedBirthDate = DateFormat("dd/MM/yyyy").format(time);
    }
    dateController.text = formattedBirthDate;

    return TextField(
        controller: dateController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(initialDate),
              firstDate: DateTime(1901),
              lastDate: DateTime(2101));
          if (pickedDate != null) {
            String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
            setState(() {
              dateController.text = formattedDate;
            });
          } else {}
        });
  }
}

class Switcher extends StatefulWidget {
  const Switcher({Key? key}) : super(key: key);

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool isPrivate = true;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    return Switch(
      value: viewModel.user!.isPrivate == 1,
      onChanged: (bool value) {
        setState(() {
          isPrivate = value;
        });
      },
    );
  }
}
