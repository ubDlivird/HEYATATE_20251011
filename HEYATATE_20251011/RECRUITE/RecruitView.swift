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
    @State private var isOpen: Bool = false // オープン選択状態
    @State private var isSamorun: Bool = false // サモラン選択状態
    @State private var isPrivate: Bool = false // プラベ選択状態
    @State private var people: Int = 4 // 募集人数
    @State private var isSpace: Bool = false // 実施：スペース
    @State private var isDiscord: Bool = false // 実施：ディスコード
    @State private var isGamee: Bool = false // 実施：gamee
    @State private var isAlterna: Bool = false // 実施：オルタナ
    @State private var isRepX: Bool = false // 返信：返信(X)
    @State private var isRepChat: Bool = false // 返信：返信(チャット)
    @State private var isSpDirect: Bool = false // 返信：スペース直
    @State private var vcOK: Bool = false // VCあり
    @State private var vcNG: Bool = false // VCなし
    @State private var vcEither: Bool = false // VCどちらでも
    @State private var samoUdemaeNow: String = "" // サモラン腕前(現在)
    @State private var samoLateNow: Int = 1 // サモランレート(現在)
    @State private var samoUdemaeReq: String = "" // サモラン腕前(募集)
    @State private var samoLateReq: Int = 1 // サモラン実力(募集)
    @State private var openUdemaeNow: String = "" // オープン腕前(現在)
    @State private var openLateNow: Int = 16 // オープンレート(現在)
    @State private var openUdemaeReq: String = "" // オープン腕前(募集)
    @State private var openLateReq: Int = 18 // オープンレート(募集)
    
    
    var body: some View {
        VStack{
            Text("プレビュー")
            CreateImageView()
            Text("募集事項")
            Form{
                gameForm() // ゲーム
                titleForm() // 題名
                modeForm() // モード
                peopleForm() // 人数
                areaForm() // 実施場所
                joinForm() // 参加方法
                nowRateForm() // 現在レート
                reqRateForm() // 募集レート
                timeForm() // 時間選択
                vcForm() // VC有無
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
    
    /// タイトル記載
    @ViewBuilder private func titleForm() -> some View { // 新規追加
        HStack {
            Text("題名：")
            TextField("募集タイトルを入力してください", text: $recruitTitle)
        }
    }
    
    // モード選択
    @ViewBuilder private func modeForm() -> some View {
        VStack{
            Text("モード選択").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            HStack { // 新規追加
                Toggle("オープン", isOn: $isOpen)    .toggleStyle(.button)
                Toggle("サモラン", isOn: $isSamorun)
                    .toggleStyle(.button)
                Toggle("プラベ", isOn: $isPrivate)
                    .toggleStyle(.button)
            }
        }
    }
    
    // 実施場所
    @ViewBuilder private func areaForm() -> some View {
        VStack{
            Text("実施場所").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            VStack{
                HStack {
                    Toggle("スペース", isOn: $isSpace).toggleStyle(.button)
                    Toggle("Discord", isOn: $isDiscord).toggleStyle(.button)
                }
                HStack {
                    Toggle("gamee", isOn: $isGamee).toggleStyle(.button)
                    Toggle("オルタナ", isOn: $isAlterna).toggleStyle(.button)
                }
            }
        }
    }
    
    // 参加方法
    @ViewBuilder private func joinForm() -> some View {
        VStack{
            Text("参加方法").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            HStack {
                Toggle("返信(X)", isOn: $isRepX).toggleStyle(.button)
                Toggle("返信(チャット)", isOn: $isRepChat).toggleStyle(.button)
                Toggle("スペース直", isOn: $isSpDirect).toggleStyle(.button)
                
            }
        }
    }
    
    // 現在レート
    @ViewBuilder private func nowRateForm() -> some View {
        HStack{
            Picker("ウデマエ", selection: $selectedGame) {
                Text("X").tag(1)
                Text("S+").tag(2)
                Text("S").tag(3)
                Text("A").tag(3)
                Text("B").tag(3)
                Text("C").tag(3)
            }
            Picker("レート", selection: $selectedGame) {
                ForEach(16..<30) { number in // 新規追加: 募集人数をリストとして生成
                    Text("\(number) 人").tag(number) // \(number) 人
                }
            }
        }
        
    }
    
    // 募集レート
    @ViewBuilder private func reqRateForm() -> some View {
        VStack{
            Text("募集レート").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            HStack { // 新規追加
                Toggle("A", isOn: $isOpen).toggleStyle(.button)
                Toggle("B", isOn: $isSamorun).toggleStyle(.button)
                Toggle("C", isOn: $isPrivate).toggleStyle(.button)
                Toggle("無制限", isOn: $isPrivate).toggleStyle(.button)
            }
        }
    }
    
    // 募集人数
    @ViewBuilder private func peopleForm() -> some View {
        Picker("募集人数", selection: $people) {
            ForEach(1..<5) { number in // 新規追加: 募集人数をリストとして生成
                Text("\(number) 人").tag(number) // \(number) 人
            }
        }
    }
    
    // VC選択
    @ViewBuilder private func vcForm() -> some View { // 改修箇所
        VStack{
            Text("ボイスチャット").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            HStack {
                Toggle("あり", isOn: $vcOK).toggleStyle(.button)
                Toggle("なし", isOn: $vcNG) .toggleStyle(.button)
                Toggle("どちらでも", isOn: $vcEither).toggleStyle(.button)
            }
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
