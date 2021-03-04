Content-Type: multipart/mixed; boundary="===============4712233266707311073=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/9] mptcp: Fixes for v5.12
Date: Thu, 04 Mar 2021 22:40:08 +0000
Message-ID: <
 <161489760875.17160.2919416232115076199.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210304213216.205472-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8037

--===============4712233266707311073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu,  4 Mar 2021 13:32:07 -0800 you wrote:
> These patches from the MPTCP tree fix a few multipath TCP issues:
> =

> =

> Patches 1 and 5 clear some stale pointers when subflows close.
> =

> Patches 2, 4, and 9 plug some memory leaks.
> =

> [...]

Here is the summary with links:
  - [net,1/9] mptcp: reset last_snd on subflow close
    https://git.kernel.org/netdev/net/c/e0be4931f3fe
  - [net,2/9] mptcp: put subflow sock on connect error
    https://git.kernel.org/netdev/net/c/f07157792c63
  - [net,3/9] mptcp: fix memory accounting on allocation error
    https://git.kernel.org/netdev/net/c/eaeef1ce55ec
  - [net,4/9] mptcp: dispose initial struct socket when its subflow is clos=
ed
    https://git.kernel.org/netdev/net/c/17aee05dc882
  - [net,5/9] mptcp: reset 'first' and ack_hint on subflow close
    https://git.kernel.org/netdev/net/c/c8fe62f0768c
  - [net,6/9] mptcp: factor out __mptcp_retrans helper()
    https://git.kernel.org/netdev/net/c/2948d0a1e5ae
  - [net,7/9] mptcp: fix race in release_cb
    https://git.kernel.org/netdev/net/c/c2e6048fa1cf
  - [net,8/9] mptcp: fix missing wakeup
    https://git.kernel.org/netdev/net/c/417789df4a03
  - [net,9/9] mptcp: free resources when the port number is mismatched
    https://git.kernel.org/netdev/net/c/9238e900d6ec

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============4712233266707311073==--
