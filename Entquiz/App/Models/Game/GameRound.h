#import <Foundation/Foundation.h>

@class GameRoundCreatedAt;
@class RoundData;
@class RoundCategory;

@interface GameRound : NSObject {

    GameRoundCreatedAt *createdAt;
    NSArray *data;
    NSNumber *userOneId;

}

@property (nonatomic, strong) GameRoundCreatedAt *createdAt;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSNumber *userOneId;

+ (GameRound *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;


- (RoundData *)getRoundDataByRoundCategory:(RoundCategory *)roundCategory;

@end
