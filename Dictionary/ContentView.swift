//
//  ContentView.swift
//  Dictionary
//
//  Created by Dmitrii Vilgauk on 09.01.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(sort: \Dictionary.word) var dictionarys: [Dictionary] /*= []*/
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dictionarys) { dictionary in
                    DictionaryCell(dictionary: dictionary)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(dictionarys[index])
                    }
                }
            }
            .navigationTitle("Dictionary")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet) { AddDictionarySheet() }
            .toolbar {
                if !dictionarys.isEmpty {
                    Button("Add Word", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay(alignment: .topTrailing) {
                if dictionarys.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No words", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding words to see your list.")
                    }, actions: {
                        Button("Add words") { isShowingItemSheet = true}
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview { ContentView() }

struct DictionaryCell: View {

        let dictionary: Dictionary
        
        var body: some View {
            HStack {
                Text(dictionary.word)
                Text(dictionary.translate)
                Spacer()
                Text(dictionary.example)
            }
        }
    }
struct AddDictionarySheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var word: String = ""
    @State private var translate: String = ""
    @State private var example: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Keyword", text: $word)
                TextField("Translate", text: $translate)
                TextField("Example", text: $example)
            }
            .navigationTitle("New word")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let dictionary = Dictionary(word: word, translate: translate, example: example)
                        context.insert(dictionary)
                        //try! context.save() /*в случаях когда мы не доверяем swiftdata что он сохранил данные, можно принудительно сохранить данные*/
                        dismiss()
                    }
                }
            }
        }
    }
}
