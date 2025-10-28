import Foundation
import SwiftUI
import Combine

// MARK: - PostManagerクラス
/// アプリ内で投稿データ（RecruitData）のリストを一元管理し、
/// ファイルへの保存と読み込みを担うシングルトンオブジェクト。
final class PostManager: ObservableObject {
    
    // MARK: - 投稿リストとファイルパス
    
    // 投稿されたRecruitDataのリストを保持し、変更をビューに通知する
    @Published private(set) var posts: [RecruitData] = []
    
    // JSONファイル名
    private static let fileName = "posts.json"
    
    // データを保存するファイルパス（Documentsディレクトリ内）
    private let fileURL: URL
    
    // MARK: - シングルトンと初期化
    
    // PostManagerの唯一のインスタンス
    static let shared = PostManager()
    
    // プライベートイニシャライザでシングルトンを強制
    private init() {
        // DocumentsディレクトリのURLを取得
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // ファイルURLを計算
        self.fileURL = documentsDirectory.appendingPathComponent(Self.fileName)
        
        // 初期化時に保存されている投稿データを読み込む
        loadPosts()
    }
    
    // MARK: - データ操作メソッド
    
    /// 新しい投稿データをリストの先頭に追加する。
    /// - Parameter newPost: 追加するRecruitData。
    func addPost(_ newPost: RecruitData) {
        // 新しい投稿をリストの先頭に追加
        posts.insert(newPost, at: 0)
        // データの永続化
        savePosts()
    }
    
    /// ファイルから保存された投稿リストを読み込む。
    func loadPosts() {
        do {
            // 1. ファイルからデータを読み込む
            let data = try Data(contentsOf: fileURL)
            
            // 2. JSONDecoderを使用してDataを[RecruitData]にデコードする
            let decodedPosts = try JSONDecoder().decode([RecruitData].self, from: data)
            
            // 3. 読み込んだデータをプロパティに設定
            self.posts = decodedPosts
        } catch {
            // ファイルが存在しない、またはデコードに失敗した場合（初回起動時など）
            // 既存の投稿リストは空のままにし、エラーは無視する（新規コメント）
            print("ファイルの読み込みまたはデコードに失敗しました: \(error.localizedDescription)")
            self.posts = []
        }
    }
    
    /// 現在の投稿リストをJSONとしてファイルに保存する。
    func savePosts() {
        do {
            // 1. JSONEncoderを使用して[RecruitData]をDataにエンコードする
            let data = try JSONEncoder().encode(posts)
            
            // 2. ファイルにデータを書き出す
            // 書き込みオプション[.atomic: アトミックに書き込み]
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            // 書き込み失敗時のエラー処理（新規コメント）
            print("ファイルの保存に失敗しました: \(error.localizedDescription)")
        }
    }
}
