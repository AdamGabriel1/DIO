import { UserController } from "./UserController";
import { UserService } from '../services/UserService'
import { Request } from 'express'
import { makeMockResponse } from "../__mocks__/mockResponse.mock";

it('Deve retornar status 400 se o nome não for fornecido', () => {
  const mockRequest = makeMockRequest({
    body: {
      email: 'nath@test.com',
    },
  });

  const mockResponse = makeMockResponse();
  userController.createUser(mockRequest, mockResponse);
  expect(mockResponse.state.status).toBe(400);
  expect(mockResponse.state.json).toMatchObject({ message: 'Bad request! Name obrigatório' });
});

it('Deve retornar status 400 se o email não for fornecido', () => {
  const mockRequest = makeMockRequest({
    body: {
      name: 'Nath',
    },
  });

  const mockResponse = makeMockResponse();
  userController.createUser(mockRequest, mockResponse);
  expect(mockResponse.state.status).toBe(400);
  expect(mockResponse.state.json).toMatchObject({ message: 'Bad request! Email obrigatório' });
});
