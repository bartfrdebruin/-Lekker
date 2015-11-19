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

static CGFloat kRowHeight = 120;

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PFGeoPoint *userLocation;

@end

@implementation ListViewController

#pragma mark - TableView

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"Lekker"];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"cell";
    
    LekkerCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LekkerCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    
    [self configureCell:cell object:object];
    
    return cell;
}

- (void)configureCell:(LekkerCell *)cell object:(PFObject *)object
{
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    NSString *newComment = object[@"Comment"];
    cell.lekkerComment.text = newComment;
    [cell.lekkerComment setTextColor:[UIColor whiteColor]];
    
    NSString *newCategory = object[@"category"];
    cell.category.text = newCategory;
    
    
    //Need to put category image view here, too, once we figure this out, so it can display the right color!!! AAAAAAAHHHHHHHHH!!!!! right???}
}
     
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
}


#pragma mark - ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//        if (!error) {
//            self.userLocation = geoPoint;
//            [self loadObjects];
//        }
//    }];
    
    [self.navigationItem setHidesBackButton:NO];
    
    UINavigationItem *detailNavigation = self.navigationItem;
    detailNavigation.title = @"Recent #Lekkers";
       
  }

#pragma didSelectRowAtIndexPath

- (void)tableView:(UITableView * _Nonnull)tableView
didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    
    if (indexPath.row == [self.objects count]) {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else {

    PFObject *lekkerAtIndexPath = [self objectAtIndexPath:indexPath];
    
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    
    detailViewController.detailViewObject = lekkerAtIndexPath;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    }
        
//        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        
//        self.selectedObject = self.objects[indexPath.row];
        
//        detailViewController.currentObject = self.selectedObject;
        
}

@end

