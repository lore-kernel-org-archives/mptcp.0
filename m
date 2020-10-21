Content-Type: multipart/mixed; boundary="===============0075689769819996833=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/3] add ADD_ADDR IPv6 support
Date: Wed, 21 Oct 2020 17:25:33 +0200
Message-ID: <2ad41cbfe93791d1194a5ae70029461a6390b669.camel@redhat.com>
In-Reply-To: cover.1603264085.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6393

--===============0075689769819996833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-21 at 15:19 +0800, Geliang Tang wrote:
> v5:
>  - drop msleep() in v4
>  - drop MPTCP_ADD_ADDR_SEND_ACK in v4
>  - add WRITE_ONCE/READ_ONCE for msk->pm.add_addr_signal
>  - depend on "mptcp: keep unaccepted MPC subflow into join list"
> =

> v4:
>  - update the patches as Paolo suggested:
>  - change the 'add_addr_signal' type
>  - set MPTCP_ADD_ADDR_IPV6 in mptcp_pm_announce_addr
>  - add a new helper mptcp_send_dedicated_add_addr_packet to sent out a
> new pure ACK packet
>  - drop other MPTCP suboptions in mptcp_established_options_add_addr
> =

> v3:
>  - drop other MPTCP suboptions instead of OPTION_TS
> =

> v2:
>  - avoid adding new field to tcp_sock, add new field in mptcp_pm_data.
>  - drop OPTION_TS in mptcp_established_options_add_addr, not in
> tcp_established_options.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55
> =

> Geliang Tang (3):
>   mptcp: change add_addr_signal type
>   mptcp: send out dedicated ADD_ADDR packet
>   selftests: mptcp: add ADD_ADDR IPv6 test cases
> =

>  net/mptcp/options.c                           | 25 ++++++-
>  net/mptcp/pm.c                                | 23 +++---
>  net/mptcp/pm_netlink.c                        | 27 +++++++
>  net/mptcp/protocol.c                          |  2 +-
>  net/mptcp/protocol.h                          | 13 +++-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
>  6 files changed, 144 insertions(+), 16 deletions(-)

The series LGTM, thanks!

/P

--===============0075689769819996833==--
