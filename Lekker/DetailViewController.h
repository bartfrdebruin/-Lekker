//
//  DetailViewController.h
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/11/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lekker.h"

@interface DetailViewController : UIViewController <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *lekkerImage;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (strong, nonatomic) PFObject *detailViewObject;

@property (nonatomic, strong) UIBarButtonItem *list;

@end
