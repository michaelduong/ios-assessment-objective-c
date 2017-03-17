//
//  NLRMovie.m
//  MovieSearch
//
//  Created by Nick Reichard on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import "NLRMovie.h"

@implementation NLRMovie

-(instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview rating:(NSInteger)rating posterImage:(NSString *)posterImage
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _overview = [overview copy];
        _rating = rating;            //Should this be an NSinteger?
        _posterImage = [posterImage copy];
    }
    return self;
}

@end

@implementation NLRMovie (JSONConvertable)

// MARK: - JSONConvertible

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSString *overview = dictionary[@"overview"];
    NSInteger rating = [dictionary[@"vote_average"] integerValue];       // Should this be integervalue
    NSString *posterImage = dictionary[@"poster_path"];
    
    if (![title isKindOfClass:[NSString class]] || ![overview isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [self initWithTitle:title overview:overview rating:rating  posterImage:posterImage];
}
//Convenience initailizer - is a delegator initializer (swift)

@end
