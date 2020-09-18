import Keycloak from 'keycloak-js'
import { keycloakUrl, keycloakRealm, keycloakClientId } from './config'

const keycloak = new Keycloak({
    url: keycloakUrl,
    realm: keycloakRealm,
    clientId: keycloakClientId,
})

export default keycloak
