package com.example.barbershop.service;

import com.example.barbershop.model.Cliente;
import com.example.barbershop.repository.ClienteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ClienteService {
    private final ClienteRepository repository;

    public Cliente cadastrarCliente(Cliente cliente) {
        return repository.save(cliente);
    }
}
