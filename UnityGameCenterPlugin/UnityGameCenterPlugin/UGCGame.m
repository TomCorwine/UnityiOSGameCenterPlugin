//
//  UGCGame.m
//  UnityGameCenterPlugin
//
//  Created by Tom Corwine on 3/3/18.
//  Copyright © 2018 Tom Corwine. All rights reserved.
//

#import "UGCGame.h"

#import <GameKit/GameKit.h>

@implementation UGCGame

static id<UGCGameDelegate> _delegate = nil;

+ (void)setDelegate:(id<UGCGameDelegate>)delegate
{
    _delegate = delegate;
}

+ (void)saveGameToGameCenter:(NSData *)data
{
    GKLocalPlayer *localPLayer = [GKLocalPlayer localPlayer];

    [localPLayer saveGameData:data withName:@"default" completionHandler:^(GKSavedGame * _Nullable savedGame, NSError * _Nullable error) {
        if ([_delegate respondsToSelector:@selector(gameSaved:error:)]) {
            [_delegate gameSaved:(nil == error) error:error];
        }
    }];
}

+ (void)loadGameFromGameCenter
{
    GKLocalPlayer *localPLayer = [GKLocalPlayer localPlayer];

    [localPLayer fetchSavedGamesWithCompletionHandler:^(NSArray<GKSavedGame *> * _Nullable savedGames, NSError * _Nullable error) {

        GKSavedGame *defaultSavedGame;

        for (GKSavedGame *savedGame in savedGames)
        {
            if ([savedGame.name isEqualToString:@"default"])
            {
                defaultSavedGame = savedGame;
                break;
            }
        }

        if (defaultSavedGame)
        {
            [defaultSavedGame loadDataWithCompletionHandler:^(NSData * _Nullable data, NSError * _Nullable error) {
                if ([_delegate respondsToSelector:@selector(gameLoaded:error:)]) {
                    [_delegate gameLoaded:data error:error];
                }
            }];
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(gameLoaded:error:)]) {
                [_delegate gameLoaded:nil error:error];
            }
        }
    }];
}

@end
