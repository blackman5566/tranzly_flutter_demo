# 翻譯小工具（Flutter 版）

本專頁是一個簡單的中翻外翻譯應用，支援多語言切換與即時翻譯，實作上使用 Flutter + Riverpod 架構完成。  
你可以自由輸入中文內容並選擇目標語言，點擊按鈕即可立即翻譯。

---

## 📌 功能特色

- ✅ 中文 ➔ 多語言翻譯（支援英文、日文、韓文、越南文、葡萄牙文等）
- ✅ 不需 API 金鑰、不需申請 Google 帳號
- ✅ 使用 Flutter 開發，跨平臺快速部署
- ✅ 使用 Riverpod 架構實現狀態管理與資料繫導
- ✅ UI 使用 Material Design 風格
- ✅ 自動載入翻譯結果 + loading 動畫

---

## 🌍 翻譯 API 說明

本功能並**非使用 Google 官方 Cloud Translation API**，而是：

> 使用 Telegram 採用的 Web-based Google Translate API  
> (類似爬蟲方式呼叫 https://translate.googleapis.com/...)

此方式目前：
- ✅ **無需認證、無需 API 金鑰**
- ✅ **免費、不限流量（但可能有風險）**
- ✅ 適合**試作原型階段**或對即時性與低成本需求較高的場景使用

> ⚠️ 僅建議開發者／研究用途，不建議用於正式商業產品上線。

---

## 💻 技術架構

| 層級 | 技術 |
|--------|--------|
| 語言 | Dart |
| 框架 | Flutter |
| 架構模式 | MVVM + Riverpod |
| 狀態管理 | `NotifierProvider` (Riverpod 2.x) |
| 網路請求 | `http` 套件 |
| 翻譯 API | `translate.googleapis.com` (Web 模擬呼叫) |

---

## 🗂 專案結構簡述

```bash
lib/
├── model/                # 資料模型（翻譯結果、語言列表）
├── repository/           # API 請求封裝
├── viewmodel/            # Riverpod ViewModel 控制器
├── view/                 # 畫面與使用者介面
└── main.dart             # 入口
```

---

## 📷 畫面預覽

<img src="https://your-url.gif](https://github.com/blackman5566/tranzly_flutter_demo/blob/main/demo.gif" width="300" />
## 📄 License

MIT License.  
本專頁為學習用途開源，歡迎參考或延伸開發。
