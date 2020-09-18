export interface UserData {
  username: string;
  email: string;
  bio: string;
  image?: string;
}

export interface UserRO {
  user: UserData;
}
