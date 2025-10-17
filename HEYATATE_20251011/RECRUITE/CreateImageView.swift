//
//  CreateImageView.swift
//  HEYATATE_20251011
//
//  Created by shuya on R 7/10/13.
//


import SwiftUI

struct CreateImageView: View {
    
    // 親ビューからの選択変数リスト
    @Binding var recruitData : RecruitData
    
    //題名の余白
    private let paddingPx: CGFloat = 2
    // 見出しのフォント
    private let headFont: Font = .footnote.bold()
    // タイトル上余白
    private let headPadding: CGFloat = 8
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.orange)
                .aspectRatio(16/9, contentMode: .fit) // アスペクト16:9
                .cornerRadius(10) // 角の丸み
            VStack(alignment: .leading, spacing: 5) {
                // 1列目
                firstView()
                // 2列目
                HStack {
                    timeView() // 時間
                    peopleView() // 人数
                    nowView2() // 現在レート
                    tagView() // その他

                }
                // 3列目
                HStack {
//                    joinView1() // 連絡方法
                    vcView() // VC
                    areaView() // 場所
                    reqView() // 募集レート
                    tagView() // その他
                }
            }
            .padding(10)
            .aspectRatio(16/9, contentMode: .fit) // アスペクト16:9
        }
    }
    
    // 1列目実装
    private func firstView() -> some View{
        
        ZStack {
            // 背景
            Rectangle().foregroundColor(.gray.opacity(0.5)) // 半透明
            // ゲーム名
            HStack{
                Text(recruitData.game)
                Text(recruitData.modes.joined(separator: " "))
            }
            .frame(
                maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            .font(headFont) // 見出し用フォント
            .foregroundColor(Color.white) // 白文字
            // タイトル
            Text(recruitData.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // 中央
                .font(.largeTitle)
                .minimumScaleFactor(0.01)
                .padding([.top], headPadding) // 内容用余白(上)
                .font(headFont) // 見出し用フォント
        }
    }
    
    //2列目実装
    private func timeView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("開催時間").padding(paddingPx)
                .frame(
                    maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // 開始〜終了
            VStack {
                Text(recruitData.startDate, style: .time)
                    .frame(alignment: .leading) // 左寄せ
                HStack(spacing: 0) {
                    Spacer()
                    Text("〜")
                    Text(recruitData.endDate, style: .time)
                }.padding([.trailing], 8) // 右余白
            }
            .frame(maxWidth: .infinity) // 中央
            .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    
    private func peopleView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("募集人数").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // 募集人数
            Text("@" + "\(recruitData.people)")
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    
    private func vcView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("VC").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // VC
            Text(recruitData.vcs.joined(separator: ", "))
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    
    private func areaView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("実施場所").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // 実施場所
            Text(recruitData.areas.joined(separator: ", "))
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    
    //3列目実装
    private func joinView1() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("連絡方法").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // 連絡方法
            Text(recruitData.joins.joined(separator: ", "))
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    private func nowView2() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("現在レート").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            Text("\(recruitData.nowRank)" + "\(recruitData.nowRate)")
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    private func reqView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("募集レート").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // 現在レート
            Text("\(recruitData.reqRank)" + "\(recruitData.reqRate)" + "~")
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    private func tagView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("その他").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .font(headFont) // 見出し用フォント
            // その他
            Text(recruitData.tags.joined(separator: ", "))
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
                .padding([.top], headPadding) // 内容用余白(上)
        }
    }
    
    
}

//MARK: - プレビュー
#Preview {
    // 変数
    @Previewable @State var dummyData = RecruitData()
    // コーディングのコメント: CreateImageViewにバインディングを渡して初期化
    return CreateImageView(recruitData: $dummyData)
}
