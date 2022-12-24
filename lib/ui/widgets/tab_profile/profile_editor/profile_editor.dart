import 'package:digdes_ui/ui/widgets/tab_profile/profile_editor/profile_editor_vm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

const List<String> genderList = <String>['Male', 'Female', 'Prefer not to say'];

class ProfileEditor extends StatelessWidget {
  const ProfileEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ProfileEditorViewModel>();
    var maskFormatter = MaskTextInputFormatter(
        mask: '+# (###) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            onPressed: viewModel.confirm,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: (viewModel.user != null)
          ? SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title:
                                const Text('How do you want to choose photo?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  viewModel.pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('From Gallery'),
                              ),
                              TextButton(
                                onPressed: () {
                                  viewModel.pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('By Camera'),
                              ),
                            ],
                          ),
                        ),
                        child: Ink.image(
                          image: viewModel.avatar != null
                              ? viewModel.avatar!.image
                              : const AssetImage("assets/images/noavatar.png"),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
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
                              controller: viewModel.username,
                              decoration: const InputDecoration(
                                hintText: 'Enter your username',
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
                              controller: viewModel.firstName,
                              decoration: const InputDecoration(
                                hintText: 'Enter your first name',
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
                              controller: viewModel.lastName,
                              decoration: const InputDecoration(
                                hintText: 'Enter your last name',
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
                              controller: viewModel.bio,
                              decoration: const InputDecoration(
                                hintText: 'Enter bio',
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
                        const Expanded(flex: 1, child: Text("Phone")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: viewModel.phone,
                              keyboardType: TextInputType.number,
                              inputFormatters: [maskFormatter],
                              decoration: const InputDecoration(
                                hintText: 'Enter your phone number',
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(flex: 1, child: Text("Email")),
                        Expanded(
                          flex: 2,
                          child: TextField(
                              controller: viewModel.email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
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
                      children: const [
                        Expanded(flex: 1, child: Text("Private account")),
                        Expanded(
                          flex: 2,
                          child: Switcher(),
                        )
                      ],
                    ),
                  ]),
            ))
          : null,
    );
  }

  static Widget create(BuildContext bc) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ProfileEditorViewModel(context: bc),
        child: const ProfileEditor());
  }
}

class DropdownButtonGender extends StatefulWidget {
  const DropdownButtonGender({Key? key}) : super(key: key);

  @override
  State<DropdownButtonGender> createState() => _DropdownButtonGenderState();
}

class _DropdownButtonGenderState extends State<DropdownButtonGender> {
  String dropdownValue = genderList.first;

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<ProfileEditorViewModel>();

    return DropdownButton<String>(
      value: dropdownValue,
      isExpanded: true,
      icon: const Icon(Icons.arrow_downward_outlined),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          viewModel.user!.gender = value;
          // TODO : is not selected without click
        });
      },
      items: genderList.map<DropdownMenuItem<String>>((String value) {
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
    var viewModel = context.watch<ProfileEditorViewModel>();
    var initialDate = DateTime.now().year - 18;

    String formattedBirthDate = "";
    if (viewModel.user != null) {
      var time = viewModel.user!.birthDate!;
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
              viewModel.user!.birthDate = pickedDate.toUtc();
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
    var viewModel = context.watch<ProfileEditorViewModel>();

    return Switch(
      value: viewModel.user!.isPrivate!,
      onChanged: (bool value) {
        setState(() {
          isPrivate = value;
          viewModel.user!.isPrivate = value;
        });
      },
    );
  }
}
