//
//  LekkerAnnotations.m
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "LekkerAnnotations.h"

@implementation LekkerAnnotations

@synthesize coordinate;


- (id)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)comment subtitle:(NSString *)category {
    self = [super init];
    if (self) {
        
        self.title = comment;
        self.subtitle = category;
        coordinate = coord;
    }
    return self;
}


@end
