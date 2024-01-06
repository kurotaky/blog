import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["ethAddress", "newUser", "ethSignature", "ethMessage", "newSession"];

  connectToWallet() {
    if (typeof window.ethereum !== 'undefined') {
      this.requestAccounts();
    } else {
      console.error("Ethereum object not found");
    }
  }

  connect() {
    if (typeof window.ethereum === 'undefined') {
      this.element.textContent = "No Ethereum Context Available";
      this.element.disabled = true;
    } else {
      this.hideFields();
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
    } catch (error) {u
      console.error("Error requesting accounts:", error);
    }
  }

  async loginWithEthereum() {
    this.element.disabled = true;

    const accounts = await this.requestAccounts();
    const etherbase = accounts[0];
    const nonce = await this.getUuidByAccount(etherbase);

    if (nonce) {
      const customTitle = "blog";
      const requestTime = new Date().getTime();
      const message = `${customTitle},${requestTime},${nonce}`;
      const signature = await this.personalSign(etherbase, message);

      this.ethMessageTarget.value = message;
      this.ethAddressTarget.value = etherbase;
      this.ethSignatureTarget.value = signature;
      this.newSessionTarget.submit();
    } else {
      this.ethMessageTarget.value = "Please sign up first!";
    }
  }

  hideFields() {
    this.ethMessageTarget.hidden = true;
    this.ethAddressTarget.hidden = true;
    this.ethSignatureTarget.hidden = true;
  }

  async requestAccounts() {
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
    return accounts;
  }

  async personalSign(account, message) {
    const signature = await ethereum.request({ method: 'personal_sign', params: [message, account] });
    return signature;
  }

  async getUuidByAccount(account) {
    const response = await fetch(`/api/v1/users/${account}`);
    const nonceJson = await response.json();
    return nonceJson ? nonceJson[0].eth_nonce : null;
  }

}
