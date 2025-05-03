## Sistema de Reservas de Hotel

Este proyecto implementa un sistema de reservas de hotel utilizando AWS Lambda, API Gateway y DynamoDB.

## Arquitectura

El sistema consta (por ahora) de los siguientes componentes:

1. *API Gateway*: Actúa como punto de entrada para las solicitudes HTTP
2. *AWS Lambda*: Procesa las solicitudes de reservación
3. *DynamoDB*: Almacena los datos de las reservaciones
4. *CloudWatch Logs*: Monitorea la aplicación

## Integraciones Implementadas

Este proyecto incluye las siguientes integraciones:

1. *Lambda + IAM (Roles y Políticas)*: Permisos necesarios para la ejecución de Lambda
2. *Lambda + CloudWatch Logs*: Monitoreo y registro de eventos
3. *Lambda + DynamoDB (Base de datos)*: Almacenamiento persistente de reservaciones

# IAC-LAB
