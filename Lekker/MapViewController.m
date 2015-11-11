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


// Zooming in to our location
- (void)mapView:(MKMapView * _Nonnull)mapView
didUpdateUserLocation:(MKUserLocation * _Nonnull)userLocation {
    
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region =
    
    MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [mapView setRegion:region animated:YES];
}


#pragma mark Location Manager

//    // If the annotation is the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//
//    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[LekkerAnnotations class]])
//    {
////        // Try to dequeue an existing pin view first.
////        MKPinAnnotationView* lekkerAnnotation = (MKPinAnnotationView*)[mapView
////                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//
//        MKAnnotationView* lekkerAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                               reuseIdentifier:@"MyCustomAnnotation"];
//        lekkerAnnotation.image = [UIImage imageNamed:@"#Lekker_pin.png"];
//        lekkerAnnotation.centerOffset = CGPointMake(10, -20);
//
//
//
////        if (!lekkerAnnotation)
////        {
//////            // If an existing pin view was not available, create one.
//////            lekkerAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
//////                                                      reuseIdentifier:@"CustomPinAnnotationView"];
//////
//////            lekkerAnnotation.pinTintColor = MKPinAnnotationColorRed;
//////            lekkerAnnotation.animatesDrop = YES;
//////            lekkerAnnotation.canShowCallout = YES;
////
////            // If appropriate, customize the callout by adding accessory views (code not shown).
////        }
////        else
////            lekkerAnnotation.annotation = annotation;
//
//
//
//        return lekkerAnnotation;
//    }
//
//    return nil;

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
        
    } else {
        
        LekkerAnnotations *lekkerAnno = (LekkerAnnotations *)annotation;
        
        NSLog(@"%@", lekkerAnno.mySubtitle);
        
        if ([lekkerAnno.mySubtitle isEqualToString:@"Arts & Culture"]) {
            
            
            MKPinAnnotationView *artsAndCulture = [[MKPinAnnotationView alloc]
                                                   initWithAnnotation:annotation reuseIdentifier:@"Arts & Culture"];
            
            artsAndCulture.pinColor = MKPinAnnotationColorGreen;
            artsAndCulture.animatesDrop = YES;
            artsAndCulture.canShowCallout = YES;
            
            // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            artsAndCulture.rightCalloutAccessoryView = rightButton;
            
            // Add a custom image to the left side of the callout.
            UIImageView *artsAndCulturePin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"#Lekker_pin.png"]];
            artsAndCulture.leftCalloutAccessoryView = artsAndCulturePin;
            
            return artsAndCulture;
            
        } else if ([lekkerAnno.mySubtitle isEqualToString:@"Random #Lekkers"]) {
            
            
            MKPinAnnotationView *randomLekker = [[MKPinAnnotationView alloc]
                                                 initWithAnnotation:annotation reuseIdentifier:@"#RandomLekkers"];
            
            randomLekker.pinColor = MKPinAnnotationColorPurple;
            randomLekker.animatesDrop = YES;
            randomLekker.canShowCallout = YES;
            
            // Because this is an iOS app, add the detail disclosure button to display details about the annotation in another view.
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            randomLekker.rightCalloutAccessoryView = rightButton;
            
            // Add a custom image to the left side of the callout.
            UIImageView *randomLekkerPin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"#Lekker_pin.png"]];
            randomLekker.leftCalloutAccessoryView = randomLekkerPin;
            
            return randomLekker;
            
        } else ([lekkerAnno.mySubtitle isEqualToString:@"Food & Drinks"]);{
            
            
            MKPinAnnotationView *foodAndDrinksLekkers = [[MKPinAnnotationView alloc]
                                                         initWithAnnotation:annotation reuseIdentifier:@"#FoodAndDrinksLekkers"];
            
            foodAndDrinksLekkers.pinColor = MKPinAnnotationColorRed;
            foodAndDrinksLekkers.animatesDrop = YES;
            foodAndDrinksLekkers.canShowCallout = YES;
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            foodAndDrinksLekkers.rightCalloutAccessoryView = rightButton;
            
            // Add a custom image to the left side of the callout.
            UIImageView *foodAndDrinksPin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"#Lekker_pin.png"]];
            foodAndDrinksLekkers.leftCalloutAccessoryView = foodAndDrinksPin;
            
            return foodAndDrinksLekkers;
        }
    }
}








#pragma mark - GoToList

- (IBAction)goToList:(id)sender {
    
    ListViewController *listView = [[ListViewController alloc] init];
    
    [self.navigationController pushViewController:listView animated:YES];
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
            
            NSString *comment = object[@"Comment"];
            NSString *category = object[@"category"];
            PFGeoPoint *geoPoint = object[@"location"];
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
            
            LekkerAnnotations *lekkerAnnotation = [[LekkerAnnotations alloc] initWithLocation:coord title:comment subtitle:category];
            
            [self.mapView addAnnotation:lekkerAnnotation];
        };
    }];
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



//- (void)tableView:(UITableView * _Nonnull)tableView
//didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath
//{
//    
//    PFObject *object = [self objectAtIndexPath:indexPath];
//    
//    NSString *comment = object[@"Comment"];
//    
//    NSLog(@"%@", object);
//    
//    DetailViewController *dtl = [[DetailViewController alloc]init];
//    
//    dtl.comment = comment;
//    
//    [self.navigationController pushViewController:dtl animated:YES];
//    
//}


//- (void)mapView:(MKMapView * _Nonnull)mapView
//didSelectAnnotationView:(MKAnnotationView * _Nonnull)view
//{
//    
//    PFObject *object = [self objectAtAnnotationView:view];
//    
//    NSString *comment = object[@"Comment"];
//    
//    NSLog(@"%@", object);
//    
//    DetailViewController *dtl = [[DetailViewController alloc]init];
//    
//    dtl.comment = comment;
//    
//    [self.navigationController pushViewController:dtl animated:YES];
//    
//}

@end
