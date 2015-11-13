//
//  MapViewController.m
//  Lekker
//
//  Created by Bart de Bruin on 02-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "MapViewController.h"
#import "ListViewController.h"
#import "AddLekkerViewController.h"
#import "LekkerAnnotations.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "LekkerCell.h"
#import "DetailViewController.h"

@interface MapViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation MapViewController


#pragma mark Location Manager

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
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
        
        CLLocation *location = [locationManager location];
    }
    return self;
}


#pragma mark viewDidLoad


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.mapView setShowsUserLocation:YES];
    
    [self.navigationItem setHidesBackButton:YES];
    
    UINavigationItem *mapNavigation = self.navigationItem;
    mapNavigation.title = @"#Lekker";
    
    UIBarButtonItem *list = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStylePlain target:self action:@selector(goToList:)];
    
    mapNavigation.rightBarButtonItem = list;
    
    PFQuery *queriesForAnnotation = [PFQuery queryWithClassName:@"Lekker"];
    
    self.allAnnotations = [[NSMutableArray alloc] init];
    
    [queriesForAnnotation findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        for (PFObject *object in objects) {
            
            LekkerAnnotations *lekkerAnnotation = [[LekkerAnnotations alloc] initWithObject:object];
            
            [self.allAnnotations addObject:lekkerAnnotation];
            
            [self.mapView addAnnotation:lekkerAnnotation];

       
            }
//            [self.mapView addAnnotation:lekkerAnnotation];
        
    }];
}



// Zooming in to our location
- (void)mapView:(MKMapView * _Nonnull)mapView
didUpdateUserLocation:(MKUserLocation * _Nonnull)userLocation {
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region =
    
    MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [mapView setRegion:region animated:YES];
}


#pragma mark Annotation

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
        
    } else {
        
        LekkerAnnotations *lekkerAnno = (LekkerAnnotations *)annotation;
        
        NSString *category = lekkerAnno.lekkerObject[@"category"];
        
        MKAnnotationView *lekkerAnnotationView = [self annotationForCategory:category image:[UIImage imageNamed:category] annotation:lekkerAnno];
        
        return lekkerAnnotationView;
        
    }
}


#pragma mark Annotation Update


- (MKAnnotationView *)annotationForCategory:(NSString *)category image:(UIImage *)image annotation:(LekkerAnnotations *)annotation {
    
    MKAnnotationView *annotationForMap = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:category];
    
    annotationForMap.image = image;
    annotationForMap.centerOffset = CGPointMake(10, -20);
    annotationForMap.canShowCallout = YES;
    annotation.title = annotation.lekkerObject [@"Comment"];
    annotation.subtitle = annotation.lekkerObject [@"category"];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    annotationForMap.rightCalloutAccessoryView = rightButton;
    
    PFImageView *annotationPin = [[PFImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 100)];
    annotationPin.file = annotation.lekkerObject [@"imageFile"];
    [annotationPin loadInBackground];
    annotationForMap.leftCalloutAccessoryView = annotationPin;
    
    return annotationForMap;
    
    }


- (void)addCategorizedAnnotations {
    
    
    [self.mapView removeAnnotations:self.allAnnotations];
    
    for (LekkerAnnotations *lekkerAnnotation in self.allAnnotations) {
        
        if ([self.chosenAnnotation isEqualToString:@"All Categories"]) {
            
            [self.mapView addAnnotation: lekkerAnnotation];
            
        } else if ([self.chosenAnnotation isEqualToString:lekkerAnnotation.lekkerObject [@"category"]]) {
            
            [self.mapView addAnnotation: lekkerAnnotation];
        }
         
    }
}


#pragma mark Update Categories

- (IBAction)categoryChooser:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Categories"
                                                                   message:@"Update your categories!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *allCategories = [UIAlertAction actionWithTitle:@"All Categories" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               self.chosenAnnotation = @"All Categories";
                                                               [self addCategorizedAnnotations];
                                                               
//                                                               [self annotationForCategory:self.category image:self.category annotation: self.category];
                                                           }];
    
    UIAlertAction *artsAndCulture = [UIAlertAction actionWithTitle:@"Arts & Culture" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               self.chosenAnnotation = @"Arts & Culture";
                                                               
//                                                               for (LekkerAnnotations *lekkerAnno in self.allAnnotations) {
////
//                                                                   if ([lekkerObject.category isEqualToString:@"Arts & Culture"]) {
////
////                                                                       [self.mapView addAnnotation:lekkerAnnotation];
//////                                                                   } else {
//////                                                                    [self.mapView addAnnotation:lekkerAnnotation];
//////
//////                                                                   }
////                                                               }
//                                                               
//                                                             // doesnt exist, but make it exist:   self.chosenAnnotation = value of category
                                                               [self addCategorizedAnnotations];
                                                               
                                                           }];
    
    UIAlertAction *foodAndDrinks = [UIAlertAction actionWithTitle:@"Food & Drinks" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              self.chosenAnnotation = @"Food & Drinks";
                                                              [self addCategorizedAnnotations];
                                                              
                                                              
                                                          }];
    
    UIAlertAction *randomLekkers = [UIAlertAction actionWithTitle:@"Random #Lekkers" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              self.chosenAnnotation = @"Random #Lekkers";
                                                              [self addCategorizedAnnotations];
                                                              
                                                              
                                                          }];
    
    [alert addAction:allCategories];
    [alert addAction:artsAndCulture];
    [alert addAction:foodAndDrinks];
    [alert addAction:randomLekkers];
    
    [self presentViewController:alert animated:NO completion:nil];
    
}




#pragma mark - GoToList

- (IBAction)goToList:(id)sender {
    
    ListViewController *listView = [[ListViewController alloc] init];
    
    [self.navigationController pushViewController:listView animated:YES];
}



#pragma mark Image Picker

- (IBAction)takePicture:(id)sender {
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    
    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.imagePicker.mediaTypes = @[(NSString*)kUTTypeImage];
    
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.delegate = self;
    // Place image picker on the screen
    [self presentViewController:self.imagePicker animated:YES completion: NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
   
    AddLekkerViewController *addLekkerViewController = [[AddLekkerViewController alloc]init];
    
    addLekkerViewController.photo = image;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self.navigationController pushViewController:addLekkerViewController animated:YES];
}




#pragma didSelectAnnotationView

- (void)mapView:(MKMapView * _Nonnull)mapView
 annotationView:(MKAnnotationView * _Nonnull)view
calloutAccessoryControlTapped:(UIControl * _Nonnull)control

{
    
    LekkerAnnotations *lekkerAnnotation = (LekkerAnnotations*) view.annotation;
    
   // NSLog(@"%@", lekkerAnnotation.lekkerObject);
    
    DetailViewController *dtl = [[DetailViewController alloc]init];
    
    dtl.detailViewObject = lekkerAnnotation.lekkerObject;
    
    [self.navigationController pushViewController:dtl animated:YES];
    
}

@end
