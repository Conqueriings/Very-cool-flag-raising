//
//  FlagDataManager.swift
//  Very cool flag raising
//
//  Created by Conqueriings on 7/9/21.
//

import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation
import SwiftUI

class FlagDataManager: ObservableObject {
    
    let ref = Database.database().reference()
    
    @Published var flag = Flag(emoji: "🇸🇬", description: "Singapore")
    @Published var flagOffset = 20.0
    
    func fetchData() {
        ref.observe(.value) { snapshot in
            let flagSnapshot = snapshot.childSnapshot(forPath: "flag")
            
            if let flag = try? flagSnapshot.data(as: Flag.self) {
                self.flag = flag
            }
            
            let flagOffsetSnapshot = snapshot.childSnapshot(forPath: "flagOffset")
                        
                        if let flagOffset = try? flagOffsetSnapshot.data(as: Double.self) {
                            self.flagOffset = flagOffset
                        }

        }
    }
    
    func saveFlag() {
        try? ref.child("flag").setValue(from: flag)
    }
    
    func saveFlagOffset() {
        try? ref.child("flagOffset").setValue(from: flagOffset)
    }

}
