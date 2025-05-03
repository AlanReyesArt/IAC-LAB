const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();
const TABLE_NAME = process.env.DYNAMODB_TABLE;

/**
 * 
 * 
 * @param {Object} event 
 * @param {Object} context 
 * @returns {Object} 
 */
exports.handler = async (event, context) => {
  console.log('Evento recibido:', JSON.stringify(event, null, 2));
  
  try {
    const { routeKey, pathParameters, body } = event;
    
    if (routeKey === 'POST /reservations') {
      return await createReservation(JSON.parse(body));
    } else if (routeKey === 'GET /reservations') {
      return await listReservations();
    } else if (routeKey === 'GET /reservations/{id}') {
      return await getReservation(pathParameters.id);
    } else {
      return createResponse(400, { 
        message: 'Ruta no soportada',
        routeKey
      });
    }
  } catch (error) {
    console.error('Error:', error);
    return createResponse(500, { 
      message: 'Error al procesar la solicitud',
      error: error.message
    });
  }
};

/**
 * 
 * @param {Object} reservationData 
 * @returns {Object} 
 */
async function createReservation(reservationData) {

  const { email, guest_name, room_type, check_in_date, check_out_date } = reservationData;
  
  if (!email || !guest_name || !room_type || !check_in_date || !check_out_date) {
    return createResponse(400, { 
      message: 'Faltan campos requeridos'
    });
  }
  
  const reservation_id = 'RES-' + Date.now().toString(36).toUpperCase() + 
                        Math.random().toString(36).substring(2, 8).toUpperCase();
  
  const params = {
    TableName: TABLE_NAME,
    Item: {
      reservation_id,
      email,
      guest_name,
      room_type,
      check_in_date,
      check_out_date,
      status: 'CONFIRMED',
      created_at: new Date().toISOString()
    }
  };
  
  await dynamodb.put(params).promise();
  
  return createResponse(201, { 
    message: 'Reservación creada exitosamente',
    reservation_id,
    email
  });
}

/**
 * 
 * @param {string} reservationId 
 * @returns {Object} 
 */
async function getReservation(reservationId) {
  if (!reservationId) {
    return createResponse(400, { message: 'ID de reservación requerido' });
  }
  
  const params = {
    TableName: TABLE_NAME,
    KeyConditionExpression: 'reservation_id = :id',
    ExpressionAttributeValues: {
      ':id': reservationId
    }
  };
  
  const result = await dynamodb.query(params).promise();
  
  if (!result.Items || result.Items.length === 0) {
    return createResponse(404, { message: 'Reservación no encontrada' });
  }
  
  return createResponse(200, { reservation: result.Items[0] });
}

/**
 * 
 * @returns {Object} 
 */
async function listReservations() {
  const params = {
    TableName: TABLE_NAME,
    Limit: 50
  };
  
  const result = await dynamodb.scan(params).promise();
  
  return createResponse(200, { 
    count: result.Items.length,
    reservations: result.Items
  });
}

/**
 * 
 * @param {number} statusCode 
 * @param {Object} body 
 * @returns {Object} 
 */
function createResponse(statusCode, body) {
  return {
    statusCode,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify(body)
  };
}