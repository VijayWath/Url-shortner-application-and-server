const password = encodeURIComponent("Omwath@2004");
const DB = `mongodb://127.0.0.1:27017/App-UrlShortner`;
const jwtPasswordKey = `JWT-${password}`;
const HashSecrete = `HASH-${password}`;

export { DB, jwtPasswordKey, HashSecrete };
