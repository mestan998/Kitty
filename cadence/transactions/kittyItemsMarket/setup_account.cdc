import KittyItemsMarket from 0x4fc019cea9fc4817

// This transaction configures an account to hold SaleOffer items.

transaction {
    prepare(signer: AuthAccount) {

        // if the account doesn't already have a collection
        if signer.borrow<&KittyItemsMarket.Collection>(from: KittyItemsMarket.CollectionStoragePath) == nil {

            // create a new empty collection
            let collection <- KittyItemsMarket.createEmptyCollection() as! @KittyItemsMarket.Collection
            
            // save it to the account
            signer.save(<-collection, to: KittyItemsMarket.CollectionStoragePath)

            // create a public capability for the collection
            signer.link<&KittyItemsMarket.Collection{KittyItemsMarket.CollectionPublic}>(KittyItemsMarket.CollectionPublicPath, target: KittyItemsMarket.CollectionStoragePath)
        }
    }
}
