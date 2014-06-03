//
//  UserAnnotationView.h
//  Echo
//
//  Created by Brian Donohue on 6/20/12.
//  Copyright (c) 2012 Echolocation, Inc. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface UserAnnotationView : MKAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier;

@end
