Content-Type: multipart/mixed; boundary="===============2157579352117834241=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 0/2] mptcp: add ADD_ADDR
 timeout test case and others
Date: Wed, 30 Sep 2020 11:19:36 +0200
Message-ID: <3e02025111ee3bfcf327e16a58c3c35357f9fc11.camel@redhat.com>
In-Reply-To: cover.1601455568.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6110

--===============2157579352117834241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-30 at 16:50 +0800, Geliang Tang wrote:
> v4:
>  - use proc_dointvec_jiffies instead of proc_douintvec.
>  - use the reverse x-mas tree order.
>  - update the 'config' file for netfilter.
> =

> v3:
>  - rename run_add_addr_timeout_tests to run_tests_slow, it can be reused =
in
>    other test cases.
> =

> v2:
>  - drop add_addr_echo sysctl in v1
>  - use iptables rules to drop ADD_ADDR echo packets.
> =

> Geliang Tang (2):
>   mptcp: add a new sysctl add_addr_timeout
>   selftests: mptcp: add ADD_ADDR timeout test case
> =

>  net/mptcp/ctrl.c                              | 14 ++++++
>  net/mptcp/pm_netlink.c                        |  8 +++-
>  net/mptcp/protocol.h                          |  1 +
>  tools/testing/selftests/net/mptcp/config      |  6 +++
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++++++++++++--
>  5 files changed, 67 insertions(+), 5 deletions(-)

LGTM, thanks!

Note: I did not explicitly check the [k]config deps in patch 2/2, but I
guess problem there - if any! - could be addressed later.

/P

--===============2157579352117834241==--
