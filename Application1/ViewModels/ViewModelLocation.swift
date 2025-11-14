import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location = CLLocation()
    @Published var latitude : Double = 0.0
    @Published var longitude : Double = 0.0
    @Published var PointdataRecord : [DataPoint] = []
    @Published var maxlatitude : Double = -90
    @Published var minlatitude : Double = 90
    @Published var maxlongitude : Double = -180
    @Published var minlongitude : Double = 180
    
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 10
        self.manager.startUpdatingLocation()


 
    }
    
    func locationManager(_ manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        
        let newPoint = DataPoint(latitude: latitude, longitude: longitude)
        
        PointdataRecord.append(newPoint)
        if(maxlatitude < latitude){
            maxlatitude = latitude + 0.05
        }
        if(minlatitude > latitude){
            minlatitude = latitude - 0.05
        }
        if(maxlongitude < longitude){
            maxlongitude = longitude + 0.1
        }
        if(minlongitude > longitude){
            minlongitude = longitude - 0.1
        }
        
    }
    
}





