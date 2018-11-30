Content-Type: multipart/mixed; boundary="===============3501551112764455110=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/5] Forward-ports for mptcp-net-next
Date: Fri, 30 Nov 2018 15:50:03 -0800
Message-ID: <alpine.OSX.2.21.1811301548260.51304@zyi1-mobl1.amr.corp.intel.com>
In-Reply-To: 20181130010514.18251-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 872

--===============3501551112764455110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 29 Nov 2018, Christoph Paasch wrote:

> Hello,
>
> here are some forward-ports for mptcp-net-next that come from
> mptcp_trunk.
>

Thanks Christoph. I merged net-next and applied your patches. =

mptcp_net-next has the updates.


Mat


>
> Christoph Paasch (3):
>  mptcp: Remove IPv6 duplicated address detection
>  mptcp: Always call sk_data_ready
>  mptcp: Correctly initialize IPv6 fields
>
> Kostas Peletidis (2):
>  Export tcp_send_ack symbol to fix build issue with mptcp_fullmesh
>    module (mptcp_trunk). This commit should make it possible to revert
>    64a80850.
>  Revert "Fix building mptcp_fullmesh as module"
>
> net/ipv4/tcp_input.c       |  2 +-
> net/ipv4/tcp_output.c      |  1 +
> net/mptcp/mptcp_ctrl.c     | 30 ++++++++--------
> net/mptcp/mptcp_fullmesh.c | 85 ++++++-----------------------------------=
-----
> 4 files changed, 29 insertions(+), 89 deletions(-)
>
> -- =

> 2.16.2
>
>

--
Mat Martineau
Intel OTC

--===============3501551112764455110==--
