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

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {

        self.answerId = [coder decodeObjectForKey:@"answerId"];
        self.img = [coder decodeObjectForKey:@"img"];
        self.isTrue = [coder decodeBoolForKey:@"isTrue"];
        self.quesId = [coder decodeObjectForKey:@"quesId"];
        self.title = [coder decodeObjectForKey:@"title"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:answerId forKey:@"answerId"];
    [coder encodeObject:img forKey:@"img"];
    [coder encodeBool:isTrue forKey:@"isTrue"];
    [coder encodeObject:quesId forKey:@"quesId"];
    [coder encodeObject:title forKey:@"title"];
}

@end
