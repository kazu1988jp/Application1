import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location = CLLocation()
    @Published var latitude : Double = 0.0
    @Published var longitude : Double = 0.0
    @Published var latitudeRecord : [Double] = []
    @Published var longitudeRecord : [Double] = []
    @Published var PointdataRecord : [DataPoint] = []
    
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 0.1
        self.manager.startUpdatingLocation()


 
    }
    
    func locationManager(_ manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        latitudeRecord.append(latitude)
        longitudeRecord.append(longitude)
        
        let newPoint = DataPoint(latitude: latitude, longitude: longitude)
        
        PointdataRecord.append(newPoint)
        
    }
    
}

