Content-Type: multipart/mixed; boundary="===============7214199629342372769=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/5] move to next addr when
 timeout
Date: Wed, 24 Feb 2021 18:23:14 -0800
Message-ID: <82d53a8e-b27-6378-5e1-d766823f113f@linux.intel.com>
In-Reply-To: cover.1614138509.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7949

--===============7214199629342372769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Feb 2021, Geliang Tang wrote:

> v3:
> - invoke lookup_subflow_by_daddr in mptcp_pm_nl_add_addr_received.
> - add a new patch "drop argument port from mptcp_pm_announce_addr".
>
> v2:
> - invoke lookup_subflow_by_daddr in mptcp_pm_add_addr_received, not in
> mptcp_pm_nl_add_addr_received.
> - add a sanity check on cfg_do_w.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151
>
> Geliang Tang (5):
>  mptcp: drop argument port from mptcp_pm_announce_addr
>  mptcp: skip connecting the connected address
>  mptcp: move to next addr when timeout
>  selftests: mptcp: add cfg_do_w for cfg_remove
>  selftests: mptcp: timeout testcases for multi addresses
>
> net/mptcp/pm.c                                |  6 ++--
> net/mptcp/pm_netlink.c                        | 35 +++++++++++++++----
> net/mptcp/protocol.h                          |  2 +-
> .../selftests/net/mptcp/mptcp_connect.c       | 10 ++++--
> .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++--
> 5 files changed, 64 insertions(+), 15 deletions(-)
>
> -- =

> 2.29.2

Thanks Geliang, I think v3 is ready for the export branch.


Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7214199629342372769==--
