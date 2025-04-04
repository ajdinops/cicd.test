import { CreateUltraDNSFunction } from './type';
import { UltraDns } from './ultraDNSProvider';

export const CreateUltraDNS: CreateUltraDNSFunction = (name, args) => {
  const udn = new UltraDns(name, args);

  //console.log(JSON.stringify(udn));

  return udn;
};