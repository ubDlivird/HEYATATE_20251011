//
//  feedView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/26.
//

import SwiftUI
import UIKit // UIImageを使用するため

// MARK: - フィードビュー
/// 投稿されたRecruitDataのリストを表示するビュー
struct feedView: View {
 
    // [新規追加] 投稿管理マネージャをObserviedObjectとして注入
    @ObservedObject var postManager = PostManager.shared
    
    var body: some View {
        NavigationView { // フィードなのでNavigationViewを追加
            List {
                // [新規追加] PostManagerが持つ投稿リストをループして表示
                ForEach(postManager.posts, id: \.title) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        // 1. 画像の表示
                        // ファイル名から画像を読み込むヘルパーメソッドを使用
                        if let uiImage = loadImage(fileName: post.imageFileName) {
                            // UIImageをSwiftUIのImageとして表示
                            Image(uiImage: uiImage)
                                .resizable() // コーディングのコメント: 画像をリサイズ可能に
                                .aspectRatio(16/9, contentMode: .fit) // コーディングのコメント: アスペクト比16:9を維持
                                .cornerRadius(10) // コーディングのコメント: 角の丸み
                        } else {
                            // 画像がない、または読み込みに失敗した場合のプレースホルダ
                            Text("画像が見つかりません。ファイル名: \(post.imageFileName)") // コーディングのコメント: 画像なしメッセージ
                                .foregroundColor(.secondary) // コーディングのコメント: 文字色を薄く
                        }
                        
                        // 2. コメントの表示
                        Text(post.comment) // コーディングのコメント: 投稿コメントを表示
                            .font(.body) // コーディングのコメント: 本文フォント
                        
                        // 3. 投稿情報の概要表示
                        HStack {
                            Text("ゲーム: \(post.game)") // コーディングのコメント: ゲーム名を表示
                            Spacer() // コーディングのコメント: スペースで左右に分離
                            Text("モード: \(post.modes.joined(separator: ", "))") // コーディングのコメント: モードを表示
                        }
                        .font(.caption) // コーディングのコメント: キャプションフォント
                        .foregroundColor(.gray) // コーディングのコメント: 灰色文字
                    }
                    .padding(.vertical, 5) // コーディングのコメント: 縦の余白を追加
                }
                // [新規追加] 投稿がない場合のメッセージ
                if postManager.posts.isEmpty {
                    Text("まだ投稿がありません。「募集」タブから作成してください。") // コーディングのコメント: 投稿なしメッセージ
                        .foregroundColor(.secondary) // コーディングのコメント: 文字色を薄く
                }
            }
            .navigationTitle("フィード") // コーディングのコメント: ナビゲーションタイトル設定
        }
        // [新規追加] ビューが表示されたときに保存データを読み込む
        .onAppear {
            postManager.loadPosts() // コーディングのコメント: 画面表示時に投稿データを読み込み
        }
    }
    
    // MARK: - 画像読み込みメソッド
    
    /// Documentsディレクトリから指定されたファイル名の画像を読み込む
    /// - Parameter fileName: 読み込む画像ファイル名
    /// - Returns: 読み込まれたUIImage、または失敗した場合はnil
    private func loadImage(fileName: String) -> UIImage? {
        // [新規] DocumentsディレクトリのURLを取得
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documentsディレクトリの取得に失敗しました。") // コーディングのコメント: Documentsディレクトリ取得失敗
            return nil
        }
        
        // [新規] 画像ファイルの完全なURL
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            // [新規] ファイルからデータを読み込む
            let data = try Data(contentsOf: fileURL) // コーディングのコメント: ファイルデータを読み込み
            // [新規] DataからUIImageを作成
            return UIImage(data: data) // コーディングのコメント: UIImageとして作成
        } catch {
            // [新規] ファイル読み込み失敗時のエラー処理
            print("画像ファイルの読み込みに失敗しました: \(error.localizedDescription)") // コーディングのコメント: ファイル読み込み失敗
            return nil
        }
    }
}


#Preview {
    // プレビュー用にPostManagerのシングルトンを環境オブジェクトとして提供
    feedView()
}
