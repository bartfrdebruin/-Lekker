//
//  AddLekkerViewController.h
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/4/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface AddLekkerViewController : UIViewController <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage *photo;

@end
