//
//  NLRMovie.h
//  MovieSearch
//
//  Created by Nick Reichard on 3/17/17.
//  Copyright © 2017 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NLRMovie : NSObject

@property(nonatomic, copy, readonly)NSString *title;
@property(nonatomic, copy, readonly)NSString *overview;
@property(nonatomic, readonly)NSInteger rating;
@property(nonatomic, strong)NSString *posterImage;       // What is the difference??
                                                        // Light weight generics?
                                                        // Light weight migrations?

-(instancetype)initWithTitle:(NSString *)title overview:(NSString *)overview rating:(NSUInteger)rating posterImage:(NSString *)posterImage;

@end

@interface NLRMovie (JSONConvertable)


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
