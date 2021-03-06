//
//  AddLekkerViewController.h
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/5/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface AddLekkerViewController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) PFObject *lekker;

- (IBAction)post:(id)sender;
- (IBAction)categoryChoice:(id)sender;


@end
