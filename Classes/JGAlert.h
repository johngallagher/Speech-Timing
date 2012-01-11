#import <Foundation/Foundation.h>


@interface JGAlert : NSObject {
    NSDate *fireTime;
    NSDate *startTime;
}
@property(nonatomic, retain) NSDate *startTime;
@property(nonatomic, retain) NSDate *fireTime;


-(NSTimeInterval)duration;
@end