import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["ethAddress", "newUser"];

  connectToWallet() {
    if (typeof window.ethereum !== 'undefined') {
      this.requestAccounts();
    } else {
      console.error("Ethereum object not found");
    }
  }

  async requestAccounts() {
    try {
      const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
      this.ethAddressTarget.value = accounts[0];
      if (this.hasNewUserTarget) {
        this.newUserTarget.submit();
      } else {
        console.error("Missing target element 'newUser' for 'ethereum' controller");
      }
    } catch (error) {
      console.error("Error requesting accounts:", error);
    }
  }
}
