//
//  LekkerAnnotations.m
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "LekkerAnnotations.h"

@interface LekkerAnnotations () 

@end

@implementation LekkerAnnotations

- (instancetype _Nonnull)initWithObject:(PFObject*)object {
    
    self = [super init];
    if (self) {
        self.lekkerObject = object;
        
        PFGeoPoint *geopoint = object[@"location"];
        
        self.coordinate = CLLocationCoordinate2DMake(geopoint.latitude, geopoint.longitude);
        
        NSString *comment = object[@"comment"];
        
        self.title = comment;
        
    }
    return self;
    
}


@end
