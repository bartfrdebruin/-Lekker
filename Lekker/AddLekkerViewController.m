//
//  AddLekkerViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/4/15.
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

@end
