//
//  ContentView.swift
//  MOPPER_20251008
//
//  Created by shuya on R 7/10/08.
//
//  メインとなるタブバー (メニューバー) を管理するビュー。
//  ホーム(部屋選択)とプロフィール画面を切り替える。

import SwiftUI

// MARK: - メニューバーのルートビュー (MainTabView)

struct ContentView: View {
    
    // コーディングのコメント: タブ状態管理オブジェクトを作成
    @StateObject private var tabManager = TabManager()
    
    // MARK: - TabView 実装
    
    var body: some View {
        // TabViewで画面下部にメニューバーを作成(selectionパラメータに状態変数をバインド)
        TabView(selection: $tabManager.selectedTab) {
            
            // 1番目タブ
            RecruitView()
                .tabItem { // MARK: TabItem: ホーム
                    Label("ヘヤタテ", systemImage: "house.fill")
                }
                .tag(0)
            
            // 2番目タブ
            feedView()
                .tabItem { // MARK: TabItem: フィード
                    Label("フィード", systemImage: "person.fill")
                }
                .tag(1)
            
            // 3番目タブ
            //            SampleView()
            //                .tabItem { // MARK: TabItem: プロフィール
            //                    Label("ご意見箱", systemImage: "paperplane")
            //                }
            
            // 暫定
            //            LoadMapView()
            //                .tabItem { // MARK: TabItem: プロフィール
            //                    Label("応援する", systemImage: "gear")
            //                }
        }
        .environmentObject(tabManager)
    }
}

// MARK: - プレビュー
#Preview {
    ContentView()
}
