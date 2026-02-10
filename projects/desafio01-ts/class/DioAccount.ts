export abstract class DioAccount {
  private name: string;
  private readonly accountNumber: number;
  balance: number = 0;
  private status: boolean = true;

  constructor(name: string, accountNumber: number) {
    this.name = name;
    this.accountNumber = accountNumber;
  }

  setName = (name: string): void => {
    this.name = name;
    console.log('Nome alterado com sucesso!');
  }

  getName = (): string => {
    return this.name;
  }

  deposit = (amount: number): void => {
    if (this.validateStatus()) {
      this.balance += amount;
      console.log(`Você depositou ${amount}. Novo saldo: ${this.balance}`);
    }
  }

  withdraw = (amount: number): void => {
    if (this.validateStatus() && this.balance >= amount) {
      this.balance -= amount;
      console.log(`Você sacou ${amount}. Novo saldo: ${this.balance}`);
    } else {
      console.log('Conta desativada ou saldo insuficiente. Não é possível fazer saques.');
    }
  }

  getBalance = (): void => {
    console.log(`Saldo atual: ${this.balance}`);
  }

  private validateStatus = (): boolean => {
    if (this.status) {
      return true;
    }

    throw new Error('Conta inválida');
  }
}
