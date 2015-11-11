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

@interface LekkerAnnotations : NSObject

@property (nonatomic, strong) NSString *mySubtitle;
@property (nonatomic, strong) PFFile *imageFile;

- (id)initWithLocation:(CLLocationCoordinate2D)coord title:(NSString *)comment subtitle:(NSString*)category;


@end
