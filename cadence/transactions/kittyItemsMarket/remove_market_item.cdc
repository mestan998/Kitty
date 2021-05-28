import KittyItemsMarket from 0x4fc019cea9fc4817

transaction(itemID: UInt64) {
    let marketCollection: &KittyItemsMarket.Collection

    prepare(signer: AuthAccount) {
        self.marketCollection = signer.borrow<&KittyItemsMarket.Collection>(from: KittyItemsMarket.CollectionStoragePath)
            ?? panic("Missing or mis-typed KittyItemsMarket Collection")
    }

    execute {
        let offer <-self.marketCollection.remove(itemID: itemID)
        destroy offer
    }
}
