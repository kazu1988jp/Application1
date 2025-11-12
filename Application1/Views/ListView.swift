//
//  ListView.swift
//  Application1
//
//  Created by 鈴木一真 on 2025/11/01.
//

import SwiftUI
import Charts

struct ListView: View {
    
    @ObservedObject var manager = LocationManager()

    var body: some View {

        NavigationView {
            
            List {
                
                ForEach(manager.PointdataRecord) { entry in
                    HStack {
                        // entry.longitude と entry.latitude を直接参照
                        Text("経度: \(entry.longitude, specifier: "%.6f")")
                        Spacer() // 間隔を空ける
                        Text("緯度: \(entry.latitude, specifier: "%.6f")")
                    }
                }
            }
        }
    }
}


struct Graf:View {
    @StateObject var manager = LocationManager()
    @State var Xmin: Double = -90.0
    @State var Xmax: Double = 90.0
    @State var Ymin: Double = -180.0
    @State var Ymax: Double = 180.0
    @State var isSheet : Bool = false
    
    var body: some View {
        VStack{
            Chart(manager.PointdataRecord) {
                PointMark(
                    x: .value("緯度", $0.latitude),
                    y: .value("経度", $0.longitude)
                )
                
            }
            .chartXScale(domain: Xmin...Xmax)
            .chartYScale(domain: Ymin...Ymax)
            .frame(width: 300, height: 300)
            
            HStack{
                Text("Xmin").padding()
                Slider(value: $Xmin, in:-90...Xmax ,step:0.1)
            }
            HStack{
                Text("Xmax").padding()
                Slider(value: $Xmax, in:Xmin...90 ,step:0.1)
            }
            HStack{
                Text("Ymin").padding()
                Slider(value: $Ymin, in:-180...Ymax ,step:0.05)
            }
            HStack{
                Text("Ymax").padding()
                Slider(value: $Ymax, in:Ymin...180 ,step:0.05)
            }.sheet(isPresented: $isSheet) {
                ListView(manager: manager)
            }
            
            Button("Auto") {
                Xmin = manager.minlatitude
                Xmax = manager.maxlatitude
                Ymin = manager.minlongitude
                Ymax = manager.maxlongitude
            }
            .accentColor(Color.white)
            .padding([.leading, .trailing], 20)
            .padding([.top, .bottom])
            .background(Color.blue)
            .cornerRadius(50)
            
            
            Button("see") {
                isSheet.toggle()
            }
            .accentColor(Color.white)
            .padding([.leading, .trailing], 20)
            .padding([.top, .bottom])
            .background(Color.blue)
            .cornerRadius(50)
            
                
        }
    }
}


#Preview {
    //ListView()
    Graf()
}
