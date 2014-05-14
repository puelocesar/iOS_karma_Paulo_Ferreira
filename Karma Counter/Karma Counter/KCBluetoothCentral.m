//
//  KCBluetoothCentral.m
//  Karma Counter
//
//  Created by Paulo Cesar Ferreira on 14/05/14.
//
//

#import "KCBluetoothCentral.h"

@implementation KCBluetoothCentral

CBCentralManager *centralManager;
CBUUID* karma_service_id;

-(id)init
{
    karma_service_id = [CBUUID UUIDWithString:UUID_SERVICE_STRING];
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    self.peripherals = [[NSMutableArray alloc] init];
    
    return self;
}

//center part: this will receive the karma
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [central scanForPeripheralsWithServices:@[karma_service_id] options:nil];
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"did discover peripheral");
    
    [self.peripherals addObject:peripheral];
    
    KCAvatarData* data = [[KCAvatarData alloc] init];
    data.name = @"teste";
    data.peripheral = peripheral;
    
    //adds this peripheral to the UI
    [self.delegate registeredNewPeripheral:data];
    
    //we will connect to it only we are in need to send data
}

- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

//delegate methods to peripheral
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error {
    
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error debugDescription]);
    }
    
    for (CBService *service in peripheral.services) {
        if ([service.UUID isEqual:karma_service_id])
            [peripheral discoverCharacteristics:nil forService:service];
    }
}

CBCharacteristic *karma_characteristic;

- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error debugDescription]);
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        [self sendsKarmaToPeripheral:peripheral withCharacteristic:characteristic];
    }
}

- (void)sendKarmaWithPeripheral: (CBPeripheral*) peripheral
{
    [centralManager connectPeripheral:peripheral options:nil];
}

- (void)sendsKarmaToPeripheral: (CBPeripheral*) peripheral withCharacteristic: (CBCharacteristic *) characteristic
{
    if (peripheral.state == CBPeripheralStateConnected) {
        int i = 1;
        NSData* value = [NSData dataWithBytes:&i length:sizeof(i)];
        
        [peripheral writeValue:value forCharacteristic:characteristic
                 type:CBCharacteristicWriteWithResponse];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error debugDescription]);
    }
    else {
        NSLog(@"value wrote with success");
        
        //cancelling connection as soon as possible
        [centralManager cancelPeripheralConnection:peripheral];
    }
}

@end
