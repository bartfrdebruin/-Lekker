//
//  AddLekkerViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/4/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "AddLekkerViewController.h"
#import "MapViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>

@interface AddLekkerViewController ()

@end

@implementation AddLekkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.photo;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
}

#pragma mark Save data with Parse using the following code

- (IBAction)save:(id)sender {
    // Create PFObject with recipe information
    PFObject *lekker = [PFObject objectWithClassName:@"Lekker"];
    [lekker setObject:_lekkerTextField.text forKey:@"description"];
    [lekker setObject:_titleTextField.text forKey:@"title"];
    
    // Recipe image
    NSData *imageData = UIImageJPEGRepresentation(_imageView.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"%@.png", _titleTextField.text];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [lekker setObject:imageFile forKey:@"imageFile"];
    
    // Upload recipe to Parse
    [lekker saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
{
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the #Lekker" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setLekkerTextField:nil];
    [self setTitleTextField:nil];
    [super viewDidUnload];
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
