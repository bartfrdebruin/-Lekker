//
//  Lekker.h
//  Lekker
//
//  Created by Alyson Vivattanapa on 11/6/15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface Lekker : PFObject

@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *lekkerComment;

//add property for category image view later

@end
