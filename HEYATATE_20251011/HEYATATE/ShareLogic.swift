import SwiftUI
import UniformTypeIdentifiers
import Combine

// MARK: - 定数
// X（Twitter）のアクティビティのみを残し、それ以外のシステム標準アクティビティを除外するリスト
private let EXCLUDED_ACTIVITY_TYPES: [UIActivity.ActivityType] = [
    .message,
    .mail,
    .print,
    .copyToPasteboard,
    .assignToContact,
    .addToReadingList,
    .airDrop,
    .openInIBooks,
    .markupAsPDF,
    .postToFacebook,
    .postToWeibo,
    .postToTencentWeibo,
    .postToFlickr,
    .postToVimeo,
]

// 共有シート（UIActivityViewController）を呼び出すためのラッパー
struct ActivityView: UIViewControllerRepresentable {
    // 共有したいアイテム（UIImageやStringなど）の配列
    let activityItems: [Any]

    // UIActivityViewControllerを作成
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        // Xアクティビティ以外のシステム標準アクティビティを除外
        controller.excludedActivityTypes = EXCLUDED_ACTIVITY_TYPES

        return controller
    }

    // UIViewControllerを更新
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - 共有ロジック
// ビューのレンダリングと共有処理を実行するロジック
@MainActor
final class ShareLogic: ObservableObject {
    // レンダリングされた画像データ
    @Published private(set) var renderedImage: UIImage?
    // 共有シートの表示状態
    @Published var isSharing = false
    // レンダリング中の状態
    @Published private(set) var isRendering = false

    // 共有するテキストデータを一時的に保持するためのプライベート変数
    private var shareText: String?

    /// 任意のViewを画像としてレンダリングし、共有シートを表示する。
    /// - Parameters:
    ///   - view: 画像化する対象のView。
    ///   - textToShare: 共有する文字列。
    func share<Content: View>(view: Content, textToShare: String) {
        // レンダリングが進行中の場合は何もしない
        guard !isRendering else { return }

        // 共有するテキストを保持
        shareText = textToShare

        // レンダリング処理の開始
        isRendering = true

        // 1. ビューを画像としてレンダリング
        let renderer = ImageRenderer(content: view)

        // 2. UIImageを取得
        if let uiImage = renderer.uiImage {
            // レンダリングされた画像を格納
            self.renderedImage = uiImage

            // 3. 共有シート表示フラグをtrueにする
            // レンダリング完了後にシートを表示
            self.isSharing = true
        } else {
            // レンダリング失敗時は画像データをnilにする
            self.renderedImage = nil
            // 失敗時はテキストもリセット
            self.shareText = nil
        }

        // レンダリング処理の完了
        isRendering = false
    }

    /// 共有シートに渡すアイテムの配列を生成する。
    func createActivityItems() -> [Any] {
        var items: [Any] = []
        // 画像がある場合は追加
        if let image = renderedImage {
            items.append(image)
        }
        // テキストがある場合は追加
        if let text = shareText, !text.isEmpty {
            items.append(text)
        }
        return items
    }

    /// 共有シートが閉じられた際に状態をリセットする。
    func didDismissShareSheet() {
        self.isSharing = false
        self.renderedImage = nil
        self.shareText = nil
    }
}
