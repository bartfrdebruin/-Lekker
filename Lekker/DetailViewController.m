//
//  DetailViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/11/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "DetailViewController.h"
#import "ListViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:NO];
    
    UINavigationItem *detailNavigation = self.navigationItem;
    detailNavigation.title = @"#Lekker";
    
    UIBarButtonItem *list = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStylePlain target: self action:@selector(goToList:)];
    
    detailNavigation.rightBarButtonItem = list;
    
    PFFile *imageFile = self.detailViewObject [@"imageFile"];
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        self.lekkerImage.image = image;
    }];
    
    NSLog(@"%@", imageFile);
    
    self.commentLabel.text = [self.detailViewObject objectForKey:@"Comment"];
    
    self.categoryLabel.text = [self.detailViewObject objectForKey:@"category"];

}

#pragma mark - GoToList

- (IBAction)goToList:(id)sender {
    
    ListViewController *listView = [[ListViewController alloc] init];
    
    [self.navigationController pushViewController:listView animated:YES];
}


@end
