Content-Type: multipart/mixed; boundary="===============0615780472532510880=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC mptcp 2/2] mptcp: allow dumping subflow
 context to userspace
Date: Thu, 16 May 2019 16:51:17 -0700
Message-ID: <alpine.OSX.2.21.1905161632570.41252@mjmartin-mac01.local>
In-Reply-To: 44355666d00f9f993af834352c5ada97d1748783.1557824658.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1193

--===============0615780472532510880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 14 May 2019, Davide Caratti wrote:

> add ulp-specific diagnostic functions, so that subflow information can be
> dumped to userspace programs like 'ss'.
>
> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>
> Notes:
>     - this is a POC patch where I only dump few members of the subflow, a=
nd
>       put them in a nested attribute so that it's possible to read them in
>       a program regardless the value of 'subflow_ulp_ops.name'. Please let
>       me know if we should dump additional information, or if some of tho=
se
>       I included don't make sense.
>
> include/uapi/linux/inet_diag.h |  5 +++
> include/uapi/linux/mptcp.h     | 21 ++++++++++
> net/mptcp/Makefile             |  2 +-
> net/mptcp/diag.c               | 73 ++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h           |  3 ++
> net/mptcp/subflow.c            |  2 +
> 6 files changed, 105 insertions(+), 1 deletion(-)
> create mode 100644 include/uapi/linux/mptcp.h
> create mode 100644 net/mptcp/diag.c
>
> diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_dia=
g.h
> index 195e10550dc8..ae341c9bc4e6 100644
> --- a/include/uapi/linux/inet_diag.h
> +++ b/include/uapi/linux/inet_diag.h
> @@ -204,4 +204,9 @@ union tcp_cc_info {
> 	struct tcp_dctcp_info	dctcp;
> 	struct tcp_bbr_info	bbr;
> };
> +
> +enum {
> +	ULPINFO_MPTCP_SUBFLOW,
> +	__ULPINFO_MAX
> +};
> #endif /* _UAPI_INET_DIAG_H_ */
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> new file mode 100644
> index 000000000000..bba74a97e6c2
> --- /dev/null
> +++ b/include/uapi/linux/mptcp.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_MPTCP_H
> +#define _UAPI_MPTCP_H
> +
> +#include <linux/types.h>
> +
> +#define SUBFLOW_FLAGS_MP_REMOTE BIT(0)
> +#define SUBFLOW_FLAGS_MP_LOCAL  BIT(1)
> +#define SUBFLOW_FLAGS_DSS_CSUM  BIT(2)
> +
> +enum {
> +	MPTCP_SUBFLOW_LOCAL_KEY,
> +	MPTCP_SUBFLOW_REMOTE_KEY,
> +	MPTCP_SUBFLOW_FLAGS,
> +	MPTCP_SUBFLOW_PAD,
> +	__MPTCP_SUBFLOW_MAX
> +};

The 32-bit subflow->token is also useful, since that's what would be =

relevant for future MP_JOIN attempts.


> +
> +#define MPTCP_SUBFLOW_MAX (__MPTCP_SUBFLOW_MAX - 1)
> +
> +#endif /* _UAPI_MPTCP_H */
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 178ae81d8b66..f93ac5bc1b90 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -1,4 +1,4 @@
> # SPDX-License-Identifier: GPL-2.0
> obj-$(CONFIG_MPTCP) +=3D mptcp.o
>
> -mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o
> +mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o diag.o
> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> new file mode 100644
> index 000000000000..27266192da88
> --- /dev/null
> +++ b/net/mptcp/diag.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/module.h>
> +#include <linux/net.h>
> +#include <linux/sock_diag.h>
> +#include <linux/inet_diag.h>
> +#include <linux/tcp.h>
> +
> +#include <net/netlink.h>
> +#include <net/tcp.h>
> +#include <net/mptcp.h>
> +
> +#include <uapi/linux/mptcp.h>
> +#include "protocol.h"
> +
> +int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct mptcp_subflow_info *info;
> +	struct subflow_context *subflow =3D subflow_ctx(sk);
> +	struct nlattr *start =3D 0;
> +	u32 flags =3D 0;
> +	int ret =3D 0;
> +
> +	if (!subflow)
> +		goto end;
> +
> +	start =3D nla_nest_start_noflag(skb, ULPINFO_MPTCP_SUBFLOW);
> +	if (!start) {
> +		ret =3D -EMSGSIZE;
> +		goto nla_failure;
> +	}
> +	if (subflow->mp_capable)
> +		flags |=3D SUBFLOW_FLAGS_MP_REMOTE;

