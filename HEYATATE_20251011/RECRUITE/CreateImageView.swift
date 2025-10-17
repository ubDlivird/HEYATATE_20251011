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
    
    //変数
    private let paddingPx: CGFloat = 1
    
    // タイトル
    private let game: String = "スプラトゥーン3"
    private let title: String = "あいうえおかきくけこさしすせそ"
    // 開催時間
    private let startHHmm: String = "16:00"
    private let endHHmm: String = "18:00"
    // 募集人数
    private let number: String = "3"
    // ボイスチャット
    private let vc: String = "あり"
    // 実施場所
    private let space: String = "スペース"
    // 連絡方法
    private let chat: String = "返信"
    // 現在レート
    private let myRate: String = "800"
    // 募集レート
    private let reqRate: String = "無制限"
    // その他タグ
    private let sonota1: String = "#飲酒中"
    private let sonota2: String = "FF外歓迎"
    
    
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
                    secondView1()
                    secondView2()
                    secondView3()
                    secondView4()
                }
                // 3列目
                HStack {
                    thirdView1()
                    thirdView2()
                    thirdView3()
                    thirdView4()
                }
            }
            .padding()
            .aspectRatio(16/9, contentMode: .fit) // アスペクト16:9
        }
    }
    
    // 1列目実装
    private func firstView() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.gray.opacity(0.5)) // 半透明
            // ゲーム名
            Text("#" + game)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
                .foregroundColor(Color.white)
            // タイトル
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // 中央
                .font(.largeTitle)
                .minimumScaleFactor(0.01)
        }
    }
    
    //2列目実装
    private func secondView1() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("開催時間").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // 開始〜終了
            VStack {
                Text(startHHmm + "　")
                Text("〜" + endHHmm)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    
    private func secondView2() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("募集人数").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // 開始〜終了
            Text("@" + number)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    
    private func secondView3() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("VC").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // VC
            Text(vc)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    
    private func secondView4() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("実施場所").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // 実施場所
            Text(space)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    
    //3列目実装
    private func thirdView1() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("連絡方法").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // 連絡方法
            Text(chat)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    private func thirdView2() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("現在レート").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // 現在レート
            Text(myRate)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    private func thirdView3() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("募集レート").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // 現在レート
            Text(reqRate)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
        }
    }
    private func thirdView4() -> some View{
        ZStack {
            // 背景
            Rectangle().foregroundColor(.white)
            // 見出し
            Text("その他").padding(paddingPx)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // 左上
            // その他
            Text(sonota1 + sonota2)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 中央
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
