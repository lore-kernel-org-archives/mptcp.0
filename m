Content-Type: multipart/mixed; boundary="===============4061181209393931794=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Fri, 04 Sep 2020 13:07:42 +0800
Message-ID: <CA+WQbwttLmaW2U_ouuMwKXtKW-6RF=CXGLPdeHWhbTpTA7NRgw@mail.gmail.com>
In-Reply-To: cover.1599038897.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5719

--===============4061181209393931794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:40=E5=86=99=E9=81=93=EF=BC=9A
>
> v9:
>  - update patch 3/8, simply call mptcp_pm_nl_rm_subflow_received.
>  - update patch 5/8, use the reverse x-mas tree order.
>  - this patchset should be applied after the applying of my another
>    patchset, 'add ADD_ADDR echo flag support'.
>
> v8:
>  - drop anno_list in v7.
>    We don't need to add a new list, conn_list is enough for the signal
> address and local subflow.
>  - fix local_id and remote_id issues.
>    The RM_ADDR logic uses an address id to identify the removing
> address, so we must make sure the subflow's local_id and remote_id be
> set properly.
>  - fix mptcp_pm_nl_rm_addr_received logic issue
>  - update selftests
>
> v7:
>  - add RM_ADDR mib
>  - update RM_ADDR selftests test case
>
> v6:
>  - rename lookup_anno_list_by_saddr to remove_anno_list_by_saddr as
>    Paolo suggested.
>  - add msk socket lock when traverse msk->conn_list as Paolo suggested.
>  - Since the first three patches in v5 have been merged to export
>    branch, drop them from this patchset.
>  - add remove addr and subflow selftest test case.
>  - this patchset is against mptcp_net-next's export branch.
>
> v5:
>  - merge mptcp_nl_remove_subflow() and mptcp_nl_remove_addr()
>  - add cond_resched
>  - reduce the indentation level in mptcp_pm_nl_rm_addr_received
>
> v4:
>  - update mptcp_subflow_shutdown()'s args.
>  - add rm_id check to make sure we don't shutdown the first subflow.
>  - add conn_list empty check.
>  - move anno_list to mptcp_pm_data.
>  - add a new patch 'mptcp: add remove subflow support'.
>
> v3:
>  - fix memory leak and lock issue in v2.
>  - drop alist in v2.
>  - fix mptcp_subflow_shutdown's arguments.
>  - bzero remote in mptcp_pm_create_subflow_or_signal_addr.
>  - add more commit message.
>
> Geliang Tang (8):
>   1/8 mptcp: remove addr and subflow in PM netlink
>   2/8 mptcp: fix mptcp_pm_nl_rm_addr_received logic issue
>   3/8 mptcp: implement mptcp_pm_remove_subflow
>   4/8 mptcp: fix every subflow's local_id is zero
>   5/8 mptcp: fix subflow's remote_id is zero issue
>   6/8 mptcp: add RM_ADDR related mibs
>   7/8 selftests: mptcp: add remove cfg in mptcp_connect
>   8/8 selftests: mptcp: add remove addr and subflow test cases

Hi Paolo, Matt,

I want to adjust some code in this patchset.

I think patch 2/8 "mptcp: fix mptcp_pm_nl_rm_addr_received logic issue"
shouldn't be here, it's better to squash-to the original commit "mptcp: add
the incoming RM_ADDR support".

So I have sent out a new patch named 'Squash-to: "mptcp: add the incoming
RM_ADDR support"' yesterday.

And I want to commit patch 4/8 "mptcp: fix every subflow's local_id is zero"
and 5/8 "mptcp: fix subflow's remote_id is zero issue" directly to -net as =
Paolo
suggested. Some code about subflow's remote_id fixing in the commit "mptcp:
add the incoming RM_ADDR support" should be put together in patch 5/8.
So in the squash-to patch, I drop the original subflow's remote_id fixing c=
ode.

Please give me some suggestions about my squash-to patch.

Thanks.
-Geliang

>
>  net/mptcp/mib.c                               |   2 +
>  net/mptcp/mib.h                               |   2 +
>  net/mptcp/pm.c                                |  15 +-
>  net/mptcp/pm_netlink.c                        | 107 +++++++++++--
>  net/mptcp/protocol.h                          |   3 +-
>  net/mptcp/subflow.c                           |   8 +-
>  .../selftests/net/mptcp/mptcp_connect.c       |  18 ++-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 145 +++++++++++++++++-
>  8 files changed, 276 insertions(+), 24 deletions(-)
>
> --
> 2.17.1
>
--===============4061181209393931794==--
