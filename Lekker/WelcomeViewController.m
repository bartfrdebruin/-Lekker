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
    [self.navigationController setNavigationBarHidden:NO];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
//    UINavigationItem *navigation = self.navigationItem;
//    navigation.title = @"#LekkerMap";
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
