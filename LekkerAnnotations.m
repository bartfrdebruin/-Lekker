//
//  LekkerAnnotations.m
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "LekkerAnnotations.h"

@implementation LekkerAnnotations


- (id)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)comment subtitle:(NSString *)category {
    self = [super init];
    if (self) {
        
        self.myTitle = comment;
        self.mySubtitle = category;
        self.myCoordinate = coord;
    }
    return self;
}


- (CLLocationCoordinate2D)coordinate {
    
    return self.myCoordinate;
    
}


@end
