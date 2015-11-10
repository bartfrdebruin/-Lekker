//
//  LekkerAnnotations.m
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "LekkerAnnotations.h"

@implementation LekkerAnnotations 

- (id) initWithTitle:(NSString *)annotationTitle location:(CLLocationCoordinate2D)location {
    
    self = [super init];
    
    if (self) {
        self.coordinate = location;
    }
    
    return self;
}

- (MKAnnotationView *)annotationView {
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"LekkerAnnotations"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

@end
