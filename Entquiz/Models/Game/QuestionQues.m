#import "QuestionQues.h"

@implementation QuestionQues

@synthesize catId;
@synthesize img;
@synthesize questionQuesId;
@synthesize title;

+ (QuestionQues *)instanceFromDictionary:(NSDictionary *)aDictionary {

    QuestionQues *instance = [[QuestionQues alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    objectData = aDictionary;

    self.catId = [self numberValueForKey:@"catId"];
    self.img = [self stringValueForKey:@"img"];
    self.questionQuesId = [self numberValueForKey:@"id"];
    self.title = [self stringValueForKey:@"title"];

    objectData = nil;

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {

        self.catId = [coder decodeObjectForKey:@"catId"];
        self.img = [coder decodeObjectForKey:@"img"];
        self.questionQuesId = [coder decodeObjectForKey:@"questionQuesId"];
        self.title = [coder decodeObjectForKey:@"title"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:catId forKey:@"catId"];
    [coder encodeObject:img forKey:@"img"];
    [coder encodeObject:questionQuesId forKey:@"questionQuesId"];
    [coder encodeObject:title forKey:@"title"];
}

@end
