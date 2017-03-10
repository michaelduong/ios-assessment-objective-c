//
//  Movie.h
//  MovieSearch
//
//  Created by Nick Reichard on 3/10/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

// Note: SHOULD HAVE DONE NLRMovie!!!! - indstury practice 

#import <Foundation/Foundation.h>

@interface Movie : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(instancetype)initWithMovieTitle:(NSString *)title rating:(NSString *)rating overview:(NSString *)overview posterPath:(NSString *)posterPath;

@property(nonatomic, copy, readonly)NSString*title;
@property(nonatomic, copy, readonly)NSString*rating;           // vote_average Double?
@property(nonatomic, copy, readonly)NSString*overview;
@property(nonatomic, copy, readonly)NSString*posterURL;

@end
