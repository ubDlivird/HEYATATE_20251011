//
//  RecruitView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/14.
//

import SwiftUI

// 子ビューに受け渡し用
struct RecruitData: Codable{
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
    var comment: String = "" // 投稿コメントを保持
    var imageFileName: String = "" // 画像ファイル名を保持
}


struct RecruitView: View {
    
    // 子ビューに受け渡し用
    @State private var recruitData = RecruitData()
    
    // 共有ロジックをViewの状態として保持
    @StateObject private var shareLogic = ShareLogic()
    
    // 投稿管理マネージャのシングルトンインスタンスを取得
    private let postManager = PostManager.shared
    
    // 環境オブジェクトからマネージャーを参照
    @EnvironmentObject var tabManager: TabManager
    
    // モード選択
    private let modeList1: [String] = ["#オープン", "#サモラン", "#プラベ"]
    // 実施場所
    private let areaList1: [String] = ["スペース", "Discord","公式Discord"]
    // 参加方法
    private let joinList1: [String] = ["返信(X)", "チャット", "スペース直"]
    // VC
    private var vcList1: [String] = ["あり", "なし", "どちらでも"]
    // その他タグ
    private let tagList1: [String] = ["#エンジョイ", "#ガチ", "#レート上げ"]
    private let tagList2: [String] = ["#ゆる募", "#クリア重視", "#初心者です"]
    private let tagList3: [String] = ["#20歳以上","#社会人", "#学生"]
    private let tagList4: [String] = ["#FFのみ", "#FF外歓迎", "#だれでも"]
    private let tagList5: [String] = ["#途中抜け⭕️","#休憩あり","#飲酒中"]
    private let tagList6: [String] = ["#聞き専⭕️", "#聞き専❌","#不穏❌"]
    private let tagList7: [String] = ["#タメ口⭕️", "#戦犯⭕️","#🔰歓迎"]

    
    var body: some View {
        VStack{
            Text("プレビュー")
            ImageView() // プレビュー
            Text("募集事項")
            Form{
                gameForm() // ゲーム
                modeForm() // モード
                titleForm() // 題名
                peopleForm() // 人数
                timeForm() // 時間選択
                vcForm() // VC有無
                areaForm() // 実施場所
//                joinForm() // 参加方法
                nowRateForm() // 現在レート
                reqRateForm() // 募集レート
                tagForm() // その他タグ
                commentForm() // 投稿コメント
                heyateteButton() // ヘヤタテボタン
            }
        }
        .onAppear { // 👈 追加: VStackの直後に適用
            // フィードから渡されたデータがあればフォームに反映しデータをクリア
            if let data = tabManager.dataToEdit {
                recruitData = data // データでフォームを更新
                tabManager.dataToEdit = nil // データクリア
            }
        }
    }
    
    // テンプレートプレビュー
    private func ImageView() -> some View{
        CreateImageView(recruitData : $recruitData)
    }
    
    // ゲーム選択
    @ViewBuilder private func gameForm() -> some View {
        ZStack{
            
        }
        
        Picker("ゲームを選択", selection: $recruitData.game) {
            // 選択項目の一覧を生成
            Text("スプラトゥーン3").tag("#スプラトゥーン3")
        }
    }
    
    // モード選択
    @ViewBuilder private func modeForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("モード選択").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagMulch(
                rowTags: modeList1,selectedTags: $recruitData.modes
            ).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // 中央
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

