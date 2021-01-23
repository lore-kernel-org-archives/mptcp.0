Content-Type: multipart/mixed; boundary="===============6833672669756034708=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 net-next 0/5] mptcp: re-enable sndbuf autotune
Date: Sat, 23 Jan 2021 03:30:11 +0000
Message-ID: <
 <161137261151.31547.3569870182293776976.git-patchwork-notify@kernel.org>>
In-Reply-To: cover.1611153172.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7474

--===============6833672669756034708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Wed, 20 Jan 2021 15:39:09 +0100 you wrote:
> The sendbuffer autotuning was unintentionally disabled as a
> side effect of the recent workqueue removal refactor. These
> patches re-enable id, with some extra care: with autotuning
> enable/large send buffer we need a more accurate packet
> scheduler to be able to use efficiently the available
> subflow bandwidth, especially when the subflows have
> different capacities.
> =

> [...]

Here is the summary with links:
  - [v2,net-next,1/5] mptcp: always graft subflow socket to parent
    https://git.kernel.org/netdev/net-next/c/866f26f2a9c3
  - [v2,net-next,2/5] mptcp: re-enable sndbuf autotune
    https://git.kernel.org/netdev/net-next/c/5cf92bbadc58
  - [v2,net-next,3/5] mptcp: do not queue excessive data on subflows
    https://git.kernel.org/netdev/net-next/c/ec369c3a337f
  - [v2,net-next,4/5] mptcp: schedule work for better snd subflow selection
    https://git.kernel.org/netdev/net-next/c/40dc9416cc95
  - [v2,net-next,5/5] mptcp: implement delegated actions
    https://git.kernel.org/netdev/net-next/c/b19bc2945b40

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============6833672669756034708==--
