import { Meta } from "../../source/interfaces/meta.interface";

export const responseMeta = (
  statusCode: number,
  message: string,
  status: string
) => {
  let now: Date = new Date();
  let resp: Meta;
  resp = {
    status,
    statusCode,
    timestamp: now,
    message,
  };
  return resp;
};