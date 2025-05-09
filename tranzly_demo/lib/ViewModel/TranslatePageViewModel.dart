import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Model/TranslateResult.dart';
import '../Repository/TranslateRepository.dart';

//設定翻譯 Provider
final translateViewModelProvider = NotifierProvider<TranslateViewModel, TranslateState>(() {
  return TranslateViewModel();
});

//設定 State
class TranslateState {
  TranslateState({this.translateResult, required this.translatedLanguage,required this.isLoading});

  final TranslateResult? translateResult;
  final Language? translatedLanguage;
  final bool isLoading;

  TranslateState copyWith({TranslateResult? translateResult, Language? translatedLanguage, bool? isLoading}) {
    return TranslateState(translateResult: translateResult ?? this.translateResult, translatedLanguage: translatedLanguage ?? this.translatedLanguage,  isLoading: isLoading ?? this.isLoading);
  }
}

// viewModel 相關設定
class TranslateViewModel extends Notifier<TranslateState> {
  final _repo = TranslateRepository();

  static TranslateState initial() => TranslateState(
    translateResult: null,
    translatedLanguage: supportedLanguages.first,
    isLoading: false,
  );

  //預設目標語言是英文
  @override
  TranslateState build() => TranslateViewModel.initial();

  //呼叫翻譯 api
  Future<void> translate(String input, String targetLang) async {
    updateState(loading: true);
    try {
      final result = await _repo.translate(text: input, target: targetLang);
      updateState(result: result, loading: false);
    } catch (e, st) {
      final msg = _parseError(e);
      updateState(result: TranslateResult(translatedText: msg), loading: false);
    }
  }

  //更新狀態
  void updateState({TranslateResult? result, bool? loading, Language? lang}) {
    state = state.copyWith(
      translateResult: result,
      isLoading: loading,
      translatedLanguage: lang,
    );
  }

  String _parseError(Object e) {
    return e.toString().replaceFirst('Exception: ', '');
  }
}