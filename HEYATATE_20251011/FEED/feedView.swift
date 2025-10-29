//
//  feedView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/26.
//

import SwiftUI
import UIKit

// MARK: - フィードビュー
struct feedView: View {
 
    @ObservedObject var postManager = PostManager.shared
    
    // MARK: - View Body
    var body: some View {
        NavigationView {
            List {
                // 投稿リストをループして表示
                ForEach(postManager.posts, id: \.title) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        // 投稿情報の概要表示
                        postSummarySection(post: post)
                        // コメントの表示
                        postCommentSection(post: post)
                        // 画像の表示
                        postImageSection(post: post)

                    }
                    .padding(.vertical, 5)
                }
                // 投稿がない場合のメッセージ
                if postManager.posts.isEmpty {
                    Text("まだ投稿がありません。「募集」タブから作成してください。")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("フィード")
        }
        // 画面表示時に投稿データを読み込み
        .onAppear {
            postManager.loadPosts()
        }
    }
    
    // MARK: - 1. 画像の表示
    /// 投稿に添付された画像を表示する
    @ViewBuilder private func postImageSection(post: RecruitData) -> some View {
        if let uiImage = loadImage(fileName: post.imageFileName) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(16/9, contentMode: .fit)
                .cornerRadius(10)
        } else {
            // 画像がない場合のプレースホルダ
            Text("画像が見つかりません。ファイル名: \(post.imageFileName)")
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - 2. コメントの表示
    /// 投稿のコメントを表示する
    private func postCommentSection(post: RecruitData) -> some View {
        Text(post.comment)
            .font(.body)
    }
    
    // MARK: - 3. 投稿情報の概要表示
    /// 投稿のゲーム名とモードの概要を表示する
    private func postSummarySection(post: RecruitData) -> some View {
        HStack {
            Text("ゲーム: \(post.game)")
            Spacer()
            Text("モード: \(post.modes.joined(separator: ", "))")
        }
        .font(.caption)
        .foregroundColor(.gray)
    }
    
    // MARK: - 画像読み込みメソッド
    
    /// Documentsディレクトリから指定されたファイル名の画像を読み込む
    private func loadImage(fileName: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("画像ファイルの読み込みに失敗しました: \(error.localizedDescription)")
            return nil
        }
    }
}


#Preview {
    feedView()
}
