//
//  ViewController.swift
//  Map
//
//  Created by anny on 2020/9/15.
//  Copyright © 2020 anny. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var location:CLLocationManager?
    
    @IBAction func addAnnotation(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: map)
        // touch的位置轉成座標
        let touch:CLLocationCoordinate2D = map.convert(touchPoint, toCoordinateFrom: map)

        // 釘大頭針
        let annotation = MKPointAnnotation() // 生出大頭針
        annotation.coordinate = touch        // 設定座標
        map.addAnnotation(annotation)        // 加到地圖上
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 得知使用者位置
        location = CLLocationManager()
        location?.requestWhenInUseAuthorization()
        
        // 追蹤使用者位置
        location?.delegate = self
        location?.desiredAccuracy = kCLLocationAccuracyBest
        location?.activityType = .automotiveNavigation
        location?.startUpdatingLocation()
        
        if let coordinate = location?.location?.coordinate{
            // 設定直向、橫向縮放
            let xScale:CLLocationDegrees = 0.001
            let yScale:CLLocationDegrees = 0.001
            // 設定縮放範圍
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: xScale, longitudeDelta: yScale)
        
            // 設定顯示區域
            let region:MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
            // 顯示區域地圖
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = .followWithHeading
        
/*
        // 設定經緯度
        let latitude:CLLocationDegrees = 25.033684
        let longitude:CLLocationDegrees = 121.564882
        // 經緯度變成座標
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        // 設定直向、橫向縮放
        let xScale:CLLocationDegrees = 0.002
        let yScale:CLLocationDegrees = 0.002
        // 設定縮放範圍
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: xScale, longitudeDelta: yScale)
        
        // 設定顯示區域
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        // 顯示區域地圖
        map.setRegion(region, animated: true)
 */
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("---------------------")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
}

