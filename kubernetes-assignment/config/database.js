
username = process.env.DB_HOST
password = process.env.DB_PASSWORD

module.exports = {
  // mongoURI: `mongodb://${username}:${password}@mongodb`
  // mongoURI: `mongodb://${username}:${password}@localhost:27017`
  // mongoURI: `mongodb://${username}:${password}@mongodb-service.default.svc.cluster.local:27017`
  mongoURI: 'mongodb://mongodb-service.default.svc.cluster.local:27017'
}