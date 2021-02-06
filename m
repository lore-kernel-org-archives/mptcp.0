Content-Type: multipart/mixed; boundary="===============6908084129602213800=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 1/9] mptcp: use rm_ids array
 in mptcp_out_options
Date: Fri, 05 Feb 2021 17:08:52 -0800
Message-ID: <cb34395a-8ea1-3a37-3a98-3b5bcaf7406@linux.intel.com>
In-Reply-To: da8cdc04a9ca5353e5f9455e4d6c91defa7c59de.1612534634.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7657

--===============6908084129602213800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Feb 2021, Geliang Tang wrote:

> This patch changed the member rm_id of struct mptcp_out_options as an
> array of the removing address ids, and renamed it to rm_ids. The array
> size was definced as a new macro MPTCP_RM_IDS_MAX.
>
> Added a new function named mptcp_get_rm_ids_nr to get the number of
> address ids in the ids array.
>
> In mptcp_established_options_rm_addr, invoked mptcp_pm_rm_addr_signal to
> get the ids array. According the number of addresses in it, calculated
> the padded RM_ADDR suboption length. And saved the ids array in struct
> mptcp_out_options's rm_ids member.
>
> In mptcp_write_options, iterated each address id from struct
> mptcp_out_options's rm_ids member, set the zero ones as TCPOPT_NOP,
> then filled them into the RM_ADDR suboption.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> include/net/mptcp.h    |  4 +++-
> net/mptcp/options.c    | 41 +++++++++++++++++++++++++++++++++--------
> net/mptcp/pm.c         |  4 ++--
> net/mptcp/pm_netlink.c |  1 -
> net/mptcp/protocol.h   | 18 ++++++++++++++++--
> 5 files changed, 54 insertions(+), 14 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5694370be3d4..1d33fea674d2 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -34,6 +34,8 @@ struct mptcp_ext {
> 	/* one byte hole */
> };
>
> +#define MPTCP_RM_IDS_MAX	8
> +
> struct mptcp_out_options {
> #if IS_ENABLED(CONFIG_MPTCP)
> 	u16 suboptions;
> @@ -48,7 +50,7 @@ struct mptcp_out_options {
> 	u8 addr_id;
> 	u16 port;
> 	u64 ahmac;
> -	u8 rm_id;
> +	u8 rm_ids[MPTCP_RM_IDS_MAX];
> 	u8 join_id;
> 	u8 backup;
> 	u32 nonce;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 1c5c99c06951..14843f42a42a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -671,20 +671,27 @@ static bool mptcp_established_options_rm_addr(struc=
t sock *sk,
> {
> 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> -	u8 rm_id;
> +	u8 rm_ids[MPTCP_RM_IDS_MAX], i, nr, align;
>
> 	if (!mptcp_pm_should_rm_signal(msk) ||
> -	    !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
> +	    !(mptcp_pm_rm_addr_signal(msk, remaining, rm_ids)))
> 		return false;
>
> -	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
> +	nr =3D mptcp_get_rm_ids_nr(rm_ids);
> +	if (nr > 1)
> +		align =3D 5;
> +	if (nr > 5)
> +		align =3D 9;
> +
> +	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE + align)
> 		return false;
>
> -	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE;
> +	*size =3D TCPOLEN_MPTCP_RM_ADDR_BASE + align;
> 	opts->suboptions |=3D OPTION_MPTCP_RM_ADDR;
> -	opts->rm_id =3D rm_id;
> +	memcpy(opts->rm_ids, rm_ids, MPTCP_RM_IDS_MAX);
>
> -	pr_debug("rm_id=3D%d", opts->rm_id);
> +	for (i =3D 0; i < nr; i++)
> +		pr_debug("rm_ids[%d]=3D%d", i, opts->rm_ids[i]);
>
> 	return true;
> }
> @@ -1213,9 +1220,27 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
> 	}
>
> 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> +		u8 i, nr =3D 0;
> +
> +		for (i =3D 0; i < MPTCP_RM_IDS_MAX; i++) {
> +			if (opts->rm_ids[i] !=3D MAX_ADDR_ID)
> +				nr++;
> +			else
> +				opts->rm_ids[i] =3D TCPOPT_NOP;
> +		}
> 		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
> -				      TCPOLEN_MPTCP_RM_ADDR_BASE,
> -				      0, opts->rm_id);
> +				      TCPOLEN_MPTCP_RM_ADDR_BASE + nr,
> +				      0, opts->rm_ids[0]);
> +		if (nr > 1) {
> +			put_unaligned_be32(opts->rm_ids[1] << 24 | opts->rm_ids[2] << 16 |
> +					   opts->rm_ids[3] << 8 | opts->rm_ids[4], ptr);
> +			ptr +=3D 1;
> +		}
> +		if (nr > 5) {
> +			put_unaligned_be32(opts->rm_ids[5] << 24 | opts->rm_ids[6] << 16 |
> +					   opts->rm_ids[7] << 8 | TCPOPT_NOP, ptr);
> +			ptr +=3D 1;
> +		}
> 	}
>
> 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index a6d068d801d0..d71e8ff7c2fd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -273,7 +273,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
> }
>
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> -			     u8 *rm_id)
> +			     u8 rm_ids[])
> {
> 	int ret =3D false;
>
> @@ -286,7 +286,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
> 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
> 		goto out_unlock;
>
> -	*rm_id =3D msk->pm.rm_id;
> +	rm_ids[0] =3D msk->pm.rm_id;
> 	WRITE_ONCE(msk->pm.addr_signal, 0);
> 	ret =3D true;
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d9eaee2037bd..073e8ad1cbd0 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -37,7 +37,6 @@ struct mptcp_pm_add_entry {
> 	u8			retrans_times;
> };
>
> -#define MAX_ADDR_ID		255
> #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
>
> struct pm_nl_pernet {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7ad0dfef36bd..aa2716b50214 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -60,7 +60,7 @@
> #define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
> #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	24
> #define TCPOLEN_MPTCP_PORT_LEN		4
> -#define TCPOLEN_MPTCP_RM_ADDR_BASE	4
> +#define TCPOLEN_MPTCP_RM_ADDR_BASE	3
> #define TCPOLEN_MPTCP_PRIO		3
> #define TCPOLEN_MPTCP_PRIO_ALIGN	4
> #define TCPOLEN_MPTCP_FASTCLOSE		12
> @@ -291,6 +291,20 @@ struct mptcp_sock {
> #define mptcp_for_each_subflow(__msk, __subflow)			\
> 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
>
> +#define MAX_ADDR_ID		255
> +
> +static inline u8 mptcp_get_rm_ids_nr(u8 rm_ids[])
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MPTCP_RM_IDS_MAX; i++) {
> +		if (rm_ids[i] =3D=3D MAX_ADDR_ID)

This can work on the sending side, but the peer might be a different MPTCP =

implementation - and '255' is a valid address ID for the peer to use =

according to the RFC.

I think it would be confusing to use a MAX_ADDR_ID reserved value to mark =

the end of the ID list for some uses (like the RM_ADDR tx path), and then =

have to use a different technique for the incoming address list that can =

contain any 8-bit values. I think that means adding another u8 to go with =

each rm_ids[] array - adding a struct similar to:

struct addr_list {
 	u8 ids[MAX_ADDR_ID];
 	u8 nr_valid;
};

so the number of valid entries is explicitly stored.


> +			break;
> +	}
> +
> +	return i;
> +}
> +
> static inline void msk_owned_by_me(const struct mptcp_sock *msk)
> {
> 	sock_owned_by_me((const struct sock *)msk);
> @@ -722,7 +736,7 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo, bool port)
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> 			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> -			     u8 *rm_id);
> +			     u8 rm_ids[]);
> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc=
);
>
> void __init mptcp_pm_nl_init(void);
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============6908084129602213800==--
