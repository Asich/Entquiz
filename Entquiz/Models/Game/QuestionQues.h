#import <Foundation/Foundation.h>
#import "ModelObject.h"

@interface QuestionQues : ModelObject {

    NSNumber *catId;
    NSString *img;
    NSNumber *questionQuesId;
    NSString *title;

}

@property (nonatomic, copy) NSNumber *catId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSNumber *questionQuesId;
@property (nonatomic, copy) NSString *title;

+ (QuestionQues *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
