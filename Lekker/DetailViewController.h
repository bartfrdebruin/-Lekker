//
//  DetailViewController.h
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/11/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Lekker.h"

@interface DetailViewController : UIViewController <UINavigationControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *lekkerImage;

@property (weak, nonatomic) IBOutlet UITextView *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (strong, nonatomic) PFObject *detailViewObject;

@property (nonatomic, strong) UIBarButtonItem *list;

@property(nonatomic, readonly, nonnull) UIPanGestureRecognizer *panGestureRecognizer;

@end
