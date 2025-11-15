import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // CLLocationManager のインスタンス
    private let manager = CLLocationManager()
    
    // 現在の位置情報（必要に応じてオプショナルにしても良い）
    @Published var location: CLLocation?
    
    // 緯度・経度の個別プロパティは、location プロパティから取得できるため削除可能
    
    // 履歴データ（PointdataRecord -> locationHistory に名前を変更し、標準的な命名に統一）
    @Published var locationHistory: [DataPoint] = []
    
    // MARK: - 計算プロパティ (Chartの範囲用)
    
    // 最小/最大値は履歴データに基づいて計算し、@Published から分離する
    var minLatitude: Double {
        // locationHistory が空の場合は理論上の最大値 90 を返す
        let min = locationHistory.map { $0.latitude }.min() ?? 90
        return min - 0.05 // マージンを加える
    }

    var maxLatitude: Double {
        // locationHistory が空の場合は理論上の最小値 -90 を返す
        let max = locationHistory.map { $0.latitude }.max() ?? -90
        return max + 0.05 // マージンを加える
    }

    var minLongitude: Double {
        let min = locationHistory.map { $0.longitude }.min() ?? 180
        return min - 0.1 // マージンを加える
    }

    var maxLongitude: Double {
        let max = locationHistory.map { $0.longitude }.max() ?? -180
        return max + 0.1 // マージンを加える
    }
    
    // MARK: - 初期化
    
    override init() {
        super.init()
        
        // デリゲート設定
        self.manager.delegate = self
        
        // 許可要求
        self.manager.requestWhenInUseAuthorization()
        
        // 設定
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        // フィルタリングはそのまま
        self.manager.distanceFilter = 10
        
        // 更新開始
        self.manager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        
        // 現在地の更新
        self.location = latestLocation
        
        let latitude = latestLocation.coordinate.latitude
        let longitude = latestLocation.coordinate.longitude
        
        // 履歴レコードの追加
        let newPoint = DataPoint(latitude: latitude, longitude: longitude)
        locationHistory.append(newPoint) // PointdataRecord -> locationHistory に修正
        
        // 注意: 範囲 (min/max) の更新ロジックは、計算プロパティに移譲されたため、この関数からは削除されます。
        
        // 位置情報許可ステータスチェック（オプション：エラーハンドリング改善）
//        if let status = status(for: manager.authorizationStatus), status != .authorizedAlways && status != .authorizedWhenInUse {
//            // 必要に応じてエラーをログに出す
//        }
    }
    
    // エラーハンドリング
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager Error: \(error.localizedDescription)")
    }
    
    // 許可ステータス変更のデリゲート
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 許可ステータスが変更された時の処理（例: .notDetermined から .authorizedWhenInUse へ）
        // 必要に応じて UI を更新
    }
    
    // Helper for authorization status (iOS 14+)
    @available(iOS 14.0, *)
    private func status(for authorizationStatus: CLAuthorizationStatus) -> CLAuthorizationStatus {
        return authorizationStatus
    }
}
