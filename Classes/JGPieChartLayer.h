//
//  PacmanLayer.h
//  Pacman
//
//  Created by Romain Vincens on 08/03/2011.
//  Copyright 2011 Nomad Planet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class JGPieChartAnimation;


@interface JGPieChartLayer : CALayer {
    CGFloat startAngle;
    CGFloat endAngle;

    JGPieChartAnimation *pieChartAnimation;
}

@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;
@property(nonatomic, retain) JGPieChartAnimation *pieChartAnimation;


-(id)initWithPieChartAnimation:(JGPieChartAnimation *)aPieChartAnimation andFrame:(CGRect)frame_;

-(id)lastValueForKey:(NSString *)key;

@end
