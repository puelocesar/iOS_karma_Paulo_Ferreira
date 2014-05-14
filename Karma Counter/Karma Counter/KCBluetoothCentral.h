//
//  KCBluetoothCentral.h
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import <Foundation/Foundation.h>
#import "KCBluetoothPeripheral.h"
#import "KCAvatarView.h"

@protocol KCBluetoothCentralDelegate <NSObject>
- (void)registeredNewPeripheral: (KCAvatarData*) data;
- (void)removedPeripheral: (NSString*) did;
@end

@interface KCBluetoothCentral : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, weak) id <KCBluetoothCentralDelegate> delegate;
@property (nonatomic, strong) NSMutableArray* peripherals;

//TODO: select the peripheral that will receive
- (void)sendKarma;

@end
