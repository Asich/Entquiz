#import "Question.h"

#import "Answer.h"
#import "QuestionQues.h"

@implementation Question

@synthesize answers;
@synthesize ques;

+ (Question *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Question *instance = [[Question alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"answers"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Answer *populatedMember = [Answer instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.answers = myMembers;

        }

    } else if ([key isEqualToString:@"ques"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.ques = [QuestionQues instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}



@end
