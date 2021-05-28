import FungibleToken from 0x4fc019cea9fc4817
import Kibble from 0x4fc019cea9fc4817

transaction(recipient: Address, amount: 30000) {
    let tokenAdmin: &Kibble.Administrator
    let tokenReceiver: &{FungibleToken.Receiver}

    prepare(signer: AuthAccount) {
        self.tokenAdmin = signer
        .borrow<&Kibble.Administrator>(from: Kibble.AdminStoragePath)
        ?? panic("Signer is not the token admin")

        self.tokenReceiver = getAccount(0x4fc019cea9fc4817)
        .getCapability(Kibble.ReceiverPublicPath)!
        .borrow<&{FungibleToken.Receiver}>()
        ?? panic("Unable to borrow receiver reference")
    }

    execute {
        let minter <- self.tokenAdmin.createNewMinter(allowedAmount: amount)
        let mintedVault <- minter.mintTokens(amount: amount)

        self.tokenReceiver.deposit(from: <-mintedVault)

        destroy minter
    }
}
