//
//  DictionaryApp.swift
//  Dictionary
//
//  Created by Dmitrii Vilgauk on 09.01.2024.
//

import SwiftUI
import SwiftData

@main
struct DictionaryApp: App {
    
    // let container: ModelContainer = {
    // let schema = Schema([Dictionary.self])
    // let config = ModelConfiguration(<#T##name: String?##String?#>, schema: <#T##Schema?#>, isStoredInMemoryOnly: <#T##Bool#>, allowsSave: <#T##Bool#>, groupContainer: <#T##ModelConfiguration.GroupContainer#>, cloudKitDatabase: <#T##ModelConfiguration.CloudKitDatabase#>)
    // let container = try! /*force unwrap cathc try*/ ModelContainer(for: schema, configurations: [])
    // return container
    // }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // .modelContainer(container)
       .modelContainer(for: [Dictionary.self]) /* для случаев когда хотим базовый котейнер */
    }
}
