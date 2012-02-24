//
//  Created by John on 23/02/2012.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface JGPieChartAnimationParameters : NSObject {
    CGFloat        _fromAngle;
    CGFloat        _toAngle;
    NSTimeInterval _duration;
}

@property(nonatomic, readonly) CGFloat        fromAngle;
@property(nonatomic, readonly) CGFloat        toAngle;
@property(nonatomic, readonly) NSTimeInterval duration;

+(id)animationFromAngle:(CGFloat)fromAngle_ toAngle:(CGFloat)toAngle_ duration:(NSTimeInterval)duration_;

-(id)initFromAngle:(CGFloat)fromAngle_ toAngle:(CGFloat)toAngle_ duration:(NSTimeInterval)duration_;

@end