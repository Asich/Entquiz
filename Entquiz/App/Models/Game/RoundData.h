#import <Foundation/Foundation.h>

@class RoundCategory;

@interface RoundData : NSObject {

    RoundCategory *category;
    NSArray *questions;

}

@property (nonatomic, strong) RoundCategory *category;
@property (nonatomic, copy) NSArray *questions;

+ (RoundData *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
