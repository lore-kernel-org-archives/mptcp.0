Content-Type: multipart/mixed; boundary="===============1628454923944813483=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: move page frag
 allocation in mptcp_sendmsg()"
Date: Wed, 21 Oct 2020 17:33:41 -0700
Message-ID: <c36ebc17-e7d6-25d3-a91-8dacd82b3521@linux.intel.com>
In-Reply-To: 775ff99f80d6aa5ca14e738296bc23b3a2059edd.1603298699.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6398

--===============1628454923944813483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 21 Oct 2020, Paolo Abeni wrote:

> better conflict resolution for a recent rebase
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 897c0c1d2888..975a3243d55c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -978,8 +978,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
> 	struct mptcp_ext *mpext =3D NULL;
> 	struct sk_buff *skb, *tail;
> 	bool can_collapse =3D false;
> -	int avail_size, ret;
> -	size_t psize;
> +	int avail_size;
> +	size_t ret;
>
> 	pr_debug("msk=3D%p ssk=3D%p sending dfrag at seq=3D%lld len=3D%d already=
 sent=3D%d",
> 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
> @@ -1018,15 +1018,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, st=
ruct sock *ssk,
> 			 info->limit > dfrag->data_len))
> 		return 0;
>
> -	psize =3D min_t(size_t, info->limit - info->sent, avail_size);
> -
> -	tail =3D tcp_build_frag(ssk, psize, info->flags, dfrag->page,
> -			      dfrag->offset + info->sent, &psize);
> +	ret =3D info->limit - info->sent;
> +	tail =3D tcp_build_frag(ssk, avail_size, info->flags, dfrag->page,
> +			      dfrag->offset + info->sent, &ret);
> 	if (!tail) {
> 		tcp_remove_empty_skb(sk, tcp_write_queue_tail(ssk));
> 		return -ENOMEM;
> 	}
> -	ret =3D psize;
>
> 	/* if the tail skb is still the cached one, collapsing really happened.
> 	 */
> -- =

> 2.26.2

Agreed, looks ready to squash.

--
Mat Martineau
Intel
--===============1628454923944813483==--
