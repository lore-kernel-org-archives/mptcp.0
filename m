Content-Type: multipart/mixed; boundary="===============5664177227321216419=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 2/8] mptcp: add the outgoing
 ADD_ADDR port support
Date: Fri, 30 Oct 2020 16:55:02 -0700
Message-ID: <c2eb1c84-24cc-2c66-ae2f-0e4862fcb46@linux.intel.com>
In-Reply-To: 28c900686b7ce170435daec8d9cd71527636a8af.1603952836.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6498

--===============5664177227321216419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2020, Geliang Tang wrote:

> This patch added a new add_addr_signal type named MPTCP_ADD_ADDR_PORT,
> to identify this is an address with port.
>
> It also added a new argument 'port' for both mptcp_add_addr_len and
> mptcp_pm_add_addr_signal.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c  | 10 +++++++---
> net/mptcp/pm.c       |  5 +++--
> net/mptcp/protocol.h | 17 +++++++++++++++--
> 3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7c928286c0da..24117c45f4e1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -586,6 +586,7 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
> 	unsigned int opt_size =3D *size;
> 	struct mptcp_addr_info saddr;
> 	bool echo;
> +	bool port;
> 	int len;
>
> 	if (mptcp_pm_should_add_signal_ipv6(msk) &&
> @@ -597,10 +598,10 @@ static bool mptcp_established_options_add_addr(stru=
ct sock *sk, struct sk_buff *
> 	}
>
> 	if (!mptcp_pm_should_add_signal(msk) ||
> -	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
> +	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo, &port)))
> 		return false;
>
> -	len =3D mptcp_add_addr_len(saddr.family, echo);
> +	len =3D mptcp_add_addr_len(saddr.family, echo, port);
> 	if (remaining < len)
> 		return false;
>
> @@ -608,6 +609,8 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
> 	if (drop_other_suboptions)
> 		*size -=3D opt_size;
> 	opts->addr_id =3D saddr.id;
> +	if (port)
> +		opts->port =3D saddr.port;
> 	if (saddr.family =3D=3D AF_INET) {
> 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> 		opts->addr =3D saddr.addr;
> @@ -630,7 +633,8 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
> 		}
> 	}
> #endif
> -	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d", opts->addr_id, opts->=
ahmac, echo);
> +	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> +		 opts->addr_id, opts->ahmac, echo, ntohs(opts->port));

Remove ntohs() if opts->port converted to u16.

>
> 	return true;
> }
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 75c5040e8d5d..6d4be02681fa 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -188,7 +188,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk=
, u8 rm_id)
> /* path manager helpers */
>
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> -			      struct mptcp_addr_info *saddr, bool *echo)
> +			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
> {
> 	int ret =3D false;
>
> @@ -199,8 +199,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
> 		goto out_unlock;
>
> 	*echo =3D mptcp_pm_should_add_signal_echo(msk);
> +	*port =3D mptcp_pm_should_add_signal_port(msk);
>
> -	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
> +	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
> 		goto out_unlock;
>
> 	*saddr =3D msk->pm.local;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f303c46bcc29..2a5db34f63bf 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -171,6 +171,7 @@ enum mptcp_add_addr_status {
> 	MPTCP_ADD_ADDR_SIGNAL,
> 	MPTCP_ADD_ADDR_ECHO,
> 	MPTCP_ADD_ADDR_IPV6,
> +	MPTCP_ADD_ADDR_PORT,
> };
>
> struct mptcp_pm_data {
> @@ -539,13 +540,25 @@ static inline bool mptcp_pm_should_add_signal_ipv6(=
struct mptcp_sock *msk)
> 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
> }
>
> +static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *ms=
k)
> +{
> +	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_PORT);
> +}
> +
> static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> {
> 	return READ_ONCE(msk->pm.rm_addr_signal);
> }
>
> -static inline unsigned int mptcp_add_addr_len(int family, bool echo)
> +static inline unsigned int mptcp_add_addr_len(int family, bool echo, boo=
l port)
> {
> +	if (port) {
> +		if (family =3D=3D AF_INET)
> +			return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT
> +				    : TCPOLEN_MPTCP_ADD_ADDR_PORT;
> +		return echo ? TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT : TCPOLEN_MPTCP_ADD_AD=
DR6_PORT;
> +	}
> +
> 	if (family =3D=3D AF_INET)
> 		return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE
> 			    : TCPOLEN_MPTCP_ADD_ADDR;

This helper function is getting kind of complicated for what it does. Can =

you convert it to add up the correct size rather than returning one of the =

eight constants?

Like:

unsigned int len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;

if (echo)
         len +=3D 8;

if (family =3D=3D AF_INET6)
         len +=3D 12;
...

> @@ -553,7 +566,7 @@ static inline unsigned int mptcp_add_addr_len(int fam=
ily, bool echo)
> }
>
> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
> -			      struct mptcp_addr_info *saddr, bool *echo);
> +			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> 			     u8 *rm_id);
> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc=
);
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============5664177227321216419==--
