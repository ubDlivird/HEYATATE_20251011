import SwiftUI
import UniformTypeIdentifiers
import Combine
import UIKit // UIImage, UIActivityViewControllerのために必要

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

// MARK: - ActivityView
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
// ビューのレンダリングと共有処理、およびデータ永続化（画像・投稿データ）を実行するロジック
@MainActor
final class ShareLogic: ObservableObject {
    // レンダリングされた画像データ
    @Published private(set) var renderedImage: UIImage?
    // 共有シートの表示状態
    @Published var isSharing = false
    // レンダリング中の状態
    @Published private(set) var isRendering = false
    
    // 画像ファイル名を保持するプロパティ
    @Published private(set) var savedImageFileName: String?

    // 共有するテキストデータを一時的に保持するためのプライベート変数
    private var shareText: String?

    // MARK: - メインアクション

    /// 任意のViewを画像としてレンダリングし、ファイルに保存、PostManagerにデータを永続化し、共有シートを表示する。
    /// - Parameters:
    ///   - view: 画像化する対象のView。
    ///   - recruitData: 投稿するデータ。
    ///   - postManager: データを永続化するためのマネージャ。
    func share<Content: View>(view: Content, recruitData: RecruitData, postManager: PostManager) { // 修正: 引数にRecruitDataとPostManagerを追加
        // コーディングのコメント: レンダリングが進行中の場合は何もしない
        guard !isRendering else { return }

        // 共有するテキストを保持
        shareText = recruitData.comment // コーディングのコメント: 投稿コメントをテキストとして保持

        // コーディングのコメント: レンダリング処理の開始
        isRendering = true

        // 1. ビューを画像としてレンダリング
        let renderer = ImageRenderer(content: view)

        // 2. UIImageを取得
        if let uiImage = renderer.uiImage {
            // コーディングのコメント: レンダリングされた画像を格納
            self.renderedImage = uiImage
            
            // コーディングのコメント: 画像をファイルに保存
            self.savedImageFileName = saveImageToFile(image: uiImage)

            // 3. データの永続化
            if let fileName = self.savedImageFileName {
                var newPost = recruitData // コーディングのコメント: 値型のRecruitDataをコピー
                newPost.imageFileName = fileName // コーディングのコメント: 画像ファイル名を設定
                
                // PostManagerに投稿データを追加し、永続化を依頼
                postManager.addPost(newPost) // コーディングのコメント: PostManagerに投稿データを追加し永続化
            }

            // 4. 共有シート表示フラグをtrueにする
            // コーディングのコメント: レンダリング完了後にシートを表示
            self.isSharing = true
        } else {
            // コーディングのコメント: レンダリング失敗時は画像データをnilにする
            self.renderedImage = nil
            // コーディングのコメント: 失敗時はテキストもリセット
            self.shareText = nil
            // コーディングのコメント: 失敗時はファイル名もリセット
            self.savedImageFileName = nil
        }

        // コーディングのコメント: レンダリング処理の完了
        isRendering = false
    }

    /// 共有シートに渡すアイテムの配列を生成する。
    func createActivityItems() -> [Any] {
        var items: [Any] = []
        // コーディングのコメント: 画像がある場合は追加
        if let image = renderedImage {
            items.append(image)
        }
        // コーディングのコメント: テキストがある場合は追加
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
        self.savedImageFileName = nil // コーディングのコメント: 共有完了時にファイル名もリセット
    }
    
    // MARK: - 画像のファイル保存
    
    /// UIImageをPNGデータとしてDocumentsディレクトリに保存し、ファイル名を返す。
    /// - Parameter image: 保存するUIImage。
    /// - Returns: 保存された画像ファイル名。失敗した場合はnil。
    private func saveImageToFile(image: UIImage) -> String? {
        // コーディングのコメント: UUIDに基づいた一意なファイル名を生成
        let fileName = "\(UUID().uuidString).png"
        
        // コーディングのコメント: DocumentsディレクトリのURLを取得
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documentsディレクトリの取得に失敗しました。") // コーディングのコメント: Documentsディレクトリの取得失敗
            return nil
        }
        
        // コーディングのコメント: 画像ファイルの完全なURL
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        // コーディングのコメント: UIImageをPNGデータに変換
        guard let data = image.pngData() else {
            print("UIImageをPNGデータに変換できませんでした。") // コーディングのコメント: PNGデータ変換失敗
            return nil
        }
        
        do {
            // コーディングのコメント: ファイルに書き込み
            try data.write(to: fileURL)
            // コーディングのコメント: 成功したファイル名を返す
            return fileName
        } catch {
            print("画像ファイルの書き込みに失敗しました: \(error.localizedDescription)") // コーディングのコメント: ファイル書き込み失敗
            return nil
        }
    }
}
