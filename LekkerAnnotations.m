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
        
<<<<<<< HEAD
        self.coordinate = CLLocationCoordinate2DMake(geopoint.latitude, geopoint.longitude);
                
=======
        coordinate = CLLocationCoordinate2DMake(geopoint.latitude, geopoint.longitude);
        
        
>>>>>>> e74618a218d8d0d810f07996b4f98e8f3f32becf
    }
    return self;
    
}


@end
