//
//  TallySelectionView.swift
//  MyTallies
//
//  Created by Weerawut Chaiyasomboon on 26/12/2567 BE.
//

import SwiftUI
import SwiftData
import WidgetKit

struct TallySelectionView: View {
    @Environment(Router.self) var router
    @Query(sort:\Tally.name) var tallies: [Tally]
    @State private var selectedTally: Tally?
    @Environment(\.modelContext) var context
    @State private var newTally = false
    @Environment(\.scenePhase) var scencePhase
    @State private var id = UUID()
    let connectivity = iOSConectivity.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                if tallies.isEmpty {
                    ContentUnavailableView("Create your first Tally", image: "mac256")
                } else {
                    Picker("Select your Tally", selection: $selectedTally) {
                        Text("Select Tally").tag(nil as Tally?)
                        
                        ForEach(tallies) { tally in
                            Text(tally.name)
                                .tag(tally as Tally?)
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    
                    if selectedTally != nil {
                        SingleTallyView(size: 100, tally: selectedTally!)
                        
                        Button {
                            withAnimation {
                                selectedTally?.reset()
                                try? context.save()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        } label: {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                        }
                        .font(.title)
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()

                    }
                    
                    Spacer()
                }
            }
            .id(id)
            .navigationTitle("My Tally")
            .toolbar(content: {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !tallies.isEmpty {
                        Button {
                            if let selectedTally {
                                context.delete(selectedTally)
                                try? context.save()
                                WidgetCenter.shared.reloadAllTimelines()
                                if !tallies.isEmpty {
                                    self.selectedTally = tallies.first!
                                }
                                MyTalliesShortCuts.updateAppShortcutParameters()
                            }
                        } label: {
                            Image(systemName: "trash")
                                .foregroundStyle(.red)
                        }
                    }
                    
                    Button {
                        newTally = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            })
            .sheet(isPresented: $newTally, content: {
                NewTallyView(selectedTally: $selectedTally)
                    .presentationDetents([.height(250)])
            })
            .onAppear {
                if !tallies.isEmpty {
                    selectedTally = tallies.first!
                }
            }
            .onChange(of: scencePhase) {
                if scencePhase == .active {
                    id = UUID()
                }
            }
            .onChange(of: router.tallyName) { oldValue, newValue in
                if newValue != selectedTally?.name {
                    selectedTally = tallies.first { $0.name == newValue }
                }
            }
        }
    }
}

#Preview(traits: .mockData) {
    TallySelectionView()
        .environment(Router())
}
