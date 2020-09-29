Content-Type: multipart/mixed; boundary="===============1073738230290646273=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 1/2] mptcp: send out
 dedicated ADD_ADDR packet
Date: Tue, 29 Sep 2020 11:30:18 +0200
Message-ID: <a16970bc5d5b38bb47049e9cc43f4b9950361fc2.camel@redhat.com>
In-Reply-To: f3ff31b79609d428322f82016bd765486d9de302.1601278543.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6090

--===============1073738230290646273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-28 at 15:46 +0800, Geliang Tang wrote:
> @@ -584,7 +586,7 @@ static bool
> mptcp_established_options_add_addr(struct sock *sk,
>  	int len;
>  =

>  	if (!mptcp_pm_should_add_signal(msk) ||
> -	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
> +	    !(mptcp_pm_add_addr_signal(msk, sk, remaining, &saddr,
> &echo)))
>  		return false;
>  =

>  	len =3D mptcp_add_addr_len(saddr.family);
> @@ -645,6 +647,17 @@ static bool
> mptcp_established_options_rm_addr(struct sock *sk,
>  	return true;
>  }
>  =

> +static bool mptcp_check_add_addr_nospc(struct sock *sk, struct
> sk_buff *skb)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> +
> +	if (skb && skb_is_tcp_pure_ack(skb) && READ_ONCE(msk-
> >pm.add_addr_nospc))
> +		return true;
> +
> +	return false;
> +}
> +
>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  			       unsigned int *size, unsigned int
> remaining,
>  			       struct mptcp_out_options *opts)
> @@ -657,6 +670,9 @@ bool mptcp_established_options(struct sock *sk,
> struct sk_buff *skb,
>  	if (unlikely(mptcp_check_fallback(sk)))
>  		return false;
>  =

> +	if (unlikely(mptcp_check_add_addr_nospc(sk, skb)))
> +		goto add_addr;
> +

I can't follow easily the code. Here we check the 'add_addr_nospc'
field, but AFAICS, such field is initialized only later,
by mptcp_pm_add_addr_signal(), called
from mptcp_established_options_add_addr().

Should we instead set 'add_addr_nospc' in mptcp_pm_announce_addr() ?

Ninor note: the 'add_addr_nospc' name is a bit confusing to me, I would
use instead something alike 'add_addr_ipv6', or even better we could
change the 'add_addr_signal' type from bool to char, so that we could
encode the addr type there. Then here we could check for
'add_addr_signal =3D=3D AF_INET6' - possibly no need for a new field.

>  	if (mptcp_established_options_mp(sk, skb, &opt_size, remaining,
> opts))
>  		ret =3D true;
>  	else if (mptcp_established_options_dss(sk, skb, &opt_size,
> remaining,
> @@ -671,6 +687,7 @@ bool mptcp_established_options(struct sock *sk,
> struct sk_buff *skb,
>  =

>  	*size +=3D opt_size;
>  	remaining -=3D opt_size;
> +add_addr:
>  	if (mptcp_established_options_add_addr(sk, &opt_size,
> remaining, opts)) {
>  		*size +=3D opt_size;
>  		remaining -=3D opt_size;
> @@ -747,10 +764,10 @@ static bool check_fully_established(struct
> mptcp_sock *msk, struct sock *sk,
>  		goto fully_established;
>  	}
>  =

> -	/* If the first established packet does not contain MP_CAPABLE
> + data
> +	/* If the first established packet does not contain MP_CAPABLE
> + data or ADD_ADDR
>  	 * then fallback to TCP
>  	 */
> -	if (!mp_opt->mp_capable) {
> +	if (!mp_opt->mp_capable && !mp_opt->add_addr) {
>  		subflow->mp_capable =3D 0;
>  		pr_fallback(msk);
>  		__mptcp_do_fallback(msk);

I think the RFC is a bit unclear with this point, because in
section 3.4.1. says: =


"""
This [ADD_ADDR] option can be used at any time during a connection
"""

but also says that here we expect a mp_capable + data packet. =


@Christoph, should we accept ADD_ADDR here or should we reject them?

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 7e81f53d1e5d..8015ee8ba621 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -172,7 +172,8 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock
> *msk, u8 rm_id)
>  =

>  /* path manager helpers */
>  =

> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int
> remaining,
> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock
> *ssk,
> +			      unsigned int remaining,
>  			      struct mptcp_addr_info *saddr, bool
> *echo)
>  {
>  	int ret =3D false;
> @@ -183,16 +184,26 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock
> *msk, unsigned int remaining,
>  	if (!mptcp_pm_should_add_signal(msk))
>  		goto out_unlock;
>  =

> -	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
> +	if (remaining < mptcp_add_addr_len(msk->pm.local.family)) {
> +		if (msk->pm.local.family =3D=3D AF_INET6)
> +			WRITE_ONCE(msk->pm.add_addr_nospc, true);
>  		goto out_unlock;
> +	}
>  =

>  	*saddr =3D msk->pm.local;
>  	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
>  	WRITE_ONCE(msk->pm.add_addr_signal, false);
> +	WRITE_ONCE(msk->pm.add_addr_nospc, false);
>  	ret =3D true;
>  =

>  out_unlock:
>  	spin_unlock_bh(&msk->pm.lock);
> +
> +	if (READ_ONCE(msk->pm.add_addr_nospc)) {
> +		pr_debug("send ack for add_addr6");
> +		tcp_send_ack(ssk);
> +	}

I think we should pick-up a subflow and call tcp_send_ack() when
invoking mptcp_pm_announce_addr(..., false), either directly
in mptcp_pm_announce_addr() or better in a wrapping helper.

/P

--===============1073738230290646273==--
