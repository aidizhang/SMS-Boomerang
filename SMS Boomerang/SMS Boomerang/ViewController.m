//
//  ViewController.m/Users/idzhang/Documents/smsboomerang/SMS Boomerang/SMS Boomerang.xcodeproj
//  SMS Boomerang
//
//  Created by Roger on 10/31/14.
//  Copyright (c) 2014 Roger Zou. All rights reserved.
//

#import "ViewController.h"
//#import "GoogleMaps.framework/Headers/GoogleMaps.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocation *currLoc;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    NSLog(@":/");
    //[self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
//    [self.locationManager stopUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
    //NSLog(@"%d, %d", [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse, [CLLocationManager locationServicesEnabled]);
    //self.currLoc =self.locationManager.location;
    //NSLog(@"%@", self.locationManager.location);
    sleep(1);
    // Do any additional setup after loading the view, typically from a nib.
    // Create a GMSCameraPosition that tells the map to display the coordinates -33.86, 151.20 with zoom level 6
    //GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
    //                                                        longitude:151.20
    //                                                             zoom:6];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currLoc.coordinate.latitude
                                                            longitude:self.currLoc.coordinate.longitude
                                                                 zoom:6];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currLoc = [locations lastObject];
    if (self.currLoc == nil)
        return;
    
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currLoc.coordinate.latitude
                                                                longitude:self.currLoc.coordinate.longitude
                                                                     zoom:6];
        
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView_;
    
    NSLog(@"%@ fffff", self.currLoc);
    // Creates a marker in the center of the map
    GMSMarker *marker = [[GMSMarker alloc] init];
    
    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.position = self.currLoc.coordinate;
    NSLog(@"%@", self.currLoc);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error while getting core location : %@",[error localizedFailureReason]);
    if ([error code] == kCLErrorDenied) {
        //you had denied
    }
    [manager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
