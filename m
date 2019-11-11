Content-Type: multipart/mixed; boundary="===============2685264921200279613=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Mon, 11 Nov 2019 13:50:35 -0800
Message-ID: <93158d7788e55c71ff95b741257923df9518772e.camel@linux.intel.com>
In-Reply-To: 5a6b5f4f58d6bf3bd425ed0162ac177643d734f3.1573488751.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2473

--===============2685264921200279613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Paolo -

On Mon, 2019-11-11 at 17:53 +0100, Paolo Abeni wrote:
> since such option will always fit the tcp header, module bugs.

"modulo"

How is it guaranteed that it will always fit, now and in the future?

Peter.

> Note that this patch preserve a bool ret value for
> mptcp_established_options_dss(),
> even if it now always returns true. That will simplify a bit later patches
> for v1 support.
> =

> Squash-to: "mptcp: Write MPTCP DSS headers to outgoing data packets"
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/options.c | 71 ++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 40 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index fa10086b5b74..cd16baea0666 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -200,7 +200,7 @@ static bool mptcp_established_options_mp(struct sock =
*sk, unsigned int *size,
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>  =

> -	if (!subflow->fourth_ack && remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
> +	if (!subflow->fourth_ack) {
>  		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
>  		opts->sndr_key =3D subflow->local_key;
>  		opts->rcvr_key =3D subflow->remote_key;
> @@ -220,6 +220,7 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  {
>  	unsigned int dss_size =3D 0;
>  	struct mptcp_ext *mpext;
> +	struct mptcp_sock *msk;
>  	unsigned int ack_size;
>  =

>  	mpext =3D skb ? mptcp_get_ext(skb) : NULL;
> @@ -229,15 +230,10 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
>  =

>  		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
>  =

> -		if (map_size <=3D remaining) {
> -			remaining -=3D map_size;
> -			dss_size =3D map_size;
> -			if (mpext)
> -				opts->ext_copy =3D *mpext;
> -		} else {
> -			opts->ext_copy.use_map =3D 0;
> -			WARN_ONCE(1, "MPTCP: Map dropped");
> -		}
> +		remaining -=3D map_size;
> +		dss_size =3D map_size;
> +		if (mpext)
> +			opts->ext_copy =3D *mpext;
>  	}
>  =

>  	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> @@ -246,29 +242,19 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
>  	if (dss_size =3D=3D 0)
>  		ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
>  =

> -	if (ack_size <=3D remaining) {
> -		struct mptcp_sock *msk;
> -
> -		dss_size +=3D ack_size;
> -
> -		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> -		if (msk) {
> -			opts->ext_copy.data_ack =3D msk->ack_seq;
> -		} else {
> -			mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
> -					      NULL, &opts->ext_copy.data_ack);
> -			opts->ext_copy.data_ack++;
> -		}
> +	dss_size +=3D ack_size;
>  =

> -		opts->ext_copy.ack64 =3D 1;
> -		opts->ext_copy.use_ack =3D 1;
> +	msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> +	if (msk) {
> +		opts->ext_copy.data_ack =3D msk->ack_seq;
>  	} else {
> -		opts->ext_copy.use_ack =3D 0;
> -		WARN(1, "MPTCP: Ack dropped");
> +		mptcp_crypto_key_sha1(mptcp_subflow_ctx(sk)->remote_key,
> +				      NULL, &opts->ext_copy.data_ack);
> +		opts->ext_copy.data_ack++;
>  	}
>  =

> -	if (!dss_size)
> -		return false;
> +	opts->ext_copy.ack64 =3D 1;
> +	opts->ext_copy.use_ack =3D 1;
>  =

>  	*size =3D ALIGN(dss_size, 4);
>  	return true;
> @@ -279,22 +265,27 @@ bool mptcp_established_options(struct sock *sk, str=
uct sk_buff *skb,
>  			       struct mptcp_out_options *opts)
>  {
>  	unsigned int opt_size =3D 0;
> +	bool ret =3D true;
>  =

>  	if (!mptcp_subflow_ctx(sk)->mp_capable)
>  		return false;
>  =

> -	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
> -		*size +=3D opt_size;
> -		remaining -=3D opt_size;
> -		return true;
> -	} else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
> -						 opts)) {
> -		*size +=3D opt_size;
> -		remaining -=3D opt_size;
> -		return true;
> -	}
> +	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts))
> +		ret =3D true;
> +	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
> +						 opts))
> +		ret =3D true;
>  =

> -	return false;
> +	/* we reserved enough space for the above options, and exceeding the
> +	 * TCP option space would be fatal
> +	 */
> +	if (WARN_ON_ONCE(opt_size > remaining))
> +		return false;
> +
> +	*size +=3D opt_size;
> +	remaining -=3D opt_size;
> +
> +	return ret;
>  }
>  =

>  bool mptcp_synack_options(const struct request_sock *req, unsigned int *=
size,

--===============2685264921200279613==--
