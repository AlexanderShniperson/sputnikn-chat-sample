import 'package:auto_route/auto_route.dart';
import 'package:chat_client_repository/chat_client_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:sputnikn_chatsample/app_router/app_router.dart';
import 'package:sputnikn_chatsample/core/core.dart';
import 'package:sputnikn_chatsample/pages/chat_login/bloc/chat_login_bloc.dart';

@RoutePage()
class ChatLoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const ChatLoginScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ChatLoginScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ChatLoginBloc>(
      create: (context) => ChatLoginBloc(
        chatClientRepository: context.read<ChatClientRepository>(),
      ),
      child: this,
    );
  }
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  final _loginController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  void initState() {
    _loginController.text = context.read<ChatLoginBloc>().state.login;
    _passwordController.text = context.read<ChatLoginBloc>().state.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChatLoaderScope(
      child: MultiBlocListener(
        listeners: [
          BlocListener<ChatLoginBloc, ChatLoginState>(
            listenWhen: (prev, next) =>
                prev.loadingStatus != next.loadingStatus,
            listener: (context, state) {
              ChatLoaderScope.of(context).changeLoaderVisibility(
                state.loadingStatus == ChatLoginLoadingStatus.loading,
              );
            },
          ),
          BlocListener<ChatLoginBloc, ChatLoginState>(
            listenWhen: (prev, next) => prev.authStatus != next.authStatus,
            listener: (_, state) {
              if (state.authStatus == ChatLoginAuthStatus.success) {
                AutoRouter.of(context).replace(
                  const HomeRoute(),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: TapResetFocusArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Svg(Assets.bgSigInPath),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.logo(width: 100, height: 100),
                      const SizedBox(height: 8),
                      _appLabel(),
                      const SizedBox(height: 24),
                      _loginField(),
                      const SizedBox(height: 24),
                      _passwordField(),
                      const SizedBox(height: 40),
                      _btnSignIn(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appLabel() {
    return RichText(
      text: const TextSpan(
        text: 'Sputnik',
        style: TextStyle(
          fontSize: 36,
          color: Palette.color3,
        ),
        children: [
          TextSpan(
            text: '-N',
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.chat_login_field_login,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _loginController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Palette.color1,
            hintText: AppLocalizations.of(context)!.chat_login_field_login,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.chat_login_field_password,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Palette.color1,
            hintText: AppLocalizations.of(context)!.chat_login_field_password,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _btnSignIn() {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size(150, 50),
      ),
      onPressed: () {
        context.read<ChatLoginBloc>().add(SignInSubmitted());
      },
      child: Text(AppLocalizations.of(context)!.chat_login_btn_auth),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
