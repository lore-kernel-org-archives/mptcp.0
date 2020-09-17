Content-Type: multipart/mixed; boundary="===============6896860332107242473=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3] mptcp: Fix unsigned 'max_seq' compared with
 zero in mptcp_data_queue_ofo
Date: Thu, 17 Sep 2020 10:18:51 +0200
Message-ID: <cea6d18e823ed89270a5bb2cad9c65377b520678.camel@redhat.com>
In-Reply-To: 20200917011233.2948595-1-yebin10@huawei.com
X-Status: 
X-Keywords:                  
X-UID: 5909

--===============6896860332107242473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-17 at 09:12 +0800, Ye Bin wrote:
> Fixes coccicheck warnig:
> net/mptcp/protocol.c:164:11-18: WARNING: Unsigned expression compared wit=
h zero: max_seq > 0
> =

> Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue")
> Reported-by: Hulk Robot <hulkci(a)huawei.com>
> Signed-off-by: Ye Bin <yebin10(a)huawei.com>
> ---
>  net/mptcp/protocol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ef0dd2f23482..386cd4e60250 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -157,11 +157,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock =
*msk, struct sk_buff *skb)
>  	struct rb_node **p, *parent;
>  	u64 seq, end_seq, max_seq;
>  	struct sk_buff *skb1;
> +	int space;
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

Thank you for addressing our feedback!

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============6896860332107242473==--
