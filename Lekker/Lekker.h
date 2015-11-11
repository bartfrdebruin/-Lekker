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

@interface Lekker : NSObject

@property (strong, nonatomic) PFFile *imageFile;
@property (strong, nonatomic) NSString *lekkerComment;
@property (strong, nonatomic) NSString *category;

//add property for category image view later

@end
