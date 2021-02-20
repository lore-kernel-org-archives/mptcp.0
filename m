Content-Type: multipart/mixed; boundary="===============8886900300439569825=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/3] move to next addr and
 testcases
Date: Fri, 19 Feb 2021 16:07:02 -0800
Message-ID: <55e0620-12cb-e0c7-69b7-2e416438d56@linux.intel.com>
In-Reply-To: cover.1613703548.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7873

--===============8886900300439569825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Feb 2021, Geliang Tang wrote:

> v5:
> - rename lookup_anno_list_by_saddr to mptcp_lookup_anno_list_by_saddr.
>

Thanks Geliang, v5 is good to merge in the export branch.

Before we close #151, what happens if the peer does not send echoes or =

echoes are lost? Should there be another patch to also call =

mptcp_pm_create_subflow_or_signal_addr when an ADD_ADDR has been =

retransmitted the maximum number of times?


Mat


> v4:
> - use lookup_anno_list_by_saddr instead of lookup_subflow_by_saddr.
> - use MPTCP_PM_SUBFLOW_ESTABLISHED instead of MPTCP_PM_ESTABLISHED.
>
> v3:
> - drop MPTCP_PM_NEXT_ADDR, use MPTCP_PM_ESTABLISHED instead.
> - hold the msk lock in mptcp_pm_add_addr_echoed.
> - tag: export/20210209T062213
>
> v2:
> - add patch 2 and 3 for removing testcases.
> - tag: export/20210207T062839.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151
>
> Geliang Tang (3):
>  mptcp: export lookup_anno_list_by_saddr
>  mptcp: move to next addr when subflow creation fail
>  selftests: mptcp: signal addresses testcases
>
> net/mptcp/options.c                           |  1 +
> net/mptcp/pm.c                                | 15 +++++
> net/mptcp/pm_netlink.c                        | 10 ++--
> net/mptcp/protocol.h                          |  5 ++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++++
> 5 files changed, 84 insertions(+), 5 deletions(-)
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
--===============8886900300439569825==--
