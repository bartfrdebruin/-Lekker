//
//  AddLekkerViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/5/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "AddLekkerViewController.h"
#import "MapViewController.h"

@interface AddLekkerViewController ()

@end

@implementation AddLekkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.imageView.image = self.photo;
    
}

#pragma post data to Parse



#pragma textFieldShouldReturn

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
