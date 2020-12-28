Content-Type: multipart/mixed; boundary="===============3369308139671187084=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] net: mptcp: cap forward allocation to 1M
Date: Mon, 28 Dec 2020 22:00:07 +0000
Message-ID: <
 <160919280713.22170.4812500231632961551.git-patchwork-notify@kernel.org>>
In-Reply-To: 3334d00d8b2faecafdfab9aa593efcbf61442756.1608584474.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7248

--===============3369308139671187084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon, 21 Dec 2020 22:07:25 +0100 you wrote:
> the following syzkaller reproducer:
> =

>  r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
>  bind$inet(r0, &(0x7f0000000080)=3D{0x2, 0x4e24, @multicast2}, 0x10)
>  connect$inet(r0, &(0x7f0000000480)=3D{0x2, 0x4e24, @local}, 0x10)
>  sendto$inet(r0, &(0x7f0000000100)=3D"f6", 0xffffffe7, 0xc000, 0x0, 0x0)
> =

> [...]

Here is the summary with links:
  - [net] net: mptcp: cap forward allocation to 1M
    https://git.kernel.org/netdev/net/c/e7579d5d5b32

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============3369308139671187084==--
