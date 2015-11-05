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

#pragma mark Array

- (id)init {
    self = [super init];
    if (self) {
        self.titleCell = @[@"Dish1", @"Dish2", @"Dish3", @"Dish4"];
        self.vegetables = @[@"Paprika", @"Aubergine", @"Wortelen", @"Tomaten"];
        self.meat = @[@"Beef", @"Lamb", @"Chicken", @"Pork", @"Goat"];
        self.distance =@[@"500m", @"600m", @"700m", @"800m"];
        self.categories =@[@"red",@"Blue", @"Green", @"Pink"];
        self.comment =@[@"blabla1",@"blabla2", @"blabla3", @"blabla4"];
    }
    
    return self;
}

#pragma mark TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.meat count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(LekkerCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.title.text = [self.titleCell objectAtIndex:indexPath.row];
    cell.distance.text = [self.distance objectAtIndex:indexPath.row];
    cell.lekkerComment.text = [self.comment objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LekkerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"LekkerCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    }
    
    return cell;
}



#pragma mark ViewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
  }



@end
