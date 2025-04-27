using DesafioPOO.Models;

class Program
{
    static void Main()
    {
        Nokia nokia = new Nokia("123456789", "Nokia 8", "IMEI123", 64);
        nokia.Ligar();
        nokia.ReceberLigacao();
        nokia.InstalarAplicativo("WhatsApp");

        Iphone iphone = new Iphone("987654321", "iPhone 12", "IMEI456", 128);
        iphone.Ligar();
        iphone.ReceberLigacao();
        iphone.InstalarAplicativo("Instagram");
    }
}
