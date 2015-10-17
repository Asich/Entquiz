#import <Foundation/Foundation.h>

@interface RoundCategory : NSObject {

    NSNumber *roundCategoryId;
    NSString *name;

}

@property (nonatomic, copy) NSNumber *roundCategoryId;
@property (nonatomic, copy) NSString *name;

+ (RoundCategory *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
