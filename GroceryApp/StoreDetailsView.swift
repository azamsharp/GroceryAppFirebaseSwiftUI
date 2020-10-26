//
//  StoreDetailsView.swift
//  GroceryApp
//
//  Created by Mohammad Azam on 10/23/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct StoreDetailsView: View {
    
    @State var store: Store
    @State private var storeName: String = ""
    @State private var groceryItemName: String = ""
    let db = Firestore.firestore()
    
    private func updateStore() {
        
        db.collection("stores")
            .document(store.id!)
            .updateData(["name": storeName]) { error in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Store has been updated!")
                }
            }
        
    }
    
    private func loadGroceryItems() {
        let ref = db.collection("stores")
            .document(store.id!)
        
        ref.getDocument { doc, error in
            if let doc = doc, doc.exists {
                if let store = try? doc.data(as: Store.self) {
                    self.store = store
                    self.store.id = doc.documentID
                }
            } else {
                print("Document does not exists!")
            }
        }
        
    }
    
    private func saveGroceryItem() {
        
        db.collection("stores")
            .document(store.id!)
            .updateData([
                "items": FieldValue.arrayUnion([groceryItemName])
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // load the docs and populate the items
                    loadGroceryItems()
                }
            }
        
    }
    
    var body: some View {
       
        NavigationView {
            VStack {
                TextField("Enter item name", text: $groceryItemName)
                Button("Add Item") {
                    saveGroceryItem()
                }
                
                if let items = store.items {
                    List(items, id: \.self) { item in
                        Text(item)
                    }
                }
                
                Spacer()
                
            }.padding()
        }.navigationTitle(store.name)
    }
}

struct StoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailsView(store: Store(id: "333", name: "HEB"))
    }
}
