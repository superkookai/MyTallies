//
//  SingleTallyView.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 26/12/2567 BE.
//

import SwiftUI
import SwiftData
import WidgetKit

struct SingleTallyView: View {
    let size: Double
    @Bindable var tally: Tally
    @Environment(\.modelContext) var context
    
    var body: some View {
        Text("\(tally.value)")
            .font(.system(size: size, weight: .heavy, design: .rounded))
            .monospacedDigit()
            .contentTransition(.numericText())
            .minimumScaleFactor(0.5)
            .padding()
            .frame(width: size*1.5, height: size*1.5)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.clear).stroke(Color.primary, lineWidth: 5))
            .onTapGesture {
                withAnimation{
                    tally.increase()
                    try? context.save()
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
            .onTapGesture(count: 2) {
                withAnimation{
                    tally.decrease()
                    try? context.save()
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
    }
}

#Preview {
    @Previewable @State var tally: Tally = Tally(name: "Alpha")
    SingleTallyView(size: 100, tally: tally)
}
