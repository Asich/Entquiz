#import "Answer.h"

@implementation Answer

@synthesize answerId;
@synthesize img;
@synthesize isTrue;
@synthesize quesId;
@synthesize title;

+ (Answer *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Answer *instance = [[Answer alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    objectData = aDictionary;

    self.answerId = [self numberValueForKey:@"id"];
    self.img = [self stringValueForKey:@"img"];
    self.isTrue = [self boolValueForKey:@"isTrue"];
    self.quesId = [self numberValueForKey:@"quesId"];
    self.title = [self stringValueForKey:@"title"];

    objectData = nil;

}

@end
