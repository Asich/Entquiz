//
// Created by Almas Adilbek on 4/9/14.
// Copyright (c) 2014 Crystal Spring LLC. All rights reserved.
//


#import "NSObject+Json.h"


@implementation NSObject (Json)

-(id)JSONValue {
    NSData * data = [[NSString stringWithString:(id) self] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(error) {
        return nil;
    }
    return object;
}

-(NSString *)JSONRepresentation {
    return [self JSONRepresentationPretyPrinted:NO];
}

- (NSString *)JSONRepresentationPretyPrinted:(BOOL)pretyPrinted {
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingOptions) (pretyPrinted ? NSJSONWritingPrettyPrinted : 0) error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (id)parseFromJsonFile:(NSString *)jsonFileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingOptions) kNilOptions error:nil];
}


@end