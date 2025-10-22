import {prismaclient} from "@DB"

export default async function Home() {

  const user=await prismaclient.user.findMany()

  return (
    <div >
      {JSON.stringify(user)}
    </div>
  );
}

export const dynamic='force-dynamic'