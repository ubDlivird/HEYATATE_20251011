import SwiftUI

struct testView: View {
    // 複数選択された項目を保持するStringのリスト (全ての選択肢で共有)
    @State private var selectedFruits: [String] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // MARK: 1行目の選択肢
            // りんご、バナナ、メロンで呼び出し
            FruitSelectionRow(
                rowFruits: ["#りんご", "#バナナ", "#メロン"],
                selectedFruits: $selectedFruits
            )
            
            // MARK: 2行目の選択肢
            // スイカ、いちご、アボガドで呼び出し
            FruitSelectionRow(
                rowFruits: ["#スイカ", "#いちご", "#アボガド","#飲酒中"],
                selectedFruits: $selectedFruits
            )
            
            // MARK: 3行目の選択肢 (例として追加)
            FruitSelectionRow(
                rowFruits: ["#ぶどう", "#もも", "#レモン"],
                selectedFruits: $selectedFruits
            )

            Text("選択中のフルーツ: \(selectedFruits.joined(separator: " "))")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

// 1行分の横並びの選択肢を表示し、選択状態をBindingで親と共有するビュー
struct FruitSelectionRow: View {
    let rowFruits: [String]
    @Binding var selectedFruits: [String]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(rowFruits, id: \.self) { tag in
                fruitButton(for: tag)
            }
            Spacer()
        }
    }

    private func fruitButton(for tag: String) -> some View {
        HStack {
            Text(tag)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(selectedFruits.contains(tag) ? Color.blue : Color(.systemGray5))
        .foregroundColor(selectedFruits.contains(tag) ? .white : .primary)
        .cornerRadius(20)
        .contentShape(Rectangle())
        .onTapGesture {
            toggleSelection(for: tag)
        }
    }

    private func toggleSelection(for tag: String) {
        if let index = selectedFruits.firstIndex(of: tag) {
            selectedFruits.remove(at: index)
        } else {
            selectedFruits.append(tag)
        }
    }
}

#Preview {
    testView()
}
