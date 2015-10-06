#import <Foundation/Foundation.h>

@class QuestionQues;

@interface Question : NSObject {

    NSArray *answers;
    QuestionQues *ques;

}

@property (nonatomic, copy) NSArray *answers;
@property (nonatomic, strong) QuestionQues *ques;

+ (Question *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
