import * as pulumi from '@pulumi/pulumi';
import axios from 'axios';
import * as querystring from 'querystring';
import { v4 as uuidv4 } from 'uuid';

import { AuthToken, UltraDNSInputs } from './type';

const getToken = async (): Promise<AuthToken> => {
  axios.defaults.baseURL = 'https://restapi.ultradns.com/v2';
  axios.defaults.headers.common['Content-Type'] = 'application/x-www-form-urlencoded';

  const payload = {
    grant_type: 'password',
    username: 'devsecops',
    password: 'x2ghBfQb4RvXeRZNCEeHa3afjAtYqoav',
  };

  const response = await axios.post('/authorization/token', querystring.stringify(payload));

  return response.data;
};

const ultraDNSProvider: pulumi.dynamic.ResourceProvider = {
  async create(inputs: UltraDNSInputs) {
    const token = await getToken();

    axios.defaults.baseURL = 'https://restapi.ultradns.com/v2';
    axios.defaults.headers.common.Authorization = 'Bearer ' + token.accessToken;
    axios.defaults.headers.common['Content-Type'] = 'application/json';

    // const payload = {
    //   ttl: inputs.ttl,
    //   rdata: inputs.rdata,
    // };

    const payload = pulumi.all([inputs.ttl, inputs.rdata]).apply(([ttl, rdata]) => ({
        ttl,
        rdata,
    }));

    await axios.post(`/zones/${inputs.zone}/rrsets/${inputs.type}/${inputs.name}`, payload);

    const id = 'udn-' + uuidv4();

    // return { id, outs: { ...inputs, id } };

    return {
        id: id,
        outs: { ...inputs, id: id },
    };
  },
  async update(_id: pulumi.ID, _olds: UltraDNSInputs, news: UltraDNSInputs) {
    const token = await getToken();

    axios.defaults.baseURL = 'https://restapi.ultradns.com/v2';
    axios.defaults.headers.common.Authorization = 'Bearer ' + token.accessToken;
    axios.defaults.headers.common['Content-Type'] = 'application/json';

    const payload = pulumi.all([news.ttl, news.rdata]).apply(([ttl, rdata]) => ({
        ttl,
        rdata,
    }));
    
    await axios.put(`/zones/${news.zone}/rrsets/${news.type}/${news.name}`, payload);

    return {
      outs: news,
    };
  },
  async delete(_id: pulumi.ID, props: UltraDNSInputs): Promise<void> {
    const token = await getToken();

    axios.defaults.baseURL = 'https://restapi.ultradns.com/v2';
    axios.defaults.headers.common.Authorization = 'Bearer ' + token.accessToken;
    axios.defaults.headers.common['Content-Type'] = 'application/json';

    await axios.delete(`/zones/${props.zone}/rrsets/${props.type}/${props.name}`);
  },
};

export class UltraDns extends pulumi.dynamic.Resource {
  constructor(name: string, args: UltraDNSInputs, opts?: pulumi.CustomResourceOptions) {
    super(ultraDNSProvider, name, args, opts);
  }
}