//
//  LekkerCell.h
//  Lekker
//
//  Created by Bart de Bruin on 04-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LekkerCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UILabel *lekkerComment;


@property (weak, nonatomic) IBOutlet UITextView *lekkerComment;

@property (weak, nonatomic) IBOutlet UIImageView *imageThumbnail;

@property (weak, nonatomic) IBOutlet UILabel *category;


@end
