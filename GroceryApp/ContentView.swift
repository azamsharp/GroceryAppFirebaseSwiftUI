//
//  ContentView.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 10/21/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ContentView: View {
    
    private var db: Firestore
    @State private var storeName: String = ""
    @State private var stores: [Store] = []
    
    init() {
        db = Firestore.firestore() 
    }
    
    private func saveStore(store: Store) {
       _ = try? db.collection("stores")
            .addDocument(from: store) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document has been saved!")
                    getAllStores()
                }
                
            }
    }
    
    private func getAllStores() {
        
        db.collection("stores")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapshot = snapshot {
                        stores = snapshot.documents.compactMap { doc in
                            let store = try? doc.data(as: Store.self)
                            return store
                        }
                    }
                }
            }
        
    }
    
    var body: some View {
        VStack {
            TextField("Enter store name", text: $storeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save Store") {
                saveStore(store: Store(name: storeName))
            }
            
            List(stores, id: \.name) { store in
                Text(store.name)
            }
            
            Spacer()
            
                .onAppear(perform: {
                    getAllStores()
                })
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
