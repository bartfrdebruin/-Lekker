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
    
    [queriesForAnnotation findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        for (PFObject *object in objects) {
            
            LekkerAnnotations *lekkerAnnotation = [[LekkerAnnotations alloc] initWithObject:object];
            
            
            
            [self.mapView addAnnotation:lekkerAnnotation];
        };
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
        
        NSString *category = lekkerAnno.lekkerObject [@"category"];

        
        if ([category isEqualToString:@"Arts & Culture"]) {
            
            
            MKAnnotationView *artsAndCulture = [[MKAnnotationView alloc]
                                                   initWithAnnotation:lekkerAnno reuseIdentifier:@"Arts & Culture"];
            
            artsAndCulture.image = [UIImage imageNamed:@"#Lekker_artsAndCulture"];
            artsAndCulture.centerOffset = CGPointMake(10, -20);
            artsAndCulture.canShowCallout = YES;
            lekkerAnno.title = lekkerAnno.lekkerObject [@"Comment"];
            lekkerAnno.subtitle = lekkerAnno.lekkerObject [@"category"];
            
            // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            artsAndCulture.rightCalloutAccessoryView = rightButton;
            
        
            // Add a custom image to the left side of the callout.
            PFImageView *artsAndCulturePin = [[PFImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
            artsAndCulturePin.file = lekkerAnno.lekkerObject [@"imageFile"];
            [artsAndCulturePin loadInBackground];
            artsAndCulture.leftCalloutAccessoryView = artsAndCulturePin;
            
            return artsAndCulture;
            
        } else if ([category isEqualToString:@"Random #Lekkers"]) {
            
            
            MKAnnotationView *randomLekker = [[MKAnnotationView alloc]
                                                 initWithAnnotation:lekkerAnno reuseIdentifier:@"#RandomLekkers"];
            
            randomLekker.image = [UIImage imageNamed:@"#Lekker_randomlekkers"];
            randomLekker.centerOffset = CGPointMake(10, -20);
            randomLekker.canShowCallout = YES;
            lekkerAnno.title = lekkerAnno.lekkerObject [@"Comment"];
            lekkerAnno.subtitle = lekkerAnno.lekkerObject [@"category"];
            
            // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            randomLekker.rightCalloutAccessoryView = rightButton;
            
            // Add a custom image to the left side of the callout.
            PFImageView *randomLekkerPin = [[PFImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
            randomLekkerPin.file = lekkerAnno.lekkerObject [@"imageFile"];
            [randomLekkerPin loadInBackground];
            randomLekker.leftCalloutAccessoryView = randomLekkerPin;
            
            return randomLekker;
            
        } else ([category isEqualToString:@"Food & Drinks"]);{
            
            
            MKAnnotationView *foodAndDrinksLekkers = [[MKAnnotationView alloc]
                                                         initWithAnnotation:lekkerAnno reuseIdentifier:@"#FoodAndDrinksLekkers"];
            
            foodAndDrinksLekkers.image = [UIImage imageNamed:@"#Lekker_foodAndDrinks"];
            foodAndDrinksLekkers.centerOffset = CGPointMake(10, -20);
            foodAndDrinksLekkers.canShowCallout = YES;
            lekkerAnno.title = lekkerAnno.lekkerObject [@"Comment"];
            lekkerAnno.subtitle = lekkerAnno.lekkerObject [@"category"];

            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            foodAndDrinksLekkers.rightCalloutAccessoryView = rightButton;
            
            // Add a custom image to the left side of the callout.
            PFImageView *foodAndDrinksPin = [[PFImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 100)];
            foodAndDrinksPin.file = lekkerAnno.lekkerObject [@"imageFile"];
            [foodAndDrinksPin loadInBackground];
            foodAndDrinksLekkers.leftCalloutAccessoryView = foodAndDrinksPin;

            return foodAndDrinksLekkers;
        }
    }
}


#pragma mark Update Categories

- (IBAction)categoryChooser:(id)sender {
    
    
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
didSelectAnnotationView:(MKAnnotationView * _Nonnull)view
{
    
    LekkerAnnotations *lekkerAnnotation = (LekkerAnnotations*) view.annotation;
    
   // NSLog(@"%@", lekkerAnnotation.lekkerObject);
    
    DetailViewController *dtl = [[DetailViewController alloc]init];
    
    dtl.detailViewObject = lekkerAnnotation.lekkerObject;
    
    [self.navigationController pushViewController:dtl animated:YES];
    
}

@end
