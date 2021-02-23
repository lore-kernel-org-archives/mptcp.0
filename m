Content-Type: multipart/mixed; boundary="===============7635859637267565592=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/4] mptcp: a bunch of fixes
Date: Tue, 23 Feb 2021 03:10:08 +0000
Message-ID: <
 <161404980823.7081.9095170388881116560.git-patchwork-notify@kernel.org>>
In-Reply-To: cover.1613755058.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7906

--===============7635859637267565592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Fri, 19 Feb 2021 18:35:36 +0100 you wrote:
> This series bundle a few MPTCP fixes for the current net tree.
> They have been detected via syzkaller and packetdrill
> =

> Patch 1 fixes a slow close for orphaned sockets
> =

> Patch 2 fixes another hangup at close time, when no
> data was actually transmitted before close
> =

> [...]

Here is the summary with links:
  - [net,1/4] mptcp: fix DATA_FIN processing for orphaned sockets
    https://git.kernel.org/netdev/net/c/341c65242fe1
  - [net,2/4] mptcp: fix DATA_FIN generation on early shutdown
    https://git.kernel.org/netdev/net/c/d87903b63e3c
  - [net,3/4] mptcp: provide subflow aware release function
    https://git.kernel.org/netdev/net/c/ad98dd37051e
  - [net,4/4] mptcp: do not wakeup listener for MPJ subflows
    https://git.kernel.org/netdev/net/c/52557dbc7538

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============7635859637267565592==--
