Content-Type: multipart/mixed; boundary="===============0865592167953553730=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next] mptcp: add local addr info
 in mptcp_info
Date: Wed, 03 Feb 2021 16:00:22 -0800
Message-ID: <72e6de2-a737-a1fd-b9fa-5c879213c8@linux.intel.com>
In-Reply-To: 074e92470b7b18bbaf55b56d114e6616ed437a45.1612319252.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7616

--===============0865592167953553730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Feb 2021, Geliang Tang wrote:

> Add mptcpi_local_addr_used and mptcpi_local_addr_max in struct mptcp_info.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v3:
> - keep mptcpi_add_addr_signal unchanged

Looks good for the export branch, thanks!

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


Mat


>
> v2:
> - append new fields in the end of struct mptcp_info.
> - This patch is split from "add trace events" patch set as a single one
> as Paolo suggested.
> - tag: export/20210131T062218
> ---
> include/uapi/linux/mptcp.h | 2 ++
> net/mptcp/mptcp_diag.c     | 2 ++
> net/mptcp/pm_netlink.c     | 3 ++-
> net/mptcp/protocol.h       | 1 +
> 4 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index c91578aaab32..e1172c1ffdfd 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -103,6 +103,8 @@ struct mptcp_info {
> 	__u64	mptcpi_write_seq;
> 	__u64	mptcpi_snd_una;
> 	__u64	mptcpi_rcv_nxt;
> +	__u8	mptcpi_local_addr_used;
> +	__u8	mptcpi_local_addr_max;
> };
>
> /*
> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 00ed742f48a4..f16d9b5ee978 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -128,11 +128,13 @@ static void mptcp_diag_get_info(struct sock *sk, st=
ruct inet_diag_msg *r,
> 	info->mptcpi_subflows =3D READ_ONCE(msk->pm.subflows);
> 	info->mptcpi_add_addr_signal =3D READ_ONCE(msk->pm.add_addr_signaled);
> 	info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_accepted);
> +	info->mptcpi_local_addr_used =3D READ_ONCE(msk->pm.local_addr_used);
> 	info->mptcpi_subflows_max =3D mptcp_pm_get_subflows_max(msk);
> 	val =3D mptcp_pm_get_add_addr_signal_max(msk);
> 	info->mptcpi_add_addr_signal_max =3D val;
> 	val =3D mptcp_pm_get_add_addr_accept_max(msk);
> 	info->mptcpi_add_addr_accepted_max =3D val;
> +	info->mptcpi_local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
> 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
> 		flags |=3D MPTCP_INFO_FLAG_FALLBACK;
> 	if (READ_ONCE(msk->can_ack))
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6b6dacd0e03a..75ab3d308ab5 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -228,13 +228,14 @@ unsigned int mptcp_pm_get_subflows_max(struct mptcp=
_sock *msk)
> }
> EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
>
> -static unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
> +unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
> {
> 	struct pm_nl_pernet *pernet;
>
> 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> 	return READ_ONCE(pernet->local_addr_max);
> }
> +EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
>
> static void check_work_pending(struct mptcp_sock *msk)
> {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 92658c34f091..d385651ff6a9 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -736,6 +736,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc);
> unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
> unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
> +unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
>
> static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
> {
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============0865592167953553730==--
