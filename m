Content-Type: multipart/mixed; boundary="===============8148262230666317276=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] Multipath TCP part 3: MPTCPv1 (RFC 8684)
 support
Date: Fri, 13 Dec 2019 14:28:19 -0800
Message-ID: <alpine.OSX.2.21.1912131424480.33632@amhui-mobl1.amr.corp.intel.com>
In-Reply-To: 20191213205145.2468578-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3025

--===============8148262230666317276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 13 Dec 2019, Matthieu Baerts wrote:

> These patches depend on the "Multipath TCP part 2: Single subflow"
> patch set sent earlier.
>
> In this set we add the necessary code for the RFC8684-style handshake.
> RFC8684 obsoletes the experimental RFC6824 and makes MPTCP move-on to
> version 1.
>
> The MPTCP patchset exclusively supports RFC 8684. Although all MPTCP
> deployments are currently based on RFC 6824, future deployments will be
> migrating to MPTCP version 1. 3GPP's 5G standardization also solely suppo=
rts
> RFC 8684. Also, we believe that this initial submission of MPTCP will be
> cleaner by solely supporting RFC 8684. If later on support for the old
> MPTCP-version is required it can always be added in the future.
>
> The major difference between RFC 8684 and RFC 6824 is that it has a better
> support for servers using TCP SYN-cookies by reliably retransmitting the
> MP_CAPABLE option.
>
> Clone/fetch:
> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-v1-part3)
>
> Browse:
> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-v1-part3
>
> Thank your for your review. You can find us at mptcp(a)lists.01.org and
> https://is.gd/mptcp_upstream.
>
> Christoph Paasch (2):
>  mptcp: parse and emit MP_CAPABLE option according to v1 spec
>  mptcp: process MP_CAPABLE data option
>
> Paolo Abeni (2):
>  mptcp: move from sha1 (v0) to sha256 (v1)
>  mptcp: cope with later TCP fallback
>
> include/linux/tcp.h   |   3 +-
> include/net/mptcp.h   |  17 ++--
> net/ipv4/tcp_input.c  |   2 +-
> net/ipv4/tcp_output.c |   2 +-
> net/mptcp/Kconfig     |  10 ++
> net/mptcp/crypto.c    | 139 +++++++++++++++-----------
> net/mptcp/options.c   | 220 +++++++++++++++++++++++++++++++++---------
> net/mptcp/protocol.c  | 117 +++++++++++++++++-----
> net/mptcp/protocol.h  |  21 ++--
> net/mptcp/subflow.c   |  46 ++++++++-
> 10 files changed, 434 insertions(+), 143 deletions(-)
>
> -- =

> 2.24.0

Christoph -

Note that due to issues with patch 4 in this series, we aren't planning to =

send this "part 3" patch set to netdev until Monday.

(see =

https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/MW2VG3SOI=
C7B2M7ZSUHXD7AEZJ2MN4A6/ =

)


--
Mat Martineau
Intel
--===============8148262230666317276==--
