//
//  TRLMovie.m
//  Movie Search ObjC
//
//  Created by Michael Duong on 2/16/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

#import "TRLMovie.h"

@implementation TRLMovie

-(instancetype)initWithMovieTitle:(NSString *)title rating:(NSNumber *)rating overview:(NSString *)overview
{
    self = [super init]; {
        _title = [title copy];
        _rating = [rating copy];
        _overview = [overview copy];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *overview = dictionary[@"overview"];
    
    return [self initWithMovieTitle:title rating:rating overview: overview];
}

@end
