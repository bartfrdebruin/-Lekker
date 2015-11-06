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
    
    // Configure the cell
    PFFile *thumbnail = [object objectForKey:@"imageFile"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    NSString *newString = object[@"NameOfPost"];
    cell.title.text = newString;
    
    NSString *newComment = object[@"Comment"];
    cell.lekkerComment.text = newComment;
    
//    PFFile *thumbnail = [object objectForKey:@"imageFile"];
//    cell.imageThumbnail 
    
//Need to put category image view here, too, once we figure this out, so it can display the right color!!! AAAAAAAHHHHHHHHH!!!!!
    
    return cell;
}

// Took the following out because it's not in recipe tutorial.
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
