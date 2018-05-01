//
//  TRLMovie.h
//  Movie Search ObjC
//
//  Created by Michael Duong on 2/16/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRLMovie : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(instancetype)initWithMovieTitle:(NSString *)title rating:(NSNumber *)rating overview:(NSString *)overview;

@property(nonatomic, copy, readonly)NSString*title;
@property(nonatomic, copy, readonly, nonnull)NSNumber*rating;
@property(nonatomic, copy, readonly)NSString*overview;

@end
