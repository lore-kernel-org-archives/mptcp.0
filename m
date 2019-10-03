Content-Type: multipart/mixed; boundary="===============2177432461619746284=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:diag: prefix exposed items
Date: Thu, 03 Oct 2019 10:56:42 +0200
Message-ID: <a9a691fcd1598bade882332cc1e59c989bf9cc3f.camel@redhat.com>
In-Reply-To: 20191002190859.29384-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2010

--===============2177432461619746284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-02 at 21:08 +0200, Matthieu Baerts wrote:
> To conform with the rest.
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

yes, this makes sense. Minor nits below:

> ---
>  include/uapi/linux/mptcp.h | 18 +++++++++---------
>  net/mptcp/diag.c           | 22 +++++++++++-----------
>  net/mptcp/protocol.h       |  4 ++--
>  net/mptcp/subflow.c        |  4 ++--
>  4 files changed, 24 insertions(+), 24 deletions(-)
> =

> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 2856b89cc36e..04bd134c1807 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -4,15 +4,15 @@
>  =

>  #include <linux/types.h>
>  =

> -#define SUBFLOW_FLAGS_MCAP_REM		BIT(0)
> -#define SUBFLOW_FLAGS_MCAP_LOC		BIT(1)
> -#define SUBFLOW_FLAGS_JOIN_REM		BIT(2)
> -#define SUBFLOW_FLAGS_JOIN_LOC		BIT(3)
> -#define SUBFLOW_FLAGS_BKUP_REM		BIT(4)
> -#define SUBFLOW_FLAGS_BKUP_LOC		BIT(5)
> -#define SUBFLOW_FLAGS_4THACK		BIT(6)
> -#define SUBFLOW_FLAGS_CONNECTED		BIT(7)
> -#define SUBFLOW_FLAGS_MAPVALID		BIT(8)
> +#define MPTCP_SUBFLOW_FLAGS_MCAP_REM	BIT(0)
> +#define MPTCP_SUBFLOW_FLAGS_MCAP_LOC	BIT(1)
> +#define MPTCP_SUBFLOW_FLAGS_JOIN_REM	BIT(2)
> +#define MPTCP_SUBFLOW_FLAGS_JOIN_LOC	BIT(3)
> +#define MPTCP_SUBFLOW_FLAGS_BKUP_REM	BIT(4)
> +#define MPTCP_SUBFLOW_FLAGS_BKUP_LOC	BIT(5)
> +#define MPTCP_SUBFLOW_FLAGS_4THACK	BIT(6)
> +#define MPTCP_SUBFLOW_FLAGS_CONNECTED	BIT(7)
> +#define MPTCP_SUBFLOW_FLAGS_MAPVALID	BIT(8)

but then names may become too long and might hurt eyes that read misc/ss.c
. Maybe the word 'FLAG' is pleonastic, since we are talking about BIT(x)
of a netlink attribute whose name is MPTCP_SUBFLOW_FLAGS.

What about MPTCP_SUBFLOW_F_<...> ?


[...]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 25f62679903e..452e873dc722 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -313,7 +313,7 @@ static inline bool before64(__u64 seq1, __u64 seq2)
>  =

>  #define after64(seq2, seq1)	before64(seq1, seq2)
>  =

> -size_t subflow_get_info_size(const struct sock *sk);
> -int subflow_get_info(const struct sock *sk, struct sk_buff *skb);
> +size_t mptcp_diag_subflow_get_info_size(const struct sock *sk);
> +int mptcp_diag_subflow_get_info(const struct sock *sk, struct sk_buff *s=
kb);
>  =

>  #endif /* __MPTCP_PROTOCOL_H */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0f4a2a19d246..99cbb8351584 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -492,8 +492,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_most=
ly =3D {
>  	.init		=3D subflow_ulp_init,
>  	.release	=3D subflow_ulp_release,
>  	.clone		=3D subflow_ulp_clone,
> -	.get_info	=3D subflow_get_info,
> -	.get_info_size	=3D subflow_get_info_size,
> +	.get_info	=3D mptcp_diag_subflow_get_info,
> +	.get_info_size	=3D mptcp_diag_subflow_get_info_size,
>  };

and here we can shorten the name of these two functions, getting rid of =

_get, since it's implicit for sock_diags.

WDYT?

-- =

davide
=20

--===============2177432461619746284==--
