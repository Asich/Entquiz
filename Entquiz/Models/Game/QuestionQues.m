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

@end
