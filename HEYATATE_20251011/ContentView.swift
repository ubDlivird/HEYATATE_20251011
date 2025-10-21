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
    
    // MARK: - TabView 実装
    
    var body: some View {
        // TabViewで画面下部にメニューバーを作成
        TabView {
            
            // フィード
            Text("feed")
                .tabItem { // MARK: TabItem: フィード
                    Label("フィード", systemImage: "person.fill")
                }
            
            // 募集
            RecruitView()
                .tabItem { // MARK: TabItem: ホーム
                Label("募集", systemImage: "house.fill")
            }
            
            // プロフィール
            SampleView()
                .tabItem { // MARK: TabItem: プロフィール
                    Label("テスト投稿", systemImage: "person.fill")
                }
            
            // 暫定
            LoadMapView()
                .tabItem { // MARK: TabItem: プロフィール
                    Label("ロードマップ", systemImage: "person.fill")
                }
        }
    }
}

// MARK: - プレビュー
#Preview {
    ContentView()
}
