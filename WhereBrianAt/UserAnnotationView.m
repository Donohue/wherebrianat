//
//  UserAnnotationView.m
//  Echo
//
//  Created by Brian Donohue on 6/20/12.
//  Copyright (c) 2012 Echolocation, Inc. All rights reserved.
//

#import "UserAnnotationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UserAnnotationView

#define kContainerHeight 54.0
#define kContainerWidth 48.0
#define kPictureWidth 40.0
#define kPictureHeight 40.0

- (id)initWithAnnotation:(id<MKAnnotation>)annotation
         reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        UIImageView *container = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropperblue.png"]];
        UIImageView *user_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brian_profile.jpg"]];
        user_image.frame = CGRectMake((kContainerWidth - kPictureWidth) / 2,
                                      (kContainerWidth - kPictureHeight) / 2,
                                      kPictureWidth, kPictureHeight);
        user_image.layer.cornerRadius = kPictureWidth / 2;
        user_image.layer.masksToBounds = YES;
        user_image.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:user_image];
        [self addSubview:container];
        
        self.frame = CGRectMake(0, 0, kContainerWidth, kContainerHeight);
        self.centerOffset = CGPointMake(0, -kContainerHeight / 2);
    }
    return self;
}

@end
