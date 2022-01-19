import type { Principal } from '@dfinity/principal';
export type Message = string;
export interface _SERVICE {
  'follow' : (arg_0: Principal) => Promise<undefined>,
  'follows' : () => Promise<Array<Principal>>,
  'greet' : (arg_0: string) => Promise<string>,
  'post' : (arg_0: string, arg_1: string) => Promise<undefined>,
  'posts' : () => Promise<Array<Message>>,
  'timeline' : () => Promise<Array<Message>>,
}
