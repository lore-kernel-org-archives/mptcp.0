Content-Type: multipart/mixed; boundary="===============1873882910745865190=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/7] mptcp: remove multi
 addrs on outgoing path
Date: Mon, 01 Feb 2021 17:21:54 -0800
Message-ID: <3f81b6a4-6780-f9cb-55f4-8e30c798c7db@linux.intel.com>
In-Reply-To: df9a9acb5128c40834c366c382a22fcc36223ab3.1612163150.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7574

--===============1873882910745865190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Feb 2021, Geliang Tang wrote:

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
> include/net/mptcp.h  |  4 +++-
> net/mptcp/options.c  | 40 ++++++++++++++++++++++++++++++++--------
> net/mptcp/pm.c       |  3 +--
> net/mptcp/protocol.h | 14 ++++++++++++--
> 4 files changed, 48 insertions(+), 13 deletions(-)
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
> index bb874c5d663a..3ce7917327d1 100644
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
> @@ -1212,9 +1219,26 @@ void mptcp_write_options(__be32 *ptr, const struct=
 tcp_sock *tp,
> 	}
>
> 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
> +		u8 i, nr;
> +
> +		nr =3D mptcp_get_rm_ids_nr(opts->rm_ids);
> +		for (i =3D 0; i < MPTCP_RM_IDS_MAX; i++) {
> +			if (!opts->rm_ids[i])
> +				opts->rm_ids[i] =3D TCPOPT_NOP;
> +		}

Could also use this for loop to add up 'nr' rather than looping twice (the =

loop here and the one inside mptcp_get_rm_ids_nr()).

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
> index 6fd4b2c1b076..764cd62c59ba 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -258,7 +258,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
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
> @@ -271,7 +271,6 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
> 	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
> 		goto out_unlock;
>
> -	*rm_id =3D msk->pm.rm_id;
> 	WRITE_ONCE(msk->pm.addr_signal, 0);
> 	ret =3D true;
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d31edbae8da8..411af3334a25 100644
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
> @@ -289,6 +289,16 @@ struct mptcp_sock {
> #define mptcp_for_each_subflow(__msk, __subflow)			\
> 	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
>
> +static inline u8 mptcp_get_rm_ids_nr(u8 rm_ids[])
> +{
> +	int i, nr =3D 0;
> +
> +	for (i =3D 0; i < MPTCP_RM_IDS_MAX && rm_ids[i]; i++)
> +		nr++;

'nr' isn't needed, can return i instead.

> +
> +	return nr;
> +}
> +
> static inline void msk_owned_by_me(const struct mptcp_sock *msk)
> {
> 	sock_owned_by_me((const struct sock *)msk);
> @@ -714,7 +724,7 @@ static inline unsigned int mptcp_add_addr_len(int fam=
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
--===============1873882910745865190==--
