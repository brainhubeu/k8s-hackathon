import {Injectable} from '@nestjs/common';
import KcAdminClient from 'keycloak-admin';
import axios from 'axios';
import {CreateUserDto} from './dto';
import {UserRO} from './user.interface';
import * as config from '../config'

@Injectable()
export class UserService {
  async create(dto: CreateUserDto): Promise<UserRO> {
    const client = new KcAdminClient({
      baseUrl: config.keycloakUrl,
      realmName: config.keycloakRealmName
    })

    await client.auth({
      grantType: 'client_credentials',
      username: null,
      password: null,
      clientId: config.keycloakAdminClientId,
      clientSecret: config.keycloakAdminClientSecret
    })

    await client.users.create({
      enabled: true,
      username: dto.username,
      email: dto.email,
      credentials: [
        { type: 'password', value: dto.password }
      ],
    })

    const response = await axios.post(config.contentApiUrl + '/users', {
      user: {
        username: dto.username,
        email: dto.email
      }
    })

    return response.data
  }
}
