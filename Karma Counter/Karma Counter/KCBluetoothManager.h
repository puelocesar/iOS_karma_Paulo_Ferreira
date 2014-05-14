//
//  KCBluetoothManager.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import "KCBluetoothCentral.h"

@interface KCBluetoothManager : NSObject

- (void) sendKarma;

- (void) setReceiveKarmaDelegate: (id <KCBluetoothPeripheralDelegate>) delegate;

- (void) setRegisteredDevicesDelegate: (id <KCBluetoothCentralDelegate>) delegate;

@end
