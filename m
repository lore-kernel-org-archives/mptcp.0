Content-Type: multipart/mixed; boundary="===============3233277074504685492=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/8] MPTCP: Add MP_PRIO support and
 rework local address IDs
Date: Sun, 10 Jan 2021 03:10:09 +0000
Message-ID: <
 <161024820975.15339.2337592500355833538.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210109004802.341602-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7305

--===============3233277074504685492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri,  8 Jan 2021 16:47:54 -0800 you wrote:
> Here are some patches we've merged in the MPTCP tree that are ready for
> net-next.
> =

> Patches 1 and 2 rework the assignment of local address IDs to allow them
> to be assigned by a userspace path manager, and add corresponding self
> tests.
> =

> [...]

Here is the summary with links:
  - [net-next,1/8] mptcp: add the address ID assignment bitmap
    https://git.kernel.org/netdev/net-next/c/efd5a4c04e18
  - [net-next,2/8] selftests: mptcp: add testcases for setting the address =
ID
    https://git.kernel.org/netdev/net-next/c/dc8eb10e95a8
  - [net-next,3/8] mptcp: add the outgoing MP_PRIO support
    https://git.kernel.org/netdev/net-next/c/067065422fcd
  - [net-next,4/8] mptcp: add the incoming MP_PRIO support
    https://git.kernel.org/netdev/net-next/c/40453a5c61f4
  - [net-next,5/8] mptcp: add set_flags command in PM netlink
    https://git.kernel.org/netdev/net-next/c/0f9f696a502e
  - [net-next,6/8] selftests: mptcp: add set_flags command in pm_nl_ctl
    https://git.kernel.org/netdev/net-next/c/6e8b244a3e9d
  - [net-next,7/8] mptcp: add the mibs for MP_PRIO
    https://git.kernel.org/netdev/net-next/c/0be2ac287bcc
  - [net-next,8/8] selftests: mptcp: add the MP_PRIO testcases
    https://git.kernel.org/netdev/net-next/c/718eb44e5c1e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============3233277074504685492==--
