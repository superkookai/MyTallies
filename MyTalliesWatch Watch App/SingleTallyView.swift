//
//  SingleTallyView.swift
//  MyTalliesWatch Watch App
//
//  Created by Weerawut Chaiyasomboon on 29/12/2567 BE.
//

import SwiftUI

struct SingleTallyView: View {
    @Environment(TallyManager.self) var tallyManager
    
    var body: some View {
        if tallyManager.selectedTally != nil {
            VStack {
                Text("\(tallyManager.selectedTally!.value)")
                    .font(.system(size: 80, weight: .heavy, design: .rounded))
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .minimumScaleFactor(0.5)
                    .padding()
                    .frame(width: 80*1.5, height: 80*1.5)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.clear).stroke(Color.primary, lineWidth: 5))
                
                Text(tallyManager.selectedTally!.name)
                    .font(.title3)
            }
            .onTapGesture {
                withAnimation {
                    tallyManager.increaseSelected()
                    let connectivity = watchOSConnectivity.shared
                    connectivity.updateSelectedTally(selectedTally: tallyManager.selectedTally)
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    SingleTallyView()
}

struct MockData: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        @Previewable @State var tallyManager = TallyManager()
        tallyManager.updateTallies(tallies: WatchTally.mockTallies)
        return content
            .environment(tallyManager)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static let mockData: Self = .modifier(MockData())
}
