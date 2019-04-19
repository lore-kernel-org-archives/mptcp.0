Content-Type: multipart/mixed; boundary="===============8452273813186072748=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 3/3] mptcp: allow collapsing consecutive sendpages
 on the same substream
Date: Fri, 19 Apr 2019 18:19:38 +0200
Message-ID: <e14bed70a7317a6edff5589ddb390a3437b8ef01.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1904181637170.41859@scottgi-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1080

--===============8452273813186072748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the feedback

On Thu, 2019-04-18 at 16:56 -0700, Mat Martineau wrote:
> @@ -78,25 +91,48 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct=
 sock *ssk,
> > 	if (!psize)
> > 		return -EINVAL;
> > =

> > -	/* Mark the end of the previous write so the beginning of the
> > -	 * next write (with its own mptcp skb extension data) is not
> > -	 * collapsed.
> > -	 */
> > +	mss_now =3D tcp_send_mss(ssk, &size_goal, msg->msg_flags);
> > +	*pmss_now =3D mss_now;
> > +	*ps_goal =3D size_goal;
> > +	avail_size =3D size_goal;
> > 	skb =3D tcp_write_queue_tail(ssk);
> > -	if (skb)
> > -		TCP_SKB_CB(skb)->eor =3D 1;
> > +	if (skb) {
> > +		mpext =3D skb_ext_find(skb, SKB_EXT_MPTCP);
> > +		BUG_ON(!mpext);
> > +
> > +		/* Limit the write to the size available in the
> > +		 * current skb, if any, so that we create at most a new skb.
> > +		 * If we run out of space in the current skb (e.g. the window
> > +		 * size shrunk from last sent) a new skb will be allocated even
> > +		 * is collapsing was allowed: collapsing is effectively
> > +		 * disabled.
> > +		 */
> > +		can_collapse =3D mptcp_skb_can_collapse_to(msk, skb, mpext);
> > +		if (!can_collapse)
> > +			TCP_SKB_CB(skb)->eor =3D 1;
> > +		else if (size_goal - skb->len > 0)
> > +			avail_size =3D size_goal - skb->len;
> > +		else
> > +			can_collapse =3D false;
> =

> In this final clause, should it set eor as well? If we're not expecting a =

> collapse, it might be better to make sure it does not happen.

yes, we could set eor here, but if there is no available size in the
current skb, collapsing can't happen, otherwise is a bug. I think
setting it will not add additional safety.

> > -	if (skb =3D=3D tcp_write_queue_tail(ssk))
> > -		pr_err("no new skb %p/%p", sk, ssk);
> > +	collapsed =3D skb =3D=3D tcp_write_queue_tail(ssk);
> > +	BUG_ON(collapsed && !can_collapse);
> > =

> > 	skb =3D tcp_write_queue_tail(ssk);
> =

> Minor: seems like this skb assignment is coupled with the mpext line belo=
w =

> rather than the conditional to update mpext and exit, and could be moved =

> after the collapse check.

Agreed, I will do that in the next iteration.

Final note: it looks like this patch is not the root cause of the
stream corruption I was observing, it just uncovers a bug present in
current code. I'll try to send a fix soon.

Thanks,

Paolo


--===============8452273813186072748==--
