//
//  LekkerAnnotations.h
//  Lekker
//
//  Created by Bart de Bruin on 10-11-15.
//  Copyright © 2015 Bart & Alyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface LekkerAnnotations : NSObject <MKAnnotation> 

@property (nonatomic, strong) PFObject *lekkerObject;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSString *title;

- (id)initWithObject:(PFObject *)object;

@end
