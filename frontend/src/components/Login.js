import React from 'react';
import keycloak from "../keycloak";

class Login extends React.Component {
  componentDidMount() {
    keycloak.login({
      redirectUri: window.location.origin,
    })
  }

  render() {
    return null;
  }
}

export default Login;
