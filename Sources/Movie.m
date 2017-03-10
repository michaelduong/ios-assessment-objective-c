//
//  Movie.m
//  MovieSearch
//
//  Created by Nick Reichard on 3/10/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

// Note: Practice the different models. EarthImages vs. Podex ??? 

#import "Movie.h"

@implementation Movie

-(instancetype)initWithMovieTitle:(NSString *)title rating:(NSString *)rating overview:(NSString *)overview posterPath:(NSString *)posterPath
{
    self = [super init]; {
        _title = [title copy];
        _rating = [rating copy];
        _overview = [overview copy];
        posterPath = [posterPath copy];  // Note: for next week: more like Earth image or Pokedex?
    }
    return self; 
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary

{
    NSString *title = dictionary[@"title"];
    NSString *rating = dictionary[@"vote_average"];
    NSString *overview = dictionary[@"overview"];
    NSString *posterURL = dictionary[@"poster_path"];
    
    return [self initWithMovieTitle:title rating:rating overview:overview posterPath:posterURL];
    
}

@end
