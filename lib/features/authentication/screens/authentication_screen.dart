import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imag_in/core/utils/assets.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/core/utils/extensions/context_extensions.dart';
import 'package:imag_in/core/widgets/shadow_box.dart';
import 'package:imag_in/features/authentication/services/auth_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController(text: 'eve.holt@reqres.in');
  final _passwordController = TextEditingController(text: 'cityslicka');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authService, _) {
        final isLoading = authService.state == ConsumerState.loading;

        return Scaffold(
          backgroundColor: Colors.teal,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              spacing: 16,
              children: [
                Expanded(
                  flex: 3,
                  child: ExtendedImage.asset(Assets.iconTransparent),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    ShadowBox(
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.teal,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    ShadowBox(
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.teal,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    if (authService.state == ConsumerState.error)
                      Text(
                        authService.errorMessage ?? 'Something went wrong',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.red.shade200,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ShadowBox(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: isLoading
                            ? null
                            : () => authService.login(
                                _emailController.text.trim(),
                                _passwordController.text,
                              ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: isLoading
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.threeArchedCircle(
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.rightToBracket,
                                      size: 20,
                                    ),
                                    Text(
                                      'Log In',
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                          ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