If mp_capable is true, the socket is using MPTCP. If it's false, it has =

done a fallback to TCP. For userspace, might be better to name it =

SUBFLOW_FLAGS_IN_TCP_FALLBACK (or similar) if !mp_capable.

> +	if (subflow->request_mptcp)
> +		flags |=3D SUBFLOW_FLAGS_MP_LOCAL;

This is only used at connect time and is only false if ULP setup failed, =

so I don't think it's useful.

> +	if (subflow->request_cksum)
> +		flags |=3D SUBFLOW_FLAGS_DSS_CSUM;

subflow->use_checksum is the field to check for this flag.


Thanks for the patch, it will be helpful to have more visibility at run =

time.

Mat


> +
> +	if (nla_put_be64(skb, MPTCP_SUBFLOW_LOCAL_KEY,
> +			 cpu_to_be64(subflow->local_key),
> +			 MPTCP_SUBFLOW_PAD) ||
> +	    nla_put_be64(skb, MPTCP_SUBFLOW_REMOTE_KEY,
> +			 cpu_to_be64(subflow->remote_key),
> +			 MPTCP_SUBFLOW_PAD) ||
> +	    nla_put_u32(skb, MPTCP_SUBFLOW_FLAGS, flags)) {
> +		ret =3D -EMSGSIZE;
> +		goto nla_failure;
> +	}
> +	nla_nest_end(skb, start);
> +end:
> +	return ret;
> +
> +nla_failure:
> +	nla_nest_cancel(skb, start);
> +	goto end;
> +}
> +
> +size_t subflow_get_info_size(struct sock *sk)
> +{
> +	struct subflow_context *subflow =3D subflow_ctx(sk);
> +	size_t size =3D 0;
> +
> +	if (!subflow)
> +		goto end;
> +
> +	size +=3D nla_total_size(0) +  /* ULPINFO_MPTCP_SUBFLOW */
> +		nla_total_size_64bit(8) + /* MPTCP_SUBFLOW_LOCAL_KEY */
> +		nla_total_size_64bit(8) + /* MPTCP_SUBFLOW_REMOTE_KEY */
> +		nla_total_size(4) + /* MPTCP_SUBFLOW_FLAGS */
> +		0;
> +end:
> +	return size;
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 81260c737046..721b28e26bbf 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -144,4 +144,7 @@ static inline struct mptcp_ext *mptcp_get_ext(struct =
sk_buff *skb)
> 	return (struct mptcp_ext *)skb_ext_find(skb, SKB_EXT_MPTCP);
> }
>
> +size_t subflow_get_info_size(struct sock *sk);
> +int subflow_get_info(struct sock *sk, struct sk_buff *skb);
> +
> #endif /* __MPTCP_PROTOCOL_H */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f88bc48ca997..2d4f810bc2d2 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -262,6 +262,8 @@ static struct tcp_ulp_ops subflow_ulp_ops __read_most=
ly =3D {
> 	.init		=3D subflow_ulp_init,
> 	.release	=3D subflow_ulp_release,
> 	.clone		=3D subflow_ulp_clone,
> +	.get_info	=3D subflow_get_info,
> +	.get_info_size	=3D subflow_get_info_size,
> };
>
> static int subflow_ops_init(struct request_sock_ops *subflow_ops)
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============0615780472532510880==--
