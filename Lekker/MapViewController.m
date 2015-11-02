//
//  MapViewController.m
//  Lekker
//
//  Created by Bart de Bruin on 02-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

#pragma mark goToList

- (IBAction)goToList:(id)sender {
    
   }


#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark image Picker

- (IBAction)takePicture:(id)sender {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    
    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:self.imagePicker animated:YES completion: NULL];
    
    
}


#pragma mark Location Manager

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        
       
        // Create location manager object
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDelegate:self];
        
        // And we want it to be as accurate as possible
        // regardless of how much time/power it takes
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
                
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
        
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        
        if (
            authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
            authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [locationManager startUpdatingLocation];
        }
        
                // Tell our manager to start looking for its location immediately
                [locationManager startUpdatingLocation];
    }
    return self;
}


@end
