//
//  ListView.swift
//  Application1
//
//  Created by 鈴木一真 on 2025/11/01.
//

import SwiftUI
import Charts
import math_h

struct ListView: View {
    
    @ObservedObject var manager : LocationManager

    var body: some View {

        NavigationView {
            
            List {
                
                ForEach(manager.locationHistory) { entry in
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
    @State var XCenter: Double = 0
    @State var XRange: Double = 90.0
    @State var YCenter: Double = 0
    @State var YRange: Double = 180.0
    @State var isSheet : Bool = false
    @State var Xmin: Double = -90.0
    @State var Xmax: Double = 90.0
    @State var Ymin: Double = -180.0
    @State var Ymax: Double = 180.0
    
    
    
    var body: some View {
        
        
        VStack{
            Chart(manager.locationHistory) {dataPoint in
                PointMark(
                    x: .value("緯度", dataPoint.latitude),
                    y: .value("経度", dataPoint.longitude)
                )
                
            }
            .chartXScale(domain: Xmin...Xmax)
            .chartYScale(domain: Ymin...Ymax)
            .frame(width: 300, height: 300)
            
            HStack{
                Text("XCenter").padding()
                Slider(value: $XCenter, in:-90...90 ,step:0.1)
            }
            HStack{
                Text("XRange").padding()
                Slider(value: $XRange, in:0...2.25 ,step:0.1)
            }
            HStack{
                Text("YCenter").padding()
                Slider(value: $YCenter, in:-180...180 ,step:0.05)
            }
            HStack{
                Text("YRange").padding()
                Slider(value: $YRange, in:0...2.55 ,step:0.05)
            }.sheet(isPresented: $isSheet) {
                ListView(manager: manager)
            }
            
            
            Button("Auto") {
                XCenter = (manager.maxLatitude + manager.minLatitude) / 2
                XRange = manager.maxLatitude - manager.minLatitude
                YCenter = (manager.maxLongitude + manager.minLongitude) / 2
                YRange = manager.maxLongitude - manager.minLongitude
                
                // updateMagnifyRange を呼び出す
                self.Magnify()
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
        .onChange(of: [XCenter, XRange, YCenter, YRange]) { _ in // XCenter が変わったら実行
            Magnify()
        }

    }
    
    private func Magnify() {
        Xmin = XCenter - (pow(10,XRange) / 2)
            Xmax = XCenter + (pow(10,XRange) / 2)
            Ymin = YCenter - (pow(10,YRange) / 2)
            Ymax = YCenter + (pow(10,YRange) / 2)
        }
    }
    



#Preview {
    //ListView()
    Graf()
}



