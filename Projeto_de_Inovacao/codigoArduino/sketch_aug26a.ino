// Definições
const int PINO_SENSOR_TEMPERATURA = A0;  // Seleciona o pino que será utilizado para receber a temperatura
float temperaturaCelsius;                // Define a temperatura como floar

// Preparação
void setup() {
  Serial.begin(9600);  // Inicia a comunicação entre o Arduino e o computador
}

// Execução
void loop() {
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);     // Define a váriavel do valor bruto de leitura, capturado pelo pino A0
  temperaturaCelsius = (valorLeitura * 5.0 / 1023.0) / 0.01;  // Faz o calculo de conversão do valor bruto para a temperatura em Celsius

  // Imprime na output os textos padrões e o valor tratado em Celsius
  Serial.print("TempMaximo:");
  Serial.print(26);
  Serial.print(" ");
  Serial.print("Temperatura:");
  Serial.print(temperaturaCelsius);
  Serial.print(" ");
  Serial.print("TempMinimo:");
  Serial.println(20);

  delay(2000);  // Define um delay de 2 segundos para realizar a próxima leitura
}
