Content-Type: multipart/mixed; boundary="===============2850146874291463757=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: Remove set but not used variable
 'can_ack'
Date: Wed, 18 Mar 2020 10:26:22 +0100
Message-ID: <2a5b1c0194a92bcaa626c071701a399cc85ee0b4.camel@redhat.com>
In-Reply-To: 20200318020157.178956-1-yuehaibing@huawei.com
X-Status: 
X-Keywords:                  
X-UID: 3977

--===============2850146874291463757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-18 at 02:01 +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> =

> net/mptcp/options.c: In function 'mptcp_established_options_dss':
> net/mptcp/options.c:338:7: warning:
>  variable 'can_ack' set but not used [-Wunused-but-set-variable]
> =

> commit dc093db5cc05 ("mptcp: drop unneeded checks")
> leave behind this unused, remove it.
> =

> Signed-off-by: YueHaibing <yuehaibing(a)huawei.com>
> ---
>  net/mptcp/options.c | 2 --
>  1 file changed, 2 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 63c8ee49cef2..8ba34950241c 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -335,7 +335,6 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  	struct mptcp_sock *msk;
>  	unsigned int ack_size;
>  	bool ret =3D false;
> -	bool can_ack;
>  	u8 tcp_fin;
>  =

>  	if (skb) {
> @@ -364,7 +363,6 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
>  	/* passive sockets msk will set the 'can_ack' after accept(), even
>  	 * if the first subflow may have the already the remote key handy
>  	 */
> -	can_ack =3D true;
>  	opts->ext_copy.use_ack =3D 0;
>  	msk =3D mptcp_sk(subflow->conn);
>  	if (!READ_ONCE(msk->can_ack)) {

Yep, left-over on my side! Thanks for clearing it!

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============2850146874291463757==--
