Content-Type: multipart/mixed; boundary="===============5305853229289751290=="
MIME-Version: 1.0
From: patchwork-bot+netdevbpf at kernel.org
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 00/15] mptcp: ADD_ADDR enhancements
Date: Wed, 03 Feb 2021 03:10:11 +0000
Message-ID: <
 <161232181199.32173.5744869483811208677.git-patchwork-notify@kernel.org>>
In-Reply-To: 20210201230920.66027-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7603

--===============5305853229289751290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Mon,  1 Feb 2021 15:09:05 -0800 you wrote:
> This patch series from the MPTCP tree contains enhancements and
> associated tests for the ADD_ADDR ("add address") MPTCP option. This
> option allows already-connected MPTCP peers to share additional IP
> addresses with each other, which can then be used to create additional
> subflows within those MPTCP connections.
> =

> Patches 1 & 2 remove duplicated data in the per-connection path manager
> structure.
> =

> [...]

Here is the summary with links:
  - [net-next,v2,01/15] mptcp: use WRITE_ONCE for the pernet *_max
    https://git.kernel.org/netdev/net-next/c/72603d207d59
  - [net-next,v2,02/15] mptcp: drop *_max fields in mptcp_pm_data
    https://git.kernel.org/netdev/net-next/c/a914e586689f
  - [net-next,v2,03/15] mptcp: create subflow or signal addr for newly adde=
d address
    https://git.kernel.org/netdev/net-next/c/875b76718f68
  - [net-next,v2,04/15] mptcp: send ack for every add_addr
    https://git.kernel.org/netdev/net-next/c/b5a7acd3bd63
  - [net-next,v2,05/15] selftests: mptcp: use minus values for removing add=
ress numbers
    https://git.kernel.org/netdev/net-next/c/2e8cbf45cfb3
  - [net-next,v2,06/15] selftests: mptcp: add testcases for newly added add=
resses
    https://git.kernel.org/netdev/net-next/c/6208fd822a2c
  - [net-next,v2,07/15] mptcp: create the listening socket for new port
    https://git.kernel.org/netdev/net-next/c/1729cf186d8a
  - [net-next,v2,08/15] mptcp: drop unused skb in subflow_token_join_request
    https://git.kernel.org/netdev/net-next/c/b5e2e42fe566
  - [net-next,v2,09/15] mptcp: add a new helper subflow_req_create_thmac
    https://git.kernel.org/netdev/net-next/c/ec20e14396ae
  - [net-next,v2,10/15] mptcp: add port number check for MP_JOIN
    https://git.kernel.org/netdev/net-next/c/5bc56388c74f
  - [net-next,v2,11/15] mptcp: enable use_port when invoke addresses_equal
    https://git.kernel.org/netdev/net-next/c/60b57bf76cff
  - [net-next,v2,12/15] mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netl=
ink
    https://git.kernel.org/netdev/net-next/c/a77e9179c765
  - [net-next,v2,13/15] selftests: mptcp: add port argument for pm_nl_ctl
    https://git.kernel.org/netdev/net-next/c/d4a7726a79e2
  - [net-next,v2,14/15] mptcp: add the mibs for ADD_ADDR with port
    https://git.kernel.org/netdev/net-next/c/2fbdd9eaf174
  - [net-next,v2,15/15] selftests: mptcp: add testcases for ADD_ADDR with p=
ort
    https://git.kernel.org/netdev/net-next/c/8a127bf68a6f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


--===============5305853229289751290==--
