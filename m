Content-Type: multipart/mixed; boundary="===============7791226209508089793=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 3/7] mptcp: avoid blocking in
 tcp_sendpages due to skb alloc
Date: Thu, 07 May 2020 13:27:08 +0200
Message-ID: <ed85f8652b22c3c7f7f8cfa83e5c8973303621e7.camel@redhat.com>
In-Reply-To: 20200506130228.1478-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4334

--===============7791226209508089793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-06 at 15:02 +0200, Florian Westphal wrote:
> If memory is tight, tcp_sendpages may fail because it can't
> allocate the skb head.
> =

> Now that we pass DONTWAIT to tcp_sendpages it won't block anymore on the
> subflow socket when this happens.
> =

> We can avoid such allocation failure in tcp code by preallocating an skb
> skb when we pick the subflow to use.

The sk_tx_skb_cache usage caused some TCP regression upstream:

commit 0b7d7f6b22084a3156f267c85303908a8f4c9a08
Author: Eric Dumazet <edumazet(a)google.com>
Date:   Fri Jun 14 16:22:20 2019 -0700

    tcp: add tcp_tx_skb_cache sysctl

but that one was not very clear and I guess does not matter for MPTCP -
lacking an established baseline.

So all good ;)

> @@ -656,9 +677,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
>  static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;
> +	struct sock *sk =3D (struct sock *)msk;
>  	struct sock *backup =3D NULL;
>  =

> -	sock_owned_by_me((const struct sock *)msk);
> +	sock_owned_by_me(sk);
> +
> +	if (!mptcp_sendmsg_alloc_skb(sk))
> +		return NULL;
>  =

>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);

Don't we need the same for mptcp_subflow_get_retrans() ?

Thanks!

/P

--===============7791226209508089793==--
