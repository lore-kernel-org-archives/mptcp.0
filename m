Content-Type: multipart/mixed; boundary="===============1643280330686608935=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix length of ADD_ADDR with port
 sub-option
Date: Mon, 08 Mar 2021 23:10:07 +0000
Message-ID: <
 <161524500764.8251.2830359116864468951.git-patchwork-notify@kernel.org>>
In-Reply-To: 66b3a2eec724af07ffdb04fefc6c7d50b85f296b.1615191605.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8077

--===============1643280330686608935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon,  8 Mar 2021 10:00:04 +0100 you wrote:
> in current Linux, MPTCP peers advertising endpoints with port numbers use
> a sub-option length that wrongly accounts for the trailing TCP NOP. Also,
> receivers will only process incoming ADD_ADDR with port having such wrong
> sub-option length. Fix this, making ADD_ADDR compliant to RFC8684 =C2=A73=
.4.1.
> =

> this can be verified running tcpdump on the kselftests artifacts:
> =

> [...]

Here is the summary with links:
  - [net] mptcp: fix length of ADD_ADDR with port sub-option
    https://git.kernel.org/netdev/net/c/27ab92d9996e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============1643280330686608935==--
