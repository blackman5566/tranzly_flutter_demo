import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

import '../Model/TranslateResult.dart';

class TranslateRepository {
  Future<TranslateResult> translate({required String text, required String target, String source = 'auto',}) async {
    // 避免非法輸入
    if (text.trim().isEmpty) {
      throw Exception("請輸入要翻譯的文字");
    }

    final encodedText = Uri.encodeComponent(text);
    //source 設為 auto ，給 google 去判別來源語系
    final url =
        'https://translate.googleapis.com/translate_a/single?client=gtx&sl=$source&tl=$target&dt=t&q=$encodedText';

    // 隨機 UA 模擬瀏覽器
    final userAgents = [
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8',
      'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko',
      'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Mobile Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0'
    ];
    final randomUA = userAgents[Random().nextInt(userAgents.length)];

    //發送 api
    final response = await http.get(
      Uri.parse(url),
      headers: {'User-Agent': randomUA},
    );

    if (response.statusCode != 200) {
      throw Exception('翻譯請求失敗：${response.statusCode}');
    }

    //爬資料
    final List<dynamic> json = jsonDecode(response.body);
    final translatedSegments = json.first as List<dynamic>;

    final buffer = StringBuffer();
    for (final segment in translatedSegments) {
      if (segment is List && segment.isNotEmpty && segment.first is String) {
        buffer.write(segment.first);
      }
    }

    return TranslateResult(translatedText: buffer.toString());
  }
}
