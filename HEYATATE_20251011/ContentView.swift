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
            
            // 1. ホームタブ: ナビゲーションを内包し、部屋選択とチャット画面への遷移を管理
            Text("home")
                .tabItem { // MARK: TabItem: ホーム
                // タブのアイコンとテキスト
                Label("ホーム", systemImage: "house.fill")
            }
            
            // 2. プロフィールタブ: 未実装のプレースホルダ
            Text("home")
                .tabItem { // MARK: TabItem: プロフィール
                    // タブのアイコンとテキスト
                    Label("プロフィール", systemImage: "person.fill")
                }
        }
    }
}

// MARK: - プレビュー
#Preview {
    ContentView()
}
