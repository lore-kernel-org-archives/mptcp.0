Content-Type: multipart/mixed; boundary="===============5450390527747756383=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 5/5] mptcp: add rmem queue accounting
Date: Thu, 13 Feb 2020 15:58:49 +0100
Message-ID: <287ac3a90eaadf833003cb4f774e37878bd26194.camel@redhat.com>
In-Reply-To: 20200213102742.18937-6-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3651

--===============5450390527747756383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-13 at 11:27 +0100, Florian Westphal wrote:
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e9e87e62a184..0583429b36ac 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -172,6 +172,10 @@ void mptcp_data_ready(struct sock *sk)
>  	if (test_and_set_bit(MPTCP_WORK_DATA_READY, &msk->flags))
>  		return;
>  =

> +	/* don't schedule if mptcp sk is (still) over limit */
> +	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> +		return;
> +

I think we need a READ_ONCE() around sk->sk_rcvbuf, as we don't held
the sk socket lock here.

>  	sock_hold(sk);
>  	if (!schedule_work(&msk->rtx_work))
>  		sock_put(sk);
> @@ -993,12 +997,20 @@ static int mptcp_steal_actor(read_descriptor_t *des=
c, struct sk_buff *skb,
>  	sk =3D (struct sock *)arg->msk;
>  	ssk =3D arg->ssk;
>  =

> +	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
> +	    !sk_rmem_schedule(sk, skb, skb->truesize)) {

This has the side effect of possibly updating/decreasing 'sk_sndbuf'
via sk_stream_moderate_sndbuf(). Do we need a similar update schema for
msk->sk_sndbuf, too?

> +		if (ssk->sk_rcvbuf <=3D sk->sk_rcvbuf)
> +			return 0;
> +
> +		sk->sk_rcvbuf =3D ssk->sk_rcvbuf;
> +	}
> +

As an alternative, could we just do:

	rcvbuf =3D max(sk->sk_rcvbuf, ssk->sk_rcvbuf)
	if (rcvbuf > sk->sk_rcvbuf)
		sk->sk_rcvbuf =3D rcvbuf

before looping? =


Thanks,

Paolo

--===============5450390527747756383==--
