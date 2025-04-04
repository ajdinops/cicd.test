import { UltraDns } from './ultraDNSProvider';

export interface CreateUltraDNSFunction {
  (name: string, args: UltraDNSInputs): UltraDns;
}

export interface UltraDNSInputs {
  zone: string;
  name: string;
  type: string;
  ttl: number;
  rdata: string[];
}

export interface AuthToken {
  tokenType: string;
  refreshToken: string;
  accessToken: string;
  expiresIn: string;
  username: string;
  refresh_token: string;
  access_token: string;
  expires_in: string;
  token_type: string;
}