//
//  RecruitView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/14.
//

import SwiftUI

// 子ビューに受け渡し用
struct RecruitData{
    var game: String = "" // ゲーム選択を保持
    var areas: [String] = [] // 実施場所を保持
    var title: String = "" // 募集タイトルを保持
    var startDate = Date() // 開始時間を保持
    var endDate = Date() // 終了時間を保持
    var people: Int = 0 // 募集人数を保持
    var joins: [String] = [] // 参加方法を保持
    var vcs: [String] = [] // VC選択を保持
    var nowRank: String = "" // 現在ランクを保持
    var nowRate: String = "" // 現在レートを保持
    var reqRank: String = "" // 募集ランクを保持
    var reqRate: String = "" // 募集レートを保持
    var modes: [String] = [] // 選択されたモードを保持
    var tags: [String] = [] // 選択されたタグを保持
}

struct RecruitView: View {
    
    // 子ビューに受け渡し用
    @State private var recruitData = RecruitData()
    
    // 実施場所
    private let areaList1: [String] = ["スペース", "Discord","公式Discord"]
    // 参加方法
    private let joinList1: [String] = ["返信(X)", "チャット", "スペース直"]
    // VC
    private var vcList1: [String] = ["あり", "なし", "どちらでも"]
    // モード選択
    private let modeList1: [String] = ["#オープン", "#サモラン", "#プラベ"]
    // その他タグ
    private let tagList1: [String] = ["#エンジョイ", "#ガチ", "#レート上げ"]
    private let tagList2: [String] = ["#ゆる募", "#クリア重視", "初心者です"]
    private let tagList3: [String] = ["#社会人", "#成人", "#学生", "#🔰歓迎"]
    private let tagList4: [String] = ["#身内のみ", "#FF外歓迎", "#カンスト"]
    private let tagList5: [String] = ["#途中抜け⭕️","#休憩あり","#飲酒中"]
    private let tagList6: [String] = ["#聞き専⭕️", "#聞き専❌","#不穏❌"]
    
    
    var body: some View {
        VStack{
            Text("プレビュー")
            ImageView() // プレビュー
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
    
    // テンプレートプレビュー
    private func ImageView() -> some View{
        CreateImageView(recruitData : $recruitData)
    }
    
    // ゲーム選択
    @ViewBuilder private func gameForm() -> some View {
        Picker("ゲームを選択", selection: $recruitData.game) {
            // 選択項目の一覧を生成
            Text("スプラトゥーン3").tag("スプラトゥーン3")
            Text("ぶどう").tag("ぶどう")
            Text("りんご").tag("りんご")
        }
    }
    
    // タイトル記載
    @ViewBuilder private func titleForm() -> some View { // タイトル入力フォームを構築
        HStack {
            Text("題名：") // 題名のラベル
            TextField("サモラン募集伝説400から", text: $recruitData.title)
                .onChange(of: recruitData.title) {
                    // 文字数制限を超過した場合の処理
                    if recruitData.title.count > 15 { // 文字数制限
                        // 文字列を先頭から定数で切り詰める
                        recruitData.title = String(recruitData.title.prefix(15))
                    }
                }
        }
    }
    
    // モード選択
    @ViewBuilder private func modeForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("現在レート").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: modeList1,selectedTags: $recruitData.modes
            ).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // 中央
        }
    }
    
    // 実施場所
    @ViewBuilder private func areaForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("募集レート").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: areaList1,selectedTags: $recruitData.areas
            )
        }
    }
    
    // 参加方法
    @ViewBuilder private func joinForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("参加方法").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: joinList1,selectedTags: $recruitData.joins
            )
        }
    }
    
    // 現在レート
    @ViewBuilder private func nowRateForm() -> some View {
        HStack{
            Picker("ウデマエ", selection: $recruitData.nowRank) {
                Text("S+").tag("S+")
                Text("S").tag("S")
                Text("~A").tag("~A")
                Text("伝説").tag("伝説")
                Text("達人").tag("達人")
            }
            TextField("400", text: $recruitData.nowRate).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
    }
    
    // 募集レート
    @ViewBuilder private func reqRateForm() -> some View {
        HStack{
            Picker("募集条件", selection: $recruitData.reqRank) {
                Text("S+").tag("S+")
                Text("S").tag("S")
                Text("~A").tag("~A")
                Text("伝説").tag("伝説")
                Text("達人").tag("達人")
            }
            TextField("400", text: $recruitData.reqRate).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
        }
    }
    
    // 募集人数
    @ViewBuilder private func peopleForm() -> some View {
        Picker("募集人数", selection: $recruitData.people) {
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
                rowTags: vcList1, selectedTags: $recruitData.vcs
            )
        }
    }
    
    // 時間選択
    @ViewBuilder private func timeForm() -> some View {
        DatePicker(
            "開始時間",
            selection: $recruitData.startDate,
            displayedComponents: [.hourAndMinute]
        ).datePickerStyle(.compact)
        DatePicker(
            "終了時間",
            selection: $recruitData.endDate,
            displayedComponents: [.hourAndMinute]
        ).datePickerStyle(.compact)
    }
    
    // その他タグ
    @ViewBuilder private func tagForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("その他タグ").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagSelectionRow(
                rowTags: tagList1,selectedTags: $recruitData.tags
            )
            TagSelectionRow(
                rowTags: tagList2,selectedTags: $recruitData.tags
            )
            TagSelectionRow(
                rowTags: tagList3,selectedTags: $recruitData.tags
            )
            TagSelectionRow(
                rowTags: tagList4,selectedTags: $recruitData.tags
            )
            TagSelectionRow(
                rowTags: tagList5,selectedTags: $recruitData.tags
            )
            TagSelectionRow(
                rowTags: tagList6,selectedTags: $recruitData.tags
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
