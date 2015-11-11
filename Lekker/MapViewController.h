//
//  MapViewController.h
//  Lekker
//
//  Created by Bart de Bruin on 02-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddLekkerViewController.h"
#import <Parse/Parse.h>
#import "LekkerAnnotations.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MKMapViewDelegate>  {
    
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) PFGeoPoint *userLocation;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (nonatomic, strong) UIBarButtonItem *list;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *mySubtitle;





@end
