//
//  ViewController.m
//  Uber Bean
//
//  Created by Aaron Chong on 2/2/18.
//  Copyright © 2018 Aaron Chong. All rights reserved.
//

#import "ViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    self.mapView.showsUserLocation = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *latestLocation = [locations lastObject];
    [self.mapView setRegion:MKCoordinateRegionMake(latestLocation.coordinate, MKCoordinateSpanMake(0.05, 0.05))];
    NSLog(@"location updated");
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Fail to locate location");
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.locationManager requestWhenInUseAuthorization];
        [manager requestLocation];
    }
}




@end
