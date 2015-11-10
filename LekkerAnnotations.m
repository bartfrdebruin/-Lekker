//
//  LekkerAnnotations.m
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import "LekkerAnnotations.h"

@implementation LekkerAnnotations

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"Lekker"];
    
    return query;
}

- (id)initWithLocation:(CLLocationCoordinate2D)lekkerLocations {
    self = [super init];
    if (self) {
        
        coordinate = lekkerLocations;
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
