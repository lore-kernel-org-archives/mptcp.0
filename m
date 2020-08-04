Content-Type: multipart/mixed; boundary="===============6646677705702317591=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/4] Add REMOVE_ADDR support
Date: Tue, 04 Aug 2020 12:59:03 +0200
Message-ID: <4be51559ee2e82347f49e08a312917e26501e0e1.camel@redhat.com>
In-Reply-To: cover.1596534832.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5462

--===============6646677705702317591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 18:01 +0800, Geliang Tang wrote:
> v5:
>  - merge mptcp_nl_remove_subflow() and mptcp_nl_remove_addr()
>  - add cond_resched
>  - reduce the indentation level in mptcp_pm_nl_rm_addr_received
> =

> v4:
>  - update mptcp_subflow_shutdown()'s args.
>  - add rm_id check to make sure we don't shutdown the first subflow.
>  - add conn_list empty check.
>  - move anno_list to mptcp_pm_data.
>  - add a new patch 'mptcp: add remove subflow support'.
> =

> v3:
>  - fix memory leak and lock issue in v2.
>  - drop alist in v2.
>  - fix mptcp_subflow_shutdown's arguments.
>  - bzero remote in mptcp_pm_create_subflow_or_signal_addr.
>  - add more commit message.
> =

> Geliang Tang (4):
>   mptcp: rename addr_signal and the related functions
>   mptcp: add the outgoing RM_ADDR support
>   mptcp: add the incoming RM_ADDR support
>   mptcp: remove addr and subflow in PM netlink
> =

>  net/mptcp/options.c    |  48 ++++++++++++---
>  net/mptcp/pm.c         |  56 +++++++++++++++---
>  net/mptcp/pm_netlink.c | 129 +++++++++++++++++++++++++++++++++++++++--
>  net/mptcp/protocol.c   |  14 +++--
>  net/mptcp/protocol.h   |  28 +++++++--
>  net/mptcp/subflow.c    |   1 +
>  6 files changed, 248 insertions(+), 28 deletions(-)
> =

First 3 patches are IMHO ready to be merged on the export branch, while
the 4th one needs some additional lifting.

@Mat[s]: I propose to merge up to 3/4 (included) so Geliang could send
a new version only the last one.

WDYT?

Thanks,

Paolo

--===============6646677705702317591==--
