Content-Type: multipart/mixed; boundary="===============8022396811718182175=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v7 mptcp-next 00/11] RM_ADDR: remove a list
 of addrs
Date: Wed, 10 Feb 2021 11:42:49 -0800
Message-ID: <e456a97f-5e6b-681d-ced0-e633b7bc3db3@linux.intel.com>
In-Reply-To: cover.1612922705.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7754

--===============8022396811718182175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Feb 2021, Geliang Tang wrote:

> v7:
> - only changed the selftests.
> - add patch 9 and 10 from patchset "move to next addr and testcases".
> - drop "invalid addresses flush" in in patch 11, move it to patchset
> "move to next addr and testcases"
> - tag: export/20210209T062213

Geliang -

Thanks for reposting with the test changes. Self tests pass here and I =

reviewed the pcaps and debug logs too, looks good for the export branch.

Mat


>
> v6:
> - add "rm_list->nr =3D 1" in patch 1.
> - apply: tag export/20210209T062213 + patchset "move to next addr and
> testcases" v3.
>
> v5:
> - use struct mptcp_rm_list instead of the ids array.
> - simplify mptcp_pm_remove_addrs_and_subflows.
> - apply: tag export/20210207T062839 + patchset "move to next addr and
> testcases".
>
> v4:
> - use MAX_ADDR_ID as the default value in the rm_ids array.
> - keep the free_list and pass it to mptcp_nl_remove_addrs_list.
> - handle remove anno_addrs and subflows in one function.
>
> v3:
> - avoid looping twice in mptcp_write_options
> - drop nr in mptcp_get_rm_ids_nr
> - use rm_ids[0] in patch 1 and patch 3
> - separate pm.rm_ids for incoming and outgoing
> - tag: export/20210131T062218
>
> v2:
> - use an array of ids instead of a u64 map
> - drop "mptcp: update the netlink event for rm_addr" in v1
> - tag: export/20210131T062218
>
> This patchset added the removing a list of addresses support for
> RM_ADDR. It addressed issue #140.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140
>
> Geliang Tang (11):
>  mptcp: add rm_list in mptcp_out_options
>  mptcp: add rm_list_tx in mptcp_pm_data
>  mptcp: add rm_list in mptcp_options_received
>  mptcp: add rm_list_rx in mptcp_pm_data
>  mptcp: remove multi addresses in PM
>  mptcp: remove multi subflows in PM
>  mptcp: remove multi addresses and subflows in PM
>  mptcp: remove a list of addrs when flushing
>  selftests: mptcp: add invert argument for chk_rm_nr
>  selftests: mptcp: set addr id for removing testcases
>  selftests: mptcp: add testcases for removing addrs
>
> include/net/mptcp.h                           |   9 +-
> net/mptcp/options.c                           |  49 +++++--
> net/mptcp/pm.c                                |  29 ++--
> net/mptcp/pm_netlink.c                        | 138 +++++++++++++-----
> net/mptcp/protocol.h                          |  17 ++-
> .../testing/selftests/net/mptcp/mptcp_join.sh |  82 ++++++++---
> 6 files changed, 233 insertions(+), 91 deletions(-)
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
--===============8022396811718182175==--
