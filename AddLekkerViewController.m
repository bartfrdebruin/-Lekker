//
//  AddLekkerViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/5/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "AddLekkerViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface AddLekkerViewController ()

@end

@implementation AddLekkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.imageView.image = self.photo;
    
}



- (IBAction)post:(id)sender {
    
    PFObject *lekker = [PFObject objectWithClassName:@"Lekker"];
    [lekker setObject:self.titleTextField.text forKey:@"NameOfPost"];
    [lekker setObject:self.descriptionTextField.text forKey:@"Comment"];
  
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    
    NSUUID *uuidString = [[NSUUID alloc] init];
    PFFile *imageFile = [PFFile fileWithName:uuidString data:imageData];
    [lekker setObject:imageFile forKey:@"imageFile"];
    
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error)
     {
        if (!error) {
            
        }
    }];
    
    [lekker saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
             if (!error) {
                 // Show success message
                 UIAlertController *alert = [UIAlertController  alertControllerWithTitle: @"Upload Complete" message: @"Successfully saved your #Lekker post!" preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                 
                 [alert addAction:defaultAction];
                 
                 [self presentViewController:alert animated:YES completion:nil];
                 
             } else {
                 UIAlertController *alert = [UIAlertController  alertControllerWithTitle: @"Upload failure" message: @"Failed to save your #Lekker post!" preferredStyle:UIAlertControllerStyleAlert];
                 
                 UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                 
                 [alert addAction:defaultAction];
                 
                 [self presentViewController:alert animated:YES completion:nil];
             }
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)categoryChoice:(id)sender {
    
}
@end
