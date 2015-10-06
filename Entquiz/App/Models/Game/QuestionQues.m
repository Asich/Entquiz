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

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"questionQuesId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}



@end
