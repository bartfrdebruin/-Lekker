//
//  WelcomeViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/2/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (IBAction)goButton:(id)sender {
    
    MapViewController *map = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:map animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}

@end
