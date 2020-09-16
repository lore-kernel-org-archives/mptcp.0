Content-Type: multipart/mixed; boundary="===============4248082019980657126=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Fix unsigned 'max_seq' compared with zero
 in mptcp_data_queue_ofo
Date: Wed, 16 Sep 2020 10:25:42 +0200
Message-ID: <5f5aa2608856865a8b3e4dfd4195e2de31ba9762.camel@redhat.com>
In-Reply-To: 20200916033003.1186727-1-yebin10@huawei.com
X-Status: 
X-Keywords:                  
X-UID: 5893

--===============4248082019980657126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2020-09-16 at 11:30 +0800, Ye Bin wrote:
> Fixes make coccicheck warnig:
> net/mptcp/protocol.c:164:11-18: WARNING: Unsigned expression compared wit=
h zero: max_seq > 0
> =

> Reported-by: Hulk Robot <hulkci(a)huawei.com>
> Signed-off-by: Ye Bin <yebin10(a)huawei.com>
> ---
>  net/mptcp/protocol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ef0dd2f23482..3b71f6202524 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -155,13 +155,14 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  {
>  	struct sock *sk =3D (struct sock *)msk;
>  	struct rb_node **p, *parent;
> +	int space;
>  	u64 seq, end_seq, max_seq;
>  	struct sk_buff *skb1;
>  =

>  	seq =3D MPTCP_SKB_CB(skb)->map_seq;
>  	end_seq =3D MPTCP_SKB_CB(skb)->end_seq;
> -	max_seq =3D tcp_space(sk);
> -	max_seq =3D max_seq > 0 ? max_seq + msk->ack_seq : msk->ack_seq;
> +	space =3D tcp_space(sk);
> +	max_seq =3D space > 0 ? space + msk->ack_seq : msk->ack_seq;
>  =

>  	pr_debug("msk=3D%p seq=3D%llx limit=3D%llx empty=3D%d", msk, seq, max_s=
eq,
>  		 RB_EMPTY_ROOT(&msk->out_of_order_queue));

The patch looks correct, but could you please add an appropriate
'Fixes' tag, and also preserve the reverse x-mas tree order for
variables declaration?

Also, this patch should likely target the net-next tree, the MPTCP OoO
queue is present only there.

Thanks!

Paolo

--===============4248082019980657126==--
