//
//  ListViewController.m
//  Lekker
//
//  Created by Bart de Bruin on 02-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "ListViewController.h"
#import "LekkerCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

#pragma mark TableView

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
      
        self.parseClassName = @"Lekker";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"Comment";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled. Leaving this set to NO for now because not sure if we want this.
        self.paginationEnabled = NO;
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"LekkerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *titleLabel = (UILabel*) [cell viewWithTag:101];
    titleLabel.text = [object objectForKey:@"title"];

    UILabel *lekkerComment = (UILabel*) [cell viewWithTag:102];
    lekkerComment.text = [object objectForKey:@"lekkerComment"];
    
//Need to put category image view here, too, once we figure this out, so it can display the right color!!! AAAAAAAHHHHHHHHH!!!!!
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(LekkerCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.title.text = [self.titleCell objectAtIndex:indexPath.row];
//    cell.lekkerComment.text = [self.comment objectAtIndex:indexPath.row];
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}




#pragma mark ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    
  }



@end
