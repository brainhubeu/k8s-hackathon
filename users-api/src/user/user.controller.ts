import {Body, Controller, Post, UsePipes} from '@nestjs/common';
import {UserService} from './user.service';
import {CreateUserDto} from './dto';
import {ValidationPipe} from '../shared/pipes/validation.pipe';

import {ApiBearerAuth, ApiTags} from '@nestjs/swagger';

@ApiBearerAuth()
@ApiTags('user')
@Controller()
export class UserController {
  constructor(private readonly userService: UserService) {}

  @UsePipes(new ValidationPipe())
  @Post('users')
  async create(@Body('user') userData: CreateUserDto) {
    return this.userService.create(userData);
  }
}
