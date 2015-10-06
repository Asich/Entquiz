#import <Foundation/Foundation.h>

@interface GameRoundCreatedAt : NSObject {

    NSNumber *timestamp;

}

@property (nonatomic, copy) NSNumber *timestamp;

+ (GameRoundCreatedAt *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
