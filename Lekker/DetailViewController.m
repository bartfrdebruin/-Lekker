//
//  DetailViewController.m
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/11/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lekkerImage.file = [self.detailViewObject objectForKey:@"imageFile"];
    
    self.commentLabel.text = [self.detailViewObject objectForKey:@"Comment"];
    
    self.categoryLabel.text = [self.detailViewObject objectForKey:@"category"];

}

@end
