using System;

namespace DesafioPOO.Models
{
    public class Iphone : Smartphone
    {
        public Iphone(string numero, string modelo, string imei, int memoria)
            : base(numero, modelo, imei, memoria)
        {
            // Construtor da classe base já é chamado implicitamente
        }

        public override void InstalarAplicativo(string nome)
        {
            Console.WriteLine($"Instalando {nome} na plataforma iPhone...");
        }
    }
}
