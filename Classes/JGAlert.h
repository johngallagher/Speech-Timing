#import <Foundation/Foundation.h>


@interface JGAlert : NSObject {
    NSDate   *_fireTime;
    NSDate   *_startTime;
    NSString *_name;
}

+(id)alertWithName:(NSString *)name_;

+(id)alertStartingNowWithDuration:(NSTimeInterval)duration_ name:(NSString *)name_;

+(id)alertWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ name:(NSString *)name_;

-(id)initWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ name:(NSString *)name_;

-(NSTimeInterval)duration;

-(void)updateNameFromDefaults;

-(void)saveToTimerDefaults;

-(NSString *)name;

-(NSDate *)startTime;

-(NSDate *)fireTime;

-(NSString *)filenameWithoutExtension;

@end