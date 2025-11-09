//
//  ListView.swift
//  Application1
//
//  Created by 鈴木一真 on 2025/11/01.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var manager = LocationManager()

    var body: some View {
//        let latetude = $manager.location.wrappedValue.coordinate.latitude
//        let longitude = $manager.location.wrappedValue.coordinate.longitude
        

        
        
        NavigationView {
            
            ScrollView{
                
                VStack{
                    Text("Location")
                    Text("\(manager.latitude), \(manager.longitude)").padding()
                    
                }.onAppear{ manager.manager.requestWhenInUseAuthorization()}
                
            }.navigationTitle("List")
        }
        
        
    }
}

//struct LocationList: View{
//    @ObservedObject var manager = LocationManager()
//    
//    var body: some View{
//        
//        Text($manager.locationList.count)
//    }
//    
//}

#Preview {
    ListView()
}
