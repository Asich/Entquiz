#import "RoundData.h"

#import "RoundCategory.h"
#import "Question.h"

@implementation RoundData

@synthesize category;
@synthesize questions;

+ (RoundData *)instanceFromDictionary:(NSDictionary *)aDictionary {

    RoundData *instance = [[RoundData alloc] init];
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

    if ([key isEqualToString:@"category"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.category = [RoundCategory instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"questions"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Question *populatedMember = [Question instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.questions = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}



@end
