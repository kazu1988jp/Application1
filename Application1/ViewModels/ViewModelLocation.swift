import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location = CLLocation()
    @Published var latitude : Double = 1.0
    @Published var longitude : Double = 1.0
    
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 2
        self.manager.startUpdatingLocation()

 
    }
    
    func locationManager(_ manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude

    }
    
}