    // 実施場所
    @ViewBuilder private func areaForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("実施場所").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagOnly(
                rowTags: areaList1,selectedTags: $recruitData.areas
            )
        }
    }
    
    // 参加方法
    @ViewBuilder private func joinForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("投稿コメント").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagMulch(
                rowTags: joinList1,selectedTags: $recruitData.joins
            )
        }
    }
    
    // 現在レート
    @ViewBuilder private func nowRateForm() -> some View {
        HStack{
            Picker("現在レート", selection: $recruitData.nowRank) {
                Text("XP").tag("XP")
                Text("S+").tag("S+")
                Text("S").tag("S")
                Text("~A").tag("~A")
                Text("伝説").tag("伝説")
                Text("達人").tag("達人")
            }
            TextField("400", text: $recruitData.nowRate).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .onChange(of: recruitData.nowRate) {
                    // 文字数制限を超過した場合の処理
                    if recruitData.nowRate.count > 4 { // 文字数制限
                        // 文字列を先頭から定数で切り詰める
                        recruitData.nowRate = String(recruitData.nowRate.prefix(4))
                    }
                }
        }
    }
    
    // 募集レート
    @ViewBuilder private func reqRateForm() -> some View {
        HStack{
            Picker("募集レート", selection: $recruitData.reqRank) {
                Text("無制限").tag("無制限")
                Text("伝説").tag("伝説")
                Text("達人").tag("達人")
                Text("XP").tag("XP")
                Text("S+").tag("S+")
                Text("S").tag("S")
                Text("A").tag("A")
                Text("B").tag("B")
                Text("C").tag("C")
            }
            TextField("400", text: $recruitData.reqRate).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .onChange(of: recruitData.reqRate) {
                    // 文字数制限を超過した場合の処理
                    if recruitData.reqRate.count > 4 { // 文字数制限
                        // 文字列を先頭から定数で切り詰める
                        recruitData.reqRate = String(recruitData.reqRate.prefix(4))
                    }
                }
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
    @ViewBuilder private func vcForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("ボイスチャット").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagOnly(
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
    
    // コメント記載
    @ViewBuilder private func commentForm() -> some View {
        VStack {
            Text("フリーコメント").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TextField("お気軽にどうぞ〜！", text: $recruitData.comment)
                .onChange(of: recruitData.comment) {
                    // 文字数制限を超過した場合の処理
                    if recruitData.comment.count > 140 { // 文字数制限
                        // 文字列を先頭から定数で切り詰める
                        recruitData.comment = String(recruitData.comment.prefix(140))
                    }
                }
        }
    }
    
    // ヘヤタテボタン
    @ViewBuilder private func heyateteButton() -> some View {
        HStack{
            Spacer()
            Button(action: {
                // recruitDataとpostManagerのインスタンスをShareLogicに渡す
                shareLogic.share(
                    // ImageView()が返すビューに固定のframeを適用し、レンダリングサイズを固定する
                    view: ImageView(),
                    recruitData: recruitData, // RecruitDataを渡す
                    postManager: postManager // PostManagerの参照を渡す
                )
            }) {
                Text("ヘヤタテする！")
            }
            .padding()
            .accentColor(Color.white)
            .background(Color.blue)
            .cornerRadius(.infinity)
            // レンダリング中はボタンを無効化
            .disabled(shareLogic.isRendering)
            // レンダリング中はProgressViewを重ねて表示
            .overlay {
                // レンダリング中の場合にProgressViewを表示
                if shareLogic.isRendering {
                    ProgressView()
                }
            }
            // 共有シートの表示ロジックをこのメソッド内に移動
            .sheet(isPresented: $shareLogic.isSharing, onDismiss: shareLogic.didDismissShareSheet) {
                // 共有アイテムを取得し、ActivityViewを表示
                let items = shareLogic.createActivityItems()
                if !items.isEmpty {
                    // 共有したいアイテム（画像とテキスト）を渡す
                    ActivityView(activityItems: items)
                }
            }
            Spacer()

        }
    }
    
    // その他タグ
    @ViewBuilder private func tagForm() -> some View {
        VStack(alignment: .leading, spacing: 5){
            Text("その他タグ").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            TagMulch(
                rowTags: tagList1,selectedTags: $recruitData.tags
            )
            TagMulch(
                rowTags: tagList2,selectedTags: $recruitData.tags
            )
            TagMulch(
                rowTags: tagList3,selectedTags: $recruitData.tags
            )
            TagMulch(
                rowTags: tagList4,selectedTags: $recruitData.tags
            )
            TagMulch(
                rowTags: tagList5,selectedTags: $recruitData.tags
            )
            TagMulch(
                rowTags: tagList6,selectedTags: $recruitData.tags
            )
            TagMulch(
                rowTags: tagList7,selectedTags: $recruitData.tags
            )
        }
    }
    
    // タグ選択用(複数可)
    struct TagMulch: View {
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
    
    // タグ選択用(1つのみ)
    struct TagOnly: View {
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
        
        // 排他処理
        private func toggleSelection(for tag: String) {
            if selectedTags.contains(tag) { // 既に選択されている場合
                selectedTags = [] // 配列を空にして非選択状態に戻す
            } else { // 選択されていない場合
                // 配列をタップされたタグのみで置き換え、他のタグを非選択状態にする
                selectedTags = [tag]
            }
        }
    }
    
}

#Preview {
    RecruitView()
        .environmentObject(TabManager())
}
