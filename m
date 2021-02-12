Content-Type: multipart/mixed; boundary="===============5084047909661837610=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 0/6] mptcp: Miscellaneous fixes
Date: Fri, 12 Feb 2021 02:50:08 +0000
Message-ID: <
 <161309820822.25329.1992173657859048208.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210211233042.304878-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7769

--===============5084047909661837610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net.git (refs/heads/master):

On Thu, 11 Feb 2021 15:30:36 -0800 you wrote:
> Here are some MPTCP fixes for the -net tree, addressing various issues
> we have seen thanks to syzkaller and other testing:
> =

> Patch 1 correctly propagates errors at connection time and for TCP
> fallback connections.
> =

> Patch 2 sets the expected poll() events on SEND_SHUTDOWN.
> =

> [...]

Here is the summary with links:
  - [net,1/6] mptcp: deliver ssk errors to msk
    https://git.kernel.org/netdev/net/c/15cc10453398
  - [net,2/6] mptcp: fix poll after shutdown
    https://git.kernel.org/netdev/net/c/dd913410b0a4
  - [net,3/6] mptcp: fix spurious retransmissions
    https://git.kernel.org/netdev/net/c/64b9cea7a0af
  - [net,4/6] mptcp: init mptcp request socket earlier
    https://git.kernel.org/netdev/net/c/d8b59efa6406
  - [net,5/6] mptcp: better msk receive window updates
    https://git.kernel.org/netdev/net/c/e3859603ba13
  - [net,6/6] mptcp: add a missing retransmission timer scheduling
    https://git.kernel.org/netdev/net/c/d09d818ec2ed

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============5084047909661837610==--
