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
#import "LekkerAnnotations.h"

@interface AddLekkerViewController ()

@end

@implementation AddLekkerViewController

#pragma mark Views

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Getting the imageView from the property
    self.imageView.image = self.photo;
    
    self.descriptionTextField.delegate = self;
    
    // Creating a notification when the keyboard floats up.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liftMainViewWhenKeybordAppears:) name:UIKeyboardWillShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnMainViewToInitialposition:) name:UIKeyboardWillHideNotification object:nil];
    
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
    
//    NSArray* constraints = self.toolbar.constraints;
//    NSLayoutConstraint* bottomConstraint;
//    for (NSLayoutConstraint *constraint in constraints) {
//        
//        if ([constraint.identifier isEqualToString:@"bottomConstraint"]) {
//            bottomConstraint = constraint;
//            break;
//        }
//        
//    }
//    
//    bottomConstraint.constant = bottomConstraint.constant - keyboardFrame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
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
    
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];

    
    [UIView commitAnimations];
    
}

#pragma mark creating post



- (IBAction)post:(id)sender {
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
            PFObject *lekker = [PFObject objectWithClassName:@"Lekker"];
            [lekker setObject:self.descriptionTextField.text forKey:@"Comment"];
            [lekker setObject:geoPoint forKey:@"location"];
            
            // Lekker image
            NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
            
            // Lekker image name
            NSUUID *uuid = [NSUUID UUID];
            PFFile *imageFile = [PFFile fileWithName:uuid.UUIDString data:imageData];
            [lekker setObject:imageFile forKey:@"imageFile"];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Categories"
                                                                           message:@"Choose a category to fit your post!"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *artsAndCulture = [UIAlertAction actionWithTitle:@"Arts & Culture" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       [lekker setObject:action.title forKey:@"category"];
                                                                       [self saveLekker:lekker];
                                                                   }];
            
            UIAlertAction *foodAndDrinks = [UIAlertAction actionWithTitle:@"Food & Drinks" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [lekker setObject:action.title forKey:@"category"];
                                                                      [self saveLekker:lekker];
                                                                  }];
            
            UIAlertAction *randomLekkers = [UIAlertAction actionWithTitle:@"Random #Lekkers" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      [lekker setObject:action.title forKey:@"category"];
                                                                      [self saveLekker:lekker];
                                                                  }];
            
            [alert addAction:artsAndCulture];
            [alert addAction:foodAndDrinks];
            [alert addAction:randomLekkers];
            
            [self presentViewController:alert animated:NO completion:nil];
        
    }];
}
     
- (void)saveLekker:(PFObject *)lekker {
    
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    [self.descriptionTextField resignFirstResponder];
    return YES;
}

- (IBAction)categoryChoice:(id)sender {
    
}
@end
