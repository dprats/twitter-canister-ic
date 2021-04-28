import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as twitter_clone_idl, canisterId as twitter_clone_id } from 'dfx-generated/twitter_clone';

const agent = new HttpAgent();
const twitter_clone = Actor.createActor(twitter_clone_idl, { agent, canisterId: twitter_clone_id });

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  const greeting = await twitter_clone.greet(name);

  document.getElementById("greeting").innerText = greeting;
});
