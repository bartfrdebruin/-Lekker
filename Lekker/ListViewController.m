//
//  ListViewController.m
//  Lekker
//
//  Created by Bart de Bruin on 02-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "ListViewController.h"
#import "LekkerCell.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

#pragma mark TableView


- (PFQuery *)queryForTable
{
 
//    PFGeoPoint *userGeoPoint = self.userLocation;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Lekker"];
    
    [query orderByDescending:@"createdAt"];
    
//    [query whereKey:@"geoPoint" nearGeoPoint:userGeoPoint];
//    
//    query.limit = 10;
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"cell";
    
    LekkerCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LekkerCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    NSString *newComment = object[@"Comment"];
    cell.lekkerComment.text = newComment;
    
    NSString *newCategory = object[@"category"];
    cell.category.text = newCategory;
    
    
//Need to put category image view here, too, once we figure this out, so it can display the right color!!! AAAAAAAHHHHHHHHH!!!!! right???
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

#pragma mark ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    PFGeoPoint *userGeoPoint = self.userLocation [@"imageFile"];
//    
//    [userGeoPoint getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
//        PFGeoPoint *image = [UIImage imageWithData:data];
//        self.lekkerImage.image = image;
//    }];
//    
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//        if (!error) {
//            self.userLocation = geoPoint;
//            [self loadObjects];
//        }
//    }];
    
    [self.navigationItem setHidesBackButton:NO];
    
    UINavigationItem *detailNavigation = self.navigationItem;
    detailNavigation.title = @"#Lekker List";
       
  }

#pragma didSelectRowAtIndexPath

- (void)tableView:(UITableView * _Nonnull)tableView
didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{

    PFObject *lekkerAtIndexPath = [self objectAtIndexPath:indexPath];
    
    DetailViewController *dtl = [[DetailViewController alloc]init];
    
    dtl.detailViewObject = lekkerAtIndexPath;
    
    [self.navigationController pushViewController:dtl animated:YES];

}


@end
