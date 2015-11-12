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
    PFQuery *query = [PFQuery queryWithClassName:@"Lekker"];
    
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
