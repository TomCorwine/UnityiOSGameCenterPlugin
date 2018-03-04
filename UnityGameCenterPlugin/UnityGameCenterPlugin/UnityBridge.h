//
//  UnityBridge.h
//  UnityGameCenterPlugin
//
//  Created by Tom Corwine on 3/3/18.
//  Copyright © 2018 Tom Corwine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UGCGame.h"

#ifdef __cplusplus
extern “C” {
#endif

typedef void (*UGCGameSaveDelegate)(bool success, const char *errorString);
void framework_setSaveDelegate(UGCGameSaveDelegate callback);

typedef void (*UGCGameLoadDelegate)(const char *dictionaryString, const char *errorString);
void framework_setLoadDelegate(UGCGameLoadDelegate callback);

void framework_saveGame(const char *dictionaryString);
void framework_loadGame(void);

#ifdef __cplusplus
}
#endif
