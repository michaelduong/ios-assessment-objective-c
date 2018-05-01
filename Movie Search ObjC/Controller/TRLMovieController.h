//
//  TRLMovieController.h
//  Movie Search ObjC
//
//  Created by Michael Duong on 2/16/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TRLMovie;

@interface TRLMovieController : NSObject
+ (TRLMovieController *)shared;

+ (void) fetchMovieInfoWithTitle:(NSString *)title completion: (void(^)(NSArray* movies))completion;

@end

