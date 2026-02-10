import { DioAccount } from "./DioAccount";

export class CompanyAccount extends DioAccount {

  constructor(name: string, accountNumber: number) {
    super(name, accountNumber);
  }

  getLoan = (amount: number): void => {
    if (this['balance']) {
      this['balance'] += amount;
      console.log(`Empréstimo de ${amount} realizado. Novo saldo: ${this['balance']}`);
    } else {
      console.log("Conta desativada. Não é possível fazer empréstimos.");
    }
  }
}
