class Language {
  final String code;
  final String name;

  const Language({required this.code, required this.name});
}

//有支援的轉換語系
const supportedLanguages = [
  Language(code: 'en', name: '英文'),
  Language(code: 'zh-CN', name: '簡體中文'),
  Language(code: 'zh-TW', name: '繁體中文'),
  Language(code: 'fil', name: '菲律賓語'),
  Language(code: 'vi', name: '越南語'),
  Language(code: 'pt', name: '葡萄牙語'),
  Language(code: 'ko', name: '韓文'),
];

class TranslateResult {
  final String translatedText;
  const TranslateResult({required this.translatedText});
}
