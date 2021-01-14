Content-Type: multipart/mixed; boundary="===============2600213916641700118=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix locking in mptcp_disconnect()
Date: Thu, 14 Jan 2021 19:30:08 +0000
Message-ID: <
 <161065260845.1502.10098958825377599450.git-patchwork-notify@kernel.org>>
In-Reply-To: f818e82b58a556feeb71dcccc8bf1c87aafc6175.1610638176.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7391

--===============2600213916641700118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu, 14 Jan 2021 16:37:37 +0100 you wrote:
> tcp_disconnect() expects the caller acquires the sock lock,
> but mptcp_disconnect() is not doing that. Add the missing
> required lock.
> =

> Reported-by: Eric Dumazet <eric.dumazet(a)gmail.com>
> Fixes: 76e2a55d1625 ("mptcp: better msk-level shutdown.")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> [...]

Here is the summary with links:
  - [net] mptcp: fix locking in mptcp_disconnect()
    https://git.kernel.org/netdev/net/c/13a9499e8333

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============2600213916641700118==--
