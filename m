Content-Type: multipart/mixed; boundary="===============5577895743435462262=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3 00/13] mptcp: improve multiple xmit
 streams support
Date: Mon, 16 Nov 2020 19:30:07 +0000
Message-ID: <
 <160555500737.21076.15593778409106734018.git-patchwork-notify@kernel.org>>
In-Reply-To: cover.1605458224.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6758

--===============5577895743435462262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon, 16 Nov 2020 10:48:01 +0100 you wrote:
> This series improves MPTCP handling of multiple concurrent
> xmit streams.
> =

> The to-be-transmitted data is enqueued to a subflow only when
> the send window is open, keeping the subflows xmit queue shorter
> and allowing for faster switch-over.
> =

> [...]

Here is the summary with links:
  - [net-next,v3,01/13] tcp: factor out tcp_build_frag()
    https://git.kernel.org/netdev/net-next/c/b796d04bd014
  - [net-next,v3,02/13] mptcp: use tcp_build_frag()
    https://git.kernel.org/netdev/net-next/c/e2223995a287
  - [net-next,v3,03/13] tcp: factor out __tcp_close() helper
    https://git.kernel.org/netdev/net-next/c/77c3c9563752
  - [net-next,v3,04/13] mptcp: introduce mptcp_schedule_work
    https://git.kernel.org/netdev/net-next/c/ba8f48f7a4d7
  - [net-next,v3,05/13] mptcp: reduce the arguments of mptcp_sendmsg_frag
    https://git.kernel.org/netdev/net-next/c/caf971df01b8
  - [net-next,v3,06/13] mptcp: add accounting for pending data
    https://git.kernel.org/netdev/net-next/c/f0e6a4cf11f1
  - [net-next,v3,07/13] mptcp: introduce MPTCP snd_nxt
    https://git.kernel.org/netdev/net-next/c/eaa2ffabfc35
  - [net-next,v3,08/13] mptcp: refactor shutdown and close
    https://git.kernel.org/netdev/net-next/c/e16163b6e2b7
  - [net-next,v3,09/13] mptcp: move page frag allocation in mptcp_sendmsg()
    https://git.kernel.org/netdev/net-next/c/d9ca1de8c0cd
  - [net-next,v3,10/13] mptcp: try to push pending data on snd una updates
    https://git.kernel.org/netdev/net-next/c/813e0a683d4c
  - [net-next,v3,11/13] mptcp: rework poll+nospace handling
    https://git.kernel.org/netdev/net-next/c/8edf08649eed
  - [net-next,v3,12/13] mptcp: keep track of advertised windows right edge
    https://git.kernel.org/netdev/net-next/c/6f8a612a33e4
  - [net-next,v3,13/13] mptcp: send explicit ack on delayed ack_seq incr
    https://git.kernel.org/netdev/net-next/c/7ed90803a213

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============5577895743435462262==--
