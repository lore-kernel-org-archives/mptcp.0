Content-Type: multipart/mixed; boundary="===============1810377194549661476=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Fri, 20 Sep 2019 15:45:22 -0700
Message-ID: <alpine.OSX.2.21.1909201543300.79505@tvtrimel-mobl5.amr.corp.intel.com>
In-Reply-To: f2691051949e480e3c4c5ca28b38a2005238de10.1568998504.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1896

--===============1810377194549661476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Sep 2019, Paolo Abeni wrote:

> Currently we can hit a stream's corruption with the following sequence:
> - sendmsg_frag is invoked while the write_queue tail skb's len is equal to
>  the current size_goal.
>  sendmsg_frag sets can_collapse to false, even if mptcp data are in seque=
nce.
>  Anyway it does not set eor in the write_queue skb.
> - sendmsg_frag invokes do_tcp_sendmsg(), which tries to allocate a new sk=
b -
>  as the 'size_goal - skb->len <=3D 0' condition is true.
>  But it hits memory limit and/or such allocation fails, so do_tcp_sendmsg=
()
>  jumps to the 'wait_for_memory:' label and invokes tcp_push()
> - tcp_push() tries to transmit the write queue tail skb, but due to windo=
w size
>  limit, split it, send the first half and leave in the write queue a smal=
ler
>  skb - without any ext attached
> - do_tcp_sendmsg() invokes sk_stream_wait_memory and than checks again fo=
r skb
>  allocation, this time skb->len is less than size_goal and do_tcp_sendmsg=
()
>  collapse the data on the existing skb
> - sendmsg_frag adds a new ext to the tail skb in write queue, but due to =
the above
>  it is associated with a wrong/unexpected subflow sequence number: it maps
>  a future ssn -> stream corruption
>
> This change addresses the above issue explicitly setting the 'eor' when h=
itting
> the initial condition so that tcp will not collapse the data after tcp_pu=
sh().

Thanks for the detailed description. Code looks good to me and tested fine =

(although failures remain, but I don't think this was intended to fix =

everything).

Mat


>
> Fixes: 6c80a73a33c2 ("mptcp: allow collapsing consecutive sendpages on th=
e same substream")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> Notes:
> - based on top of "mptcp: implement retransmit infrastructure",
> - the issue is present even without that series, but it become somewhat
>  reproducible with both the above triggering MP_JOIN.
> - I guess squashing to the specific commit may cause a bit of rebase conf=
lict,
>  otherwise it may be squashed to "mptcp: rework mptcp_sendmsg_frag to acc=
ept optional dfrag"
> ---
> net/mptcp/protocol.c | 15 ++++++---------
> 1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 308ced6955a8..e91f761d0da6 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -217,19 +217,16 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
>
> 		/* Limit the write to the size available in the
> 		 * current skb, if any, so that we create at most a new skb.
> -		 * If we run out of space in the current skb (e.g. the window
> -		 * size shrunk from last sent) a new skb will be allocated even
> -		 * is collapsing was allowed: collapsing is effectively
> -		 * disabled.
> +		 * Explicitly tells TCP internals to avoid collapsing on later
> +		 * queue management operation, to avoid breaking the ext <->
> +		 * SSN association set here
> 		 */
> -		can_collapse =3D mptcp_skb_can_collapse_to(*write_seq, skb,
> -							 mpext);
> +		can_collapse =3D (size_goal - skb->len > 0) &&
> +			      mptcp_skb_can_collapse_to(*write_seq, skb, mpext);
> 		if (!can_collapse)
> 			TCP_SKB_CB(skb)->eor =3D 1;
> -		else if (size_goal - skb->len > 0)
> -			avail_size =3D size_goal - skb->len;
> 		else
> -			can_collapse =3D false;
> +			avail_size =3D size_goal - skb->len;
> 	}
>
> 	if (!retransmission) {
> -- =

> 2.21.0
>

--
Mat Martineau
Intel

--===============1810377194549661476==--
