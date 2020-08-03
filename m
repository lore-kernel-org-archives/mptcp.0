Content-Type: multipart/mixed; boundary="===============3634527122175199623=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 07/12] mptcp: cleanup
 mptcp_subflow_discard_data()
Date: Mon, 03 Aug 2020 12:54:03 +0200
Message-ID: <8918519002086e1d8eee65ec4f463c0cfeae8e55.camel@redhat.com>
In-Reply-To: 20200801231846.GF29169@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5434

--===============3634527122175199623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-08-02 at 01:18 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> Hmmm, a changelog would have been nice 8-)

whoops... I added the comments to most patch just before the submit,
but I forgot about this one...
> =

> > -	/* discard mapped data */
> > -	pr_debug("discarding %zu bytes, current map len=3D%d", delta,
> > -		 map_remaining);
> > -	if (delta) {
> > -		read_descriptor_t desc =3D {
> > -			.count =3D delta,
> > -		};
> > -		int ret;
> > -
> > -		ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
> =

> tcp_read_sock tosses 'delta' bytes, and may zap multiple skbs, but after
> this change only at most one skb gets tossed.
> =

> >  	return 0;
> >  }
> =

> Nit: After this change, mptcp_subflow_discard_data() always returns 0.
> =

> > @@ -853,7 +824,7 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
> >  		/* only accept in-sequence mapping. Old values are spurious
> >  		 * retransmission
> >  		 */
> > -		if (mptcp_subflow_discard_data(ssk, old_ack - ack_seq))
> > +		if (mptcp_subflow_discard_data(ssk, skb, old_ack - ack_seq))
> >  			goto fatal;
> =

> ... so this conditional can be removed.
> =

> >  		return false;
> =

> Wouldn't it make sense to get rid of the return false too so that this
> checks if there is another skb to process?  This would also obsolete my
> 'may zap multiple skbs' comment above since the caller would invoke the
> discard helper again if next skb is also outdated.

Yep, will look at this option.

Thanks!

/P

--===============3634527122175199623==--
