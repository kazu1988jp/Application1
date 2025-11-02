//
//  ListView.swift
//  Application1
//
//  Created by 鈴木一真 on 2025/11/01.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var manager = LocationManager()

    var body: some View {
        let latetude = $manager.location.wrappedValue.coordinate.latitude
        let longitude = $manager.location.wrappedValue.coordinate.longitude

        
        NavigationView {
            
            ScrollView{
                
                VStack{
                    Text("123")
                    Text("\(latetude), \(longitude)").padding()
                }
                
            }.navigationTitle("List")
        }
        
        
    }
}

#Preview {
    ListView()
}
