import SwiftUI
import Combine

// MARK: - タブとデータ共有管理
/// タブ選択状態とRecruitDataを共有するためのオブジェクト
final class TabManager: ObservableObject {
    // 現在選択されているタブのインデックス (0:ヘヤタテ, 1:フィード)
    @Published var selectedTab: Int = 0
    // feedViewからRecruitViewへ渡される編集対象の投稿データ
    @Published var dataToEdit: RecruitData? = nil
}
