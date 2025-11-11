import 'package:flutter/material.dart';
import '../../../data/models/suggestion_model.dart';
import '../../../data/repositories/suggestion_repository.dart';
import '../../../data/repositories/auth_repository.dart';

enum ViewState { idle, loading, success, error }

class HomeViewModel extends ChangeNotifier {
  final SuggestionRepository _repository = SuggestionRepository();
  final AuthRepository _authRepository = AuthRepository();

  ViewState _state = ViewState.idle;
  List<Suggestion> _suggestions = [];
  String _errorMessage = '';

  ViewState get state => _state;
  List<Suggestion> get suggestions => _suggestions;
  String get errorMessage => _errorMessage;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchSuggestions() async {
    _setState(ViewState.loading);
    try {
      final fetchedSuggestions = await _repository.fetchSuggestions();
      _suggestions = fetchedSuggestions;
      _setState(ViewState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }
  Future<void> logOut() async {
    await _authRepository.signOut();
  }
}
