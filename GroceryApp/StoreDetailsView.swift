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
    
    let store: Store
    @State private var storeName: String = ""
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
    
    var body: some View {
        VStack {
            TextField(store.name, text: $storeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                updateStore()
            }
        }.padding()
    }
}

struct StoreDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailsView(store: Store(id: "333", name: "HEB"))
    }
}
