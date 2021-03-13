Content-Type: multipart/mixed; boundary="===============7010497116154081715=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 00/11] mptcp: Include multiple address
 ids in RM_ADDR
Date: Sat, 13 Mar 2021 02:00:10 +0000
Message-ID: <
 <161560081045.26528.4223411553383544597.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210313011621.211661-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8145

--===============7010497116154081715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 12 Mar 2021 17:16:10 -0800 you wrote:
> Here's a patch series from the MPTCP tree that extends the capabilities
> of the MPTCP RM_ADDR header.
> =

> MPTCP peers can exchange information about their IP addresses that are
> available for additional MPTCP subflows. IP addresses are advertised
> with an ADD_ADDR header type, and those advertisements are revoked with
> the RM_ADDR header type. RFC 8684 allows the RM_ADDR header to include
> more than one address ID, so multiple advertisements can be revoked in a
> single header. Previous kernel versions have only used RM_ADDR with a
> single address ID, so multiple removals required multiple packets.
> =

> [...]

Here is the summary with links:
  - [net-next,01/11] mptcp: add rm_list in mptcp_out_options
    https://git.kernel.org/netdev/net-next/c/6445e17af7c5
  - [net-next,02/11] mptcp: add rm_list_tx in mptcp_pm_data
    https://git.kernel.org/netdev/net-next/c/cbde27871896
  - [net-next,03/11] mptcp: add rm_list in mptcp_options_received
    https://git.kernel.org/netdev/net-next/c/5c4a824dcb58
  - [net-next,04/11] mptcp: add rm_list_rx in mptcp_pm_data
    https://git.kernel.org/netdev/net-next/c/b5c55f334c7f
  - [net-next,05/11] mptcp: remove multi addresses in PM
    https://git.kernel.org/netdev/net-next/c/d0b698ca9a27
  - [net-next,06/11] mptcp: remove multi subflows in PM
    https://git.kernel.org/netdev/net-next/c/ddd14bb85dd8
  - [net-next,07/11] mptcp: remove multi addresses and subflows in PM
    https://git.kernel.org/netdev/net-next/c/06faa2271034
  - [net-next,08/11] mptcp: remove a list of addrs when flushing
    https://git.kernel.org/netdev/net-next/c/0e4a3e68862b
  - [net-next,09/11] selftests: mptcp: add invert argument for chk_rm_nr
    https://git.kernel.org/netdev/net-next/c/7028ba8ac968
  - [net-next,10/11] selftests: mptcp: set addr id for removing testcases
    https://git.kernel.org/netdev/net-next/c/f87744ad4244
  - [net-next,11/11] selftests: mptcp: add testcases for removing addrs
    https://git.kernel.org/netdev/net-next/c/d2c4333a801c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============7010497116154081715==--
