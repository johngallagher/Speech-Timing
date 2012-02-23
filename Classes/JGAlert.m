#import "JGAlert.h"
#import "JGTimerDefaults.h"
#define DEFAULT_NAME @"Digital Alarm 1"

@interface JGAlert ()

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSDate *fireTime;
@property(nonatomic, retain) NSDate *startTime;


@end

@implementation JGAlert


@synthesize name = _name;
@synthesize startTime = _startTime;
@synthesize fireTime = _fireTime;

-(id)init {
    self = [super init];
    if (self) {
        _name = DEFAULT_NAME;
    }

    return self;
}

+(id)alertWithName:(NSString *)name_ {
    return [self alertWithStartTime:nil fireTime:nil name:name_];
}

+(id)alertStartingNowWithDuration:(NSTimeInterval)duration_ name:(NSString *)name_ {
    return [self alertWithStartTime:[NSDate date] fireTime:[NSDate dateWithTimeIntervalSinceNow:duration_] name:name_];
}

+(id)alertWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ name:(NSString *)name_ {
    return [[[[self class] alloc] initWithStartTime:startTime_ fireTime:fireTime_ name:name_] autorelease];
}

-(id)initWithStartTime:(NSDate *)startTime_ fireTime:(NSDate *)fireTime_ name:(NSString *)name_ {
    self = [super init];
    if (self) {
        _startTime = [startTime_ retain];
        _fireTime = [fireTime_ retain];
        if (name_) {
            _name = [name_ retain];
        } else {
            _name = DEFAULT_NAME;
        }
    }

    return self;
}

-(NSTimeInterval)duration {
    return [_startTime timeIntervalSinceDate:_fireTime];
}

-(void)dealloc {
    [_startTime release];
    [_fireTime release];
    [_name release];
    [super dealloc];
}

-(NSString *)filenameWithoutExtension {
    return [[self name] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)updateNameFromDefaults {
    [self setName:[[JGTimerDefaults sharedInstance] alertName]];
}

-(NSString *)name {
    return _name;
}

-(NSDate *)startTime {
    return _startTime;
}

-(NSDate *)fireTime {
    return _fireTime;
}



-(void)saveToTimerDefaults {
    [[JGTimerDefaults sharedInstance] setStartTime:_startTime];
    [[JGTimerDefaults sharedInstance] setFireTime:_fireTime];
    [[JGTimerDefaults sharedInstance] setCurrentAlertName:_name];
}

@end