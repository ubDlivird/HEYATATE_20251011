//
//  BannerAdView.swift
//  MOPPER_20251008
//
//  Created by shuya on R 7/10/10.
//
//  AdMobバナー広告を表示するためのUIViewRepresentable

import SwiftUI
import GoogleMobileAds // MARK: Import: AdMobライブラリ

// MARK: - 定数 (AdMob)
// TODO: 実際のAdMobユニットIDに置き換えてください。テスト用IDを使用しています。
private let testAdUnitID = "ca-app-pub-3940256099942544/2934735716" // AdMobテスト広告ユニットID
private let bannerAdHeight: CGFloat = 50.0 // 標準的なバナー広告の高さ

// MARK: - AdMobバナー広告ビュー (BannerAdView)
/// GoogleMobileAds SDKのBannerViewをSwiftUIで表示するためのラッパー。
struct BannerAdView: UIViewRepresentable {
    
    // MARK: - AdMobバナービューの作成
    
    // エラー解消: 'GADBannerView' has been renamed to 'BannerView'
    func makeUIView(context: Context) -> BannerView { // MARK: Function: BannerView作成
        // BannerViewの初期化
        // エラー解消: 'GADAdSizeBanner' has been renamed to 'AdSizeBanner'
        let bannerView = BannerView(adSize: AdSizeBanner)
        
        // MARK: AdMob設定
        bannerView.adUnitID = testAdUnitID // 広告ユニットIDを設定
        
        // ルートビューコントローラーの設定
        // アプリ起動時に初期化された最初のウィンドウのルートVCを取得
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            bannerView.rootViewController = rootViewController
        }
        
        // 広告のロード
        // エラー解消: 'GADRequest' has been renamed to 'Request'
        bannerView.load(Request()) // MARK: Load: 広告の読み込み
        
        return bannerView
    }
    
    // MARK: - AdMobバナービューの更新 (今回は何もしない)
    
    // エラー解消: 'GADBannerView' has been renamed to 'BannerView'
    func updateUIView(_ uiView: BannerView, context: Context) { // MARK: Function: BannerView更新
        // 更新処理はなし
    }
    
    // MARK: - 広告の高さ定数取得
    /// AdMobバナー広告の標準高さを返す。
    static func getHeight() -> CGFloat { // MARK: Function: 広告高さ取得
        return bannerAdHeight
    }
}

// MARK: - プレビュー
struct BannerAdView_Previews: PreviewProvider { // 👈プレビューを追加
    static var previews: some View {
        // バナー広告の高さに合わせてフレームを設定
        BannerAdView()
            .frame(height: BannerAdView.getHeight())
            .previewLayout(.sizeThatFits)
    }
}
