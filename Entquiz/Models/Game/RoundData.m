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

    objectData = aDictionary;

    if ([objectData[@"category"] isKindOfClass:[NSDictionary class]]) {
        self.category = [RoundCategory instanceFromDictionary:objectData[@"category"]];
    }

    if ([objectData[@"questions"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[objectData[@"questions"] count]];
        for (id valueMember in objectData[@"questions"]) {
            Question *populatedMember = [Question instanceFromDictionary:valueMember];
            [myMembers addObject:populatedMember];
        }

        self.questions = myMembers;
    }

    objectData = nil;

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.questions = [coder decodeObjectForKey:@"questions"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:category forKey:@"category"];
    [coder encodeObject:questions forKey:@"questions"];
}


@end
