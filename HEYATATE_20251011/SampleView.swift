import SwiftUI

// MARK: - 定数
private let TEXT_TO_SHARE = "おはようございます"

// MARK: - ビュー
struct SampleView: View {
    // MARK: - Properties

    // 共有ロジックをViewの状態として保持
    @StateObject private var shareLogic = ShareLogic()

    // 画像化するビュー
    private var targetView: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .padding(40)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
    }

    // MARK: - Body

    var body: some View {
        VStack {
            // 画像化する対象のView
            targetView
                .padding(.bottom, 50)

            // MARK: - 共有ボタン
            Button("ボタンを押したら直接共有画面を出す") {
                // targetViewと文字列を渡して共有ロジックを呼び出す
                shareLogic.share(view: targetView, textToShare: TEXT_TO_SHARE)
            }
            .buttonStyle(.borderedProminent)
            // レンダリング中はボタンを無効化
            .disabled(shareLogic.isRendering)
            // レンダリング中はProgressViewを重ねて表示
            .overlay {
                // レンダリング中の場合にProgressViewを表示
                if shareLogic.isRendering {
                    ProgressView()
                }
            }

            // isSharingがtrueになったら共有シートを表示
            .sheet(isPresented: $shareLogic.isSharing, onDismiss: shareLogic.didDismissShareSheet) {
                // 共有アイテムを取得し、ActivityViewを表示
                let items = shareLogic.createActivityItems()
                if !items.isEmpty {
                    // 共有したいアイテム（画像とテキスト）を渡す
                    ActivityView(activityItems: items)
                }
            }
        }
    }
}

#Preview {
    SampleView()
}
