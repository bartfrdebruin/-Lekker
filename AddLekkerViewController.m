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
    
    // Recipe image
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@.png", self.titleTextField.text];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [lekker setObject:imageFile forKey:@"imageFile"];
    
    [lekker saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
             
             
             if (!error) {
                 // Show success message
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved your #" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
                 
                 // Notify table view to reload the recipes from Parse cloud
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
                 
                 // Dismiss the controller
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
             } else {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alert show];
                 
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
