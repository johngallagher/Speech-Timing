#import <Foundation/Foundation.h>


@interface JGAlert : NSObject {
    NSDate *_fireTime;
    NSDate *_startTime;
    NSString *_name;
}


// TODO make factory method alertStartingNowWithDuration
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSDate *startTime;
@property(nonatomic, readonly) NSDate *fireTime;


+(id)alertWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ name:(NSString *)name_;

-(id)initWithStartTime:(NSDate *)startTime_ fireTime:(id)fireTime_ name:(id)name_;


-(NSTimeInterval)duration;
@end