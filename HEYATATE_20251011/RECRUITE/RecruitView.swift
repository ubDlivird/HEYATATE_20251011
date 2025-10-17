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
    
    // 実施場所
    @State private var selectedAreas: [String] = [] // 選択されたモードを保持するリスト
    private let areaList1: [String] = ["スペース", "Discord","公式Discord"]
    
    // 参加方法
    @State private var selectedJoins: [String] = [] // 選択されたモードを保持するリスト
    private let joinList1: [String] = ["返信(X)", "チャット", "スペース直"]
    
    // VC
    @State private var selectedVCs: [String] = [] // 選択されたモードを保持するリスト
    private var vcList1: [String] = ["あり", "なし", "どちらでも"]
    
    
    @State private var udemaeNow: String = "選択" // 腕前(現在)
    @State private var lateNow: String = "" // レート(現在)
    @State private var udemaeReq: String = "選択" // 腕前(募集)
    @State private var lateReq: String = "" // 実力(募集)
    
    // モード選択
    @State private var selectedModes: [String] = [] // 選択されたモードを保持するリスト
    private let modeList1: [String] = ["#オープン", "#サモラン", "#プラベ"]
    
    // その他タグ
    @State private var selectedTags: [String] = [] // 選択されたタグを保持するリスト
    private let tagList1: [String] = ["#エンジョイ", "#ガチ", "#レート上げ"]
    private let tagList2: [String] = ["#ゆる募", "#クリア重視", "初心者です"]
    private let tagList3: [String] = ["#社会人", "#成人", "#学生", "#🔰歓迎"]
    private let tagList4: [String] = ["#身内のみ", "#FF外歓迎", "#カンスト"]
    private let tagList5: [String] = ["#途中抜け⭕️","#休憩あり","#飲酒中"]
    private let tagList6: [String] = ["#聞き専⭕️", "#聞き専❌","#不穏❌"]
    
    
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
                vcForm() // VC有無
                areaForm() // 実施場所
                joinForm() // 参加方法
                nowRateForm() // 現在レート
                reqRateForm() // 募集レート
                timeForm() // 時間選択
                tagForm() // その他タグ
                
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
            TextField("みんな大好きガチアサリ", text: $recruitTitle)
        }
    }
    
    // モード選択
    @ViewBuilder private func modeForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("モード選択").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: modeList1,selectedTags: $selectedModes
            ).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // 中央
        }
    }
    
    // 実施場所
    @ViewBuilder private func areaForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("実施場所").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: areaList1,selectedTags: $selectedAreas
            )
        }
    }
    
    // 参加方法
    @ViewBuilder private func joinForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("参加方法").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: joinList1,selectedTags: $selectedJoins
            )
        }
    }
    
    // 現在レート
    @ViewBuilder private func nowRateForm() -> some View {
        HStack{
            Picker("ウデマエ", selection: $udemaeNow) {
                Text("S+").tag("S+")
                Text("S").tag("S")
                Text("~A").tag("~A")
                Text("でんせつ").tag("でんせつ")
                Text("たつじん").tag("たつじん")
            }
            TextField("400", text: $lateNow).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
    }
    
    // 募集レート
    @ViewBuilder private func reqRateForm() -> some View {
        HStack{
            Picker("募集条件", selection: $udemaeReq) {
                Text("S+").tag("S+")
                Text("S").tag("S")
                Text("~A").tag("~A")
                Text("でんせつ").tag("でんせつ")
                Text("たつじん").tag("たつじん")
            }
            TextField("400", text: $lateNow).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
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
    // その他タグ
    @ViewBuilder private func vcForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("ボイスチャット").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: vcList1, selectedTags: $selectedVCs
            )
        }
    }
    
    // 時間選択
    @ViewBuilder private func timeForm() -> some View {
        DatePicker(
            "開始時間",
            selection: $startDate,
            displayedComponents: [.hourAndMinute]
        ).datePickerStyle(.compact)
        DatePicker(
            "終了時間",
            selection: $endDate,
            displayedComponents: [.hourAndMinute]
        ).datePickerStyle(.compact)
    }
    
    // その他タグ
    @ViewBuilder private func tagForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("その他タグ").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: tagList1,selectedTags: $selectedTags
            )
            TagSelectionRow(
                rowTags: tagList2,selectedTags: $selectedTags
            )
            TagSelectionRow(
                rowTags: tagList3,selectedTags: $selectedTags
            )
            TagSelectionRow(
                rowTags: tagList4,selectedTags: $selectedTags
            )
            TagSelectionRow(
                rowTags: tagList5,selectedTags: $selectedTags
            )
            TagSelectionRow(
                rowTags: tagList6,selectedTags: $selectedTags
            )
        }
    }
    
    // 1行分の横並びの選択肢を表示し、選択状態をBindingで親と共有するビュー // 新規追加
    // RecruitView構造体の直下に定義を移動
    struct TagSelectionRow: View {
        let rowTags: [String]
        @Binding var selectedTags: [String]
        
        var body: some View {
            HStack(spacing: 10) { // スペーシングを調整
                ForEach(rowTags, id: \.self) { tag in
                    tagButton(for: tag)
                }
                Spacer()
            }
        }
        
        private func tagButton(for tag: String) -> some View {
            HStack {
                Text(tag)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(selectedTags.contains(tag) ? Color.blue : Color(.systemGray5))
            .foregroundColor(selectedTags.contains(tag) ? .white : .primary)
            .cornerRadius(20)
            .contentShape(Rectangle())
            .onTapGesture {
                toggleSelection(for: tag)
            }
        }
        
        private func toggleSelection(for tag: String) {
            if let index = selectedTags.firstIndex(of: tag) {
                selectedTags.remove(at: index)
            } else {
                selectedTags.append(tag)
            }
        }
    }
}

#Preview {
    RecruitView()
}
