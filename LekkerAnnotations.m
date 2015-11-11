//
//  LekkerAnnotations.m
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "LekkerAnnotations.h"

@interface LekkerAnnotations () <MKAnnotation> 

@property (nonatomic) CLLocationCoordinate2D myCoordinate;
@property (nonatomic, strong) NSString *myTitle;
@property (nonatomic, strong) NSString *mySubtitle;

@end



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

- (NSString *)title {
    
    return self.myTitle;
}

- (NSString *)subtitle {
    
    return self.mySubtitle;
}

@end
