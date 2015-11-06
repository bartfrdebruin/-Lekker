//
//  ListViewController.h
//  Lekker
//
//  Created by Bart de Bruin on 02-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface ListViewController : PFQueryTableViewController <UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *vegetables;
@property (nonatomic, strong) NSArray *meat;
@property (nonatomic, strong) NSArray *titleCell;
@property (nonatomic, strong) NSArray *distance;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *comment;

@end
