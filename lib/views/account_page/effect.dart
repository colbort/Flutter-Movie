import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<AccountPageState> buildEffect() {
  return combineEffects(<Object, Effect<AccountPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build:_onBuild,
    Lifecycle.dispose:_onDispose,
    AccountPageAction.action: _onAction,
    AccountPageAction.login: _onLogin,
    AccountPageAction.logout: _onLogout
  });
}

void _onAction(Action action, Context<AccountPageState> ctx) {}

Future _onLogin(Action action, Context<AccountPageState> ctx) async {
  var r = await Navigator.of(ctx.context).pushNamed('loginpage');
  if (r == true) _onInit(action, ctx);
}

Future _onInit(Action action, Context<AccountPageState> ctx) async {
  if (ctx.state.animationController == null) {
    final CustomstfState ticker = ctx.stfState as CustomstfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1500));
  }
  var prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('accountname');
  String avatar = prefs.getString('accountgravatar');
  bool islogin = prefs.getBool('islogin') ?? false;
  ctx.dispatch(AccountPageActionCreator.onInit(name, avatar, islogin));
}

void _onBuild(Action action, Context<AccountPageState> ctx) {
  ctx.state.animationController.forward();
}

void _onDispose(Action action, Context<AccountPageState> ctx) {
  ctx.state.animationController.dispose();
}

void _onLogout(Action action, Context<AccountPageState> ctx) async {
  var q = await ApiHelper.deleteSession();
  if (q) await _onInit(action, ctx);
}
