//
//  UGCGame.h
//  UnityGameCenterPlugin
//
//  Created by Tom Corwine on 3/3/18.
//  Copyright © 2018 Tom Corwine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UGCGameDelegate<NSObject>
- (void)gameSaved:(BOOL)success error:(NSError *)error;
- (void)gameLoaded:(NSData *)data error:(NSError *)error;
@end

@interface UGCGame : NSObject

+ (void)setDelegate:(id<UGCGameDelegate>)delegate;

+ (void)saveGameToGameCenter:(NSData *)data;
+ (void)loadGameFromGameCenter;

@end
