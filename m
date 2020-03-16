Content-Type: multipart/mixed; boundary="===============0729083749137842286=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] tcp: mptcp: use mptcp receive buffer space to
 select rcv window
Date: Mon, 16 Mar 2020 18:55:35 +0100
Message-ID: <adf82ec36d9f8e0e1f53ab943ac17ca03f273d5d.camel@redhat.com>
In-Reply-To: 20200312154901.540-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3955

--===============0729083749137842286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2020-03-12 at 16:49 +0100, Florian Westphal wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 306e25d743e8..b786da1db76a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2771,6 +2771,12 @@ u32 __tcp_select_window(struct sock *sk)
>  	int full_space =3D min_t(int, tp->window_clamp, allowed_space);
>  	int window;

I'm wondering if we should move the above assigments (full_space =3D ...,
allowed_space =3D ...) to an else branch below - no strong opinion, mptcp
path will be slower anyway.

Additionally, can we have a single helper fetching both mptcp full and
allowed space? The mptcp code will have a single back and fourth from
TCP to MPTCP code (likely less icache miss) and the TCP code section
will be smaller (a single call instead of two).

> +	if (sk_is_mptcp(sk)) {
> +		allowed_space =3D mptcp_full_space(sk);
> +		free_space =3D mptcp_space(sk);
> +		full_space =3D min_t(int, tp->window_clamp, allowed_space);
> +	}
> +
>  	if (unlikely(mss > full_space)) {
>  		mss =3D full_space;
>  		if (mss <=3D 0)
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index f9fe60599f79..52d76af75b7f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -738,6 +738,30 @@ bool mptcp_subflow_data_available(struct sock *sk)
>  	return subflow->data_avail;
>  }
>  =

> +/* If ssk has an mptcp parent socket, use the mptcp rcvbuf occupancy,
> + * not the ssk one.
> + *
> + * In mptcp, rwin is about the mptcp-level connection data.
> + *
> + * Data that is still on the ssk rx queue can thus be ignored,
> + * as far as mptcp peer is concerened that data is still inflight.
> + */
> +int mptcp_full_space(const struct sock *ssk)
> +{
> +	const struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	const struct sock *sk =3D READ_ONCE(subflow->conn);
> +
> +	return sk ? tcp_full_space(sk) : tcp_full_space(ssk);

After commit 58b09919626b "mptcp: create msk early" subflow->conn is
always !=3D NULL for MPTCP sockets.

Cheers,

Paolo

--===============0729083749137842286==--
