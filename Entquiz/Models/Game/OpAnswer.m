#import "OpAnswer.h"

@implementation OpAnswer

@synthesize a1Id;
@synthesize a2Id;
@synthesize a3Id;
@synthesize catId;
@synthesize q1Id;
@synthesize q2Id;
@synthesize q3Id;
@synthesize roundId;

+ (OpAnswer *)instanceFromDictionary:(NSDictionary *)aDictionary {

    OpAnswer *instance = [[OpAnswer alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    objectData = aDictionary;

    self.a1Id = [self numberValueForKey:@"a1Id"];
    self.a2Id = [self numberValueForKey:@"a2Id"];
    self.a3Id = [self numberValueForKey:@"a3Id"];
    self.catId = [self numberValueForKey:@"catId"];
    self.q1Id = [self numberValueForKey:@"q1Id"];
    self.q2Id = [self numberValueForKey:@"q2Id"];
    self.q3Id = [self numberValueForKey:@"q3Id"];
    self.roundId = [self numberValueForKey:@"roundId"];

    objectData = nil;

}


@end
