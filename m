Content-Type: multipart/mixed; boundary="===============1281166718492954198=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] ipv6: weaken the v4mapped source check
Date: Thu, 18 Mar 2021 18:30:39 +0000
Message-ID: <
 <161609223954.5907.2664426590302968288.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210317165515.1914146-1-kuba@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 8212

--===============1281166718492954198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Wed, 17 Mar 2021 09:55:15 -0700 you wrote:
> This reverts commit 6af1799aaf3f1bc8defedddfa00df3192445bbf3.
> =

> Commit 6af1799aaf3f ("ipv6: drop incoming packets having a v4mapped
> source address") introduced an input check against v4mapped addresses.
> Use of such addresses on the wire is indeed questionable and not
> allowed on public Internet. As the commit pointed out
> =

> [...]

Here is the summary with links:
  - [net] ipv6: weaken the v4mapped source check
    https://git.kernel.org/netdev/net/c/dcc32f4f183a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============1281166718492954198==--
