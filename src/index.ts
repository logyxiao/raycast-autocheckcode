import { showHUD } from "@raycast/api";
import { exec } from "child_process";

export default async function main() {
  await exec(`sh ${__dirname}/assets/autocheckcode.sh`,function(err,stdout,stderr){
    if(err){
      console.log(err);
    }else{
      console.log('stdout',stdout);
      console.log('stderr',stderr);
    }
  })
  showHUD('autocheckcode done');
}
