//
//  RecruitView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/14.
//

import SwiftUI

struct RecruitView: View {
    
    @State private var selectedGame: Int = 1 // ゲーム選択用変数
    @State private var gameMode: Int = 1 // ゲーム選択用変数
    @State private var recruitTitle: String = "" // 募集タイトル
    @State private var startDate = Date() // 時間選択用変数
    @State private var endDate = Date() // 時間選択用変数
    @State private var isModeOpenSelected: Bool = false // オープン選択状態
    @State private var isModeSalmonRunSelected: Bool = false // サモラン選択状態
    @State private var isModePrivateSelected: Bool = false // プラベ選択状態
    
    
    var body: some View {
        VStack{
            Text("プレビュー")
            CreateImageView()
            Text("募集事項")
            Form{
                gameForm() // ゲーム選択
                titleForm() // タイトル記載
                modeForm() // モード選択
                timeForm() // 時間選択
            }
            Spacer()
            Text("Xに投稿、スペースを開く、募集ボタン")
        }
    }
    
    // ゲーム選択
    @ViewBuilder private func gameForm() -> some View {
        Picker("ゲームを選択", selection: $selectedGame) {
            // 選択項目の一覧を生成
            Text("スプラトゥーン3").tag(1)
            Text("ぶどう").tag(2)
            Text("りんご").tag(3)
        }
    }
    
    // モード選択
    @ViewBuilder private func modeForm() -> some View { // 改修箇所
        // モード選択セクション
        // トグルを横並びにするHStack
        VStack{
            Text("モード選択").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            HStack { // 新規追加
                // オープンモード選択トグル
                Toggle("オープン", isOn: $isModeOpenSelected)    .toggleStyle(.button)
                // サモランモード選択トグル
                Toggle("サモラン", isOn: $isModeSalmonRunSelected)
                    .toggleStyle(.button)
                // プラベモード選択トグル
                Toggle("プラベ", isOn: $isModePrivateSelected)
                    .toggleStyle(.button)
            }
        }
    }
    
    /// タイトル記載
    @ViewBuilder private func titleForm() -> some View { // 新規追加
        HStack {
            Text("題名：")
            TextField("募集タイトルを入力してください", text: $recruitTitle)
        }
    }
    
    // 時間選択
    @ViewBuilder private func timeForm() -> some View {
        DatePicker(
            "開始日時",
            selection: $startDate,
            displayedComponents: [.date, .hourAndMinute]
        )
        .datePickerStyle(.compact)
        DatePicker("終了日時", selection: $endDate)
            .datePickerStyle(.compact)
    }
    
}

#Preview {
    RecruitView()
}
