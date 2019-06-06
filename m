Content-Type: multipart/mixed; boundary="===============2187089528160711336=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 7/7] mptcp: Refactor mptcp_established_options()
 to single hook
Date: Thu, 06 Jun 2019 09:34:23 +0200
Message-ID: <c9236f57cb352ca229e2af1386bd788d13b63427.camel@redhat.com>
In-Reply-To: 20190606003632.2863-8-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1304

--===============2187089528160711336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I have a couple of very minor comments here, please see below.

On Wed, 2019-06-05 at 17:36 -0700, Peter Krystad wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0b4865c55e4e..6ad88b70de6c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/
> @@ -443,6 +443,7 @@ struct tcp_out_options {
>  =

>  static void mptcp_options_write(__be32 *ptr, struct tcp_out_options *opt=
s)
>  {
> +	pr_debug("entered");

I think the above debug message could be moved under the CONFIG_MPTCP
conditional, or possibly even dropped.

>  #if IS_ENABLED(CONFIG_MPTCP)
>  	if (unlikely(OPTION_MPTCP & opts->options))
>  		mptcp_write_options(ptr, &opts->mptcp);

[...]

> @@ -338,6 +341,27 @@ bool mptcp_established_options_dss(struct sock *sk, =
struct sk_buff *skb,
>  	return true;
>  }
>  =

> +bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
> +			       unsigned int *size, unsigned int remaining,
> +			       struct mptcp_out_options *opts)
> +{
> +	unsigned int opt_size =3D 0;
> +
> +	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
> +		*size +=3D opt_size;
> +		remaining -=3D opt_size;
> +		return true;
> +	}
> +	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
> +					       opts)) {

I think the preferred kernel style is: '} else if ('...

Perhpas moving here the 'if (subflow->mp_capable' test from both
mptcp_established_options_dss() and mptcp_established_options_mp()
would simplify the code?

Thanks!

Paolo



--===============2187089528160711336==--
