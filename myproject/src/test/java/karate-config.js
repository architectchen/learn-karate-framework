function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    conduitApiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    config.email = 'conduit@example.com'
    config.password = 'conduit@example.com'
  } else if (env == 'e2e') {
    // customize
  }
  var token = karate.callSingle('classpath:helper/GenerateTokenHelper.feature', config).token
  karate.configure('headers', {"Authorization": "Token " + token})
  return config;
}