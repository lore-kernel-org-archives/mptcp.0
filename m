Content-Type: multipart/mixed; boundary="===============2231569369252183623=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/5] mptcp: create subflow
 for newly added address and testcases
Date: Thu, 14 Jan 2021 16:28:28 -0800
Message-ID: <912d998d-c12a-d9d3-8521-31887536f374@linux.intel.com>
In-Reply-To: cover.1610597571.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7394

--===============2231569369252183623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 14 Jan 2021, Geliang Tang wrote:

> v5:
> - rebase on export/20210113T185637
> - please apply this patchset after the following patchset:
>    add IPv4-mapped address support (v5)
>

Series looks good for the export branch. Thanks for rebasing and the =

patch dependency information!

Mat



> v4:
> - add a new patch to use WRITE_ONCE/READ_ONCE for the pernet *_max.
> - drop pm *_max in mptcp_diag.c too.
>
> v3:
> - add a new patch to drop *_max fields in mptcp_pm_data
>
> v2:
> - drop the unused addr parameter in mptcp_nl_add_subflow_or_signal_addr
> - use the pernet *_max values in mptcp_pm_create_subflow_or_signal_addr
> instead of the per-msk values.
>
> Address issue 19 "let PM netlink update live sockets on local addresses
> list change". The removed addresses part of this issue is done, this
> patchset only implemented the added addresses part.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/19
>
> Geliang Tang (5):
>  mptcp: use WRITE_ONCE/READ_ONCE for the pernet *_max
>  mptcp: drop *_max fields in mptcp_pm_data
>  mptcp: create subflow or signal addr for newly added address
>  selftests: mptcp: use minus values for removing address numbers
>  selftests: mptcp: add testcases for newly added addresses
>
> net/mptcp/mptcp_diag.c                        |   6 +-
> net/mptcp/pm.c                                |   9 +-
> net/mptcp/pm_netlink.c                        | 150 +++++++++++++-----
> net/mptcp/protocol.h                          |   8 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 101 ++++++++++--
> 5 files changed, 211 insertions(+), 63 deletions(-)
>
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============2231569369252183623==--
