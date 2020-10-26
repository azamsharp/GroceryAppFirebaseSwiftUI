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
                            var store = try? doc.data(as: Store.self)
                            if store != nil {
                                store!.id = doc.documentID
                            }
                            return store
                        }
                    }
                }
            }
        
    }
    
    private func deleteStore(at indexSet: IndexSet) {
        indexSet.forEach { index in
            
            let store = stores[index]
            // delete from the firestore database
            db.collection("stores")
                .document(store.id!)
                .delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        getAllStores()
                    }
                }
            
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                TextField("Enter store name", text: $storeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save Store") {
                    saveStore(store: Store(name: storeName))
                }
                
                List {
                    
                    ForEach(stores, id: \.name) { store in
                        NavigationLink(
                            destination: StoreDetailsView(store: store))
                        {
                            Text(store.name)
                        }
                    }.onDelete(perform: deleteStore)
                }.listStyle(PlainListStyle())
                
                Spacer()
                    
                    .onAppear(perform: {
                        getAllStores()
                    })
                
            }.padding()
            
            .navigationTitle("Stores")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
