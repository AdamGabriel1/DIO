import { Component } from '@angular/core';
import { ClienteService } from '../../services/cliente.service';
import { Cliente } from '../../models/cliente.model';

@Component({
  selector: 'app-cadastro-cliente',
  templateUrl: './cadastro-cliente.component.html',
  styleUrls: ['./cadastro-cliente.component.css']
})
export class CadastroClienteComponent {
  cliente: Cliente = { nome: '', telefone: '', email: '' };

  constructor(private clienteService: ClienteService) {}

  onSubmit() {
    this.clienteService.cadastrarCliente(this.cliente).subscribe(response => {
      alert('Cliente cadastrado com sucesso!');
    });
  }
}
