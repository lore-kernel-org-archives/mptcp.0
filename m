Content-Type: multipart/mixed; boundary="===============6129175429961586317=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/4] mptcp: a bunch of assorted fixes
Date: Thu, 17 Dec 2020 18:30:07 +0000
Message-ID: <
 <160822980777.23072.11158682843744324037.git-patchwork-notify@kernel.org>>
In-Reply-To: cover.1608114076.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7205

--===============6129175429961586317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Wed, 16 Dec 2020 12:48:31 +0100 you wrote:
> This series pulls a few fixes for the MPTCP datapath.
> Most issues addressed here has been recently introduced
> with the recent reworks, with the notable exception of
> the first patch, which addresses an issue present since
> the early days
> =

> Paolo Abeni (4):
>   mptcp: fix security context on server socket
>   mptcp: properly annotate nested lock
>   mptcp: push pending frames when subflow has free space
>   mptcp: fix pending data accounting
> =

> [...]

Here is the summary with links:
  - [net,1/4] mptcp: fix security context on server socket
    https://git.kernel.org/netdev/net/c/0c14846032f2
  - [net,2/4] mptcp: properly annotate nested lock
    https://git.kernel.org/netdev/net/c/3f8b2667f257
  - [net,3/4] mptcp: push pending frames when subflow has free space
    https://git.kernel.org/netdev/net/c/219d04992b68
  - [net,4/4] mptcp: fix pending data accounting
    https://git.kernel.org/netdev/net/c/13e1603739e5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============6129175429961586317==--
