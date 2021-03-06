Content-Type: multipart/mixed; boundary="===============1927775139612980054=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 0/5] remove id 0 address
Date: Sat, 06 Mar 2021 10:26:44 +0100
Message-ID: <2bbe443e-a3ca-a68c-32fd-996e9ff33236@tessares.net>
In-Reply-To: cover.1614849685.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8061

--===============1927775139612980054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 04/03/2021 10:33, Geliang Tang wrote:
> v6:
>   - add addr argument for del_addr.
>   - tag: export/20210226T185626
>   - need to apply the squash-to patchset "avoid passing rm_list as a stru=
ct"
> or the single patch "avoid passing rm_list as a struct" in v5 first.
> =

> v5:
>   - add patch 1 "avoid passing rm_list as a struct".
>   - re-use MPTCP_MIB_RMADDR/MPTCP_MIB_RMSUBFLOW in patch 3.
>   - use (id =3D=3D 0) instead of (!id) in patch 4.
> =

> v4:
>   - add new function mptcp_nl_remove_id_zero_address.
>   - add new testcases.
> =

> v3:
>   - print subflow ids in patch 1;
>   - add the initial subflow's ids check in patch 2;
>   - update the test in patch 3;
> =

> v2:
>   - drop __mptcp_wr_shutdown in v1.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Thank you for the patches and reviews!

Just added in our tree with Mat's RvB tag and a small modification in =

patch 4/5 to remove a checkpatch warning.

- efa9a9885fe7: mptcp: remove all subflows involving id 0 address
- e753cdf39596: mptcp: unify RM_ADDR and RM_SUBFLOW receiving
- 01a0acddf9ee: mptcp: remove id 0 address
- 1cfe9d6a9351: selftests: mptcp: add addr argument for del_addr
- 52221e28e3ef: selftests: mptcp: remove id 0 address testcases
- Results: 31d85a0e0974..b6772f0348c6

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1927775139612980054==--
