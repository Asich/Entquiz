#import "GameRound.h"
#import "RoundData.h"
#import "GameRoundCreatedAt.h"
#import "RoundCategory.h"

@implementation GameRound

@synthesize createdAt;
@synthesize data;
@synthesize userOneId;

+ (GameRound *)instanceFromDictionary:(NSDictionary *)aDictionary {

    GameRound *instance = [[GameRound alloc] init];
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

    if ([key isEqualToString:@"createdAt"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.createdAt = [GameRoundCreatedAt instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"data"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                RoundData *populatedMember = [RoundData instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.data = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}

#pragma mark -

- (RoundData *)getRoundDataByRoundCategory:(RoundCategory *)roundCategory {
    for (RoundData *roundData in self.data) {
        if ([roundData.category isEqual:roundCategory]) {
            return roundData;
        }
    }
    return nil;
}

@end
