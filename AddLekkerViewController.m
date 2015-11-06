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

#pragma mark Views

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    }


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Getting the imageView from the property
    self.imageView.image = self.photo;
    
    self.descriptionTextField.delegate = self;
    // Creating a notification when the keyboard floats up.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnMainViewToInitialposition:) name:UIKeyboardWillShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liftMainViewWhenKeybordAppears:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark keyboard

- (void) liftMainViewWhenKeybordAppears:(NSNotification*)aNotification{
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardBoundsUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    [self.toolbar setFrame:CGRectMake(self.toolbar.frame.origin.x, self.toolbar.frame.origin.y - keyboardFrame.size.height, self.toolbar.frame.size.width, self.toolbar.frame.size.height)];
    [UIView commitAnimations];
}

- (void) returnMainViewToInitialposition:(NSNotification*)aNotification{
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardBoundsUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    [self.toolbar setFrame:CGRectMake(self.toolbar.frame.origin.x, self.toolbar.frame.origin.y + keyboardFrame.size.height, self.toolbar.frame.size.width, self.toolbar.frame.size.height)];
    [UIView commitAnimations];
    
//    CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

#pragma mark creating post

- (IBAction)post:(id)sender {
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        
        PFObject *lekker = [PFObject objectWithClassName:@"Lekker"];
       [lekker setObject:self.descriptionTextField.text forKey:@"Comment"];
        [lekker setObject:geoPoint forKey:@"location"];
        
        // Lekker image
        NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
        
        NSUUID *uuid = [NSUUID UUID];
        
        PFFile *imageFile = [PFFile fileWithName:uuid.UUIDString data:imageData];
        [lekker setObject:imageFile forKey:@"imageFile"];
        
        
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
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [self.descriptionTextField resignFirstResponder];
    return YES;
}

- (IBAction)categoryChoice:(id)sender {
    
}
@end
