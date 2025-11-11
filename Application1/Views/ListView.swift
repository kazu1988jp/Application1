//
//  ListView.swift
//  Application1
//
//  Created by 鈴木一真 on 2025/11/01.
//

import SwiftUI
import Charts

struct ListView: View {
    
    @StateObject var manager = LocationManager()

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
    
    var body: some View {
        Chart(manager.PointdataRecord) {

            PointMark(
                x: .value("Wing Length", $0.latitude),
                y: .value("Wing Width", $0.longitude)
            )
        }
    }
}


#Preview {
    ListView()
    //Graf()
}
