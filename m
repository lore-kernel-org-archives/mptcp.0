Content-Type: multipart/mixed; boundary="===============1121287643147862909=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 0/5] remove id 0 address
Date: Wed, 03 Mar 2021 19:47:50 +0100
Message-ID: <1df99b7d85cb604ed2326a16d920cdb537f3e4d7.camel@redhat.com>
In-Reply-To: cover.1614776769.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8004

--===============1121287643147862909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-03 at 21:13 +0800, Geliang Tang wrote:
> v5:
>  - add patch 1 "avoid passing rm_list as a struct".
>  - re-use MPTCP_MIB_RMADDR/MPTCP_MIB_RMSUBFLOW in patch 3.
>  - use (id =3D=3D 0) instead of (!id) in patch 4.
>  - tag: export/20210226T185626.
> =

> v4:
>  - add new function mptcp_nl_remove_id_zero_address.
>  - add new testcases.
> =

> v3:
>  - print subflow ids in patch 1;
>  - add the initial subflow's ids check in patch 2;
>  - update the test in patch 3;
> =

> v2:
>  - drop __mptcp_wr_shutdown in v1.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140
> =

> Geliang Tang (5):
>   mptcp: avoid passing rm_list as a struct
>   mptcp: remove all subflows involving id 0 address
>   mptcp: unify RM_ADDR and RM_SUBFLOW receiving
>   mptcp: remove id 0 address
>   selftests: mptcp: remove id 0 address testcases
> =

>  net/mptcp/options.c                           |   4 +-
>  net/mptcp/pm.c                                |  23 ++--
>  net/mptcp/pm_netlink.c                        | 128 ++++++++++--------
>  net/mptcp/protocol.h                          |  16 ++-
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  29 +++-
>  5 files changed, 122 insertions(+), 78 deletions(-)

LGTM! =


I think patch 1/5 could be squashed into "mptcp: add rm_list_tx in
mptcp_pm_data" or some later patch, WDYT? possibly even after merging
into the export branch.

Cheers,

Paolo

--===============1121287643147862909==--
