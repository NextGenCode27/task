import 'package:flutter/material.dart';
import 'package:task/core/global/entity/user_entity.dart';
import 'package:task/core/global/widgets/custom_button.dart';
import 'package:task/features/home/presentation/widgets/profile_textfield.dart';

class EditProfileView extends StatefulWidget {
  static route(UserEntity userEntity) => MaterialPageRoute(
      builder: (context) => EditProfileView(
            userEntity: userEntity,
          ));
  const EditProfileView({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 90,
                  ),
                  Positioned(
                    left: 125,
                    top: 125,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.photo,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ProfileTextField(
                    hintText: widget.userEntity.username,
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                    hintText: widget.userEntity.email,
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileTextField(
                    hintText: widget.userEntity.phone,
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
              CustomButton(
                size: size,
                lable: 'Update',
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
