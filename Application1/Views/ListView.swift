//
//  ListView.swift
//  Application1
//
//  Created by 鈴木一真 on 2025/11/01.
//

import SwiftUI
import Charts

struct ListView: View {
    
    @ObservedObject var manager : LocationManager

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
                Text("XCenter").padding()
                Slider(value: $XCenter, in:-90...90 ,step:0.1)
            }
            HStack{
                Text("XRange").padding()
                Slider(value: $XRange, in:0...180 ,step:0.1)
            }
            HStack{
                Text("YCenter").padding()
                Slider(value: $YCenter, in:-180...180 ,step:0.05)
            }
            HStack{
                Text("YRange").padding()
                Slider(value: $YRange, in:0...360 ,step:0.05)
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
        .onChange(of: XCenter) { _ in // XCenter が変わったら実行
            Magnify(XCenter: XCenter, XRange: XRange, YCenter: YCenter, YRange: YRange, Xmin: &Xmin, Xmax: &Xmax, Ymin: &Ymin, Ymax: &Ymax)
        }
        .onChange(of: XRange) { _ in // XCenter が変わったら実行
            Magnify(XCenter: XCenter, XRange: XRange, YCenter: YCenter, YRange: YRange, Xmin: &Xmin, Xmax: &Xmax, Ymin: &Ymin, Ymax: &Ymax)
        }
        .onChange(of: YCenter) { _ in // XCenter が変わったら実行
            Magnify(XCenter: XCenter, XRange: XRange, YCenter: YCenter, YRange: YRange, Xmin: &Xmin, Xmax: &Xmax, Ymin: &Ymin, Ymax: &Ymax)
        }
        .onChange(of: YRange) { _ in // XCenter が変わったら実行
            Magnify(XCenter: XCenter, XRange: XRange, YCenter: YCenter, YRange: YRange, Xmin: &Xmin, Xmax: &Xmax, Ymin: &Ymin, Ymax: &Ymax)
        }
    }
    
    func Magnify(
        XCenter: Double,
        XRange: Double,
        YCenter: Double,
        YRange: Double,
        Xmin: inout Double, // ⭐ inout を使用して参照渡しにする
        Xmax: inout Double, // ⭐ inout を使用
        Ymin: inout Double,
        Ymax: inout Double
    ) {
        // Xmin, Xmax, Ymin, Ymax を直接更新できる
        Xmin = XCenter - (XRange / 2) // 中心と範囲から最小値を計算
        Xmax = XCenter + (XRange / 2) // 中心と範囲から最大値を計算
        Ymin = YCenter - (YRange / 2)
        Ymax = YCenter + (YRange / 2)
    }
    
}


#Preview {
    //ListView()
    Graf()
}



