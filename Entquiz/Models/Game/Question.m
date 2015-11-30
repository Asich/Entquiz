#import "Question.h"

#import "Answer.h"
#import "QuestionQues.h"

@implementation Question

@synthesize answers;
@synthesize ques;

+ (Question *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Question *instance = [[Question alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    objectData = aDictionary;

    if ([objectData[@"answers"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[objectData[@"answers"] count]];
        for (id valueMember in objectData[@"answers"]) {
            Answer *populatedMember = [Answer instanceFromDictionary:valueMember];
            [myMembers addObject:populatedMember];
        }
        self.answers = myMembers;
    }

    if ([objectData[@"ques"] isKindOfClass:[NSDictionary class]]) {
        self.ques = [QuestionQues instanceFromDictionary:objectData[@"ques"]];
    }

    objectData = nil;

}


- (Answer *)getAnswerById:(NSNumber *)answerId {
    for (Answer *answer in self.answers) {
        if ([answer.answerId isEqualToNumber:answerId]) {
            return answer;
        }
    }
    return nil;
}



@end
