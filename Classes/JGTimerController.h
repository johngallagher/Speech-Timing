#import "AbstractSingletonObject.h"

@interface JGTimerController : AbstractSingletonObject {
    NSNumber *duration;
}

@property (nonatomic, retain) NSNumber *duration;

-(NSUInteger)durationValue;

-(void)setDurationValue:(NSUInteger)value_;

-(void)startTimer;




@end

