//
//  RecruitView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/14.
//

import SwiftUI

struct RecruitView: View {
    
    @State private var selectedFruit: Int = 1
    
    var body: some View {
        VStack{
            Text("プレビュー")
            CreateImageView()
            Text("募集事項")
            createRecruitForm()
            Spacer()
            Text("Xに投稿、スペースを開く、募集ボタン")
        }
    }
    
    /// 募集内容のフォームセクションを生成するメソッド
    @ViewBuilder private func createRecruitForm() -> some View {
        // フォーム内にフルーツ選択ピッカーを直接実装
        Form {
            // フルーツ選択用のPickerを生成
            Picker("ゲームを選択", selection: $selectedFruit) {
                // 選択項目の一覧を生成
                Text("みかん").tag(1)
                Text("ぶどう").tag(2)
                Text("りんご").tag(3)
                Text("バナナ").tag(4)
                Text("もも").tag(5)
            }
        }
    }
    
}

#Preview {
    RecruitView()
}
