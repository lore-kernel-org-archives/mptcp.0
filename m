Content-Type: multipart/mixed; boundary="===============1699719265541102608=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PRE-RFC 4/6] mptcp: queue data for mptcp level
 retransmission
Date: Mon, 19 Aug 2019 14:46:39 +0200
Message-ID: <0ab99aa43c716d09d5fc34259e311ab935e759f5.camel@redhat.com>
In-Reply-To: 20190819111228.GE2588@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1657

--===============1699719265541102608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 13:12 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > keep the send page fragment on an MPTCP level retransmission queue.
> > the queue entries are allocated inside the page frag allocator,
> > acquiring an additional reference to the page for each list entry.
> > =

> > Also switch to a custom page frag refill function, to ensure that
> > the current page fragment can always host an MPTCP rtx queue entry.
> > =

> > The MPTCP rtx queue is flushed at socket destroy() time.
> > +/* ensure we get enough memory for the frag hdr, beyond some minimal a=
mount of
> > + * data
> > + */
> > +bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
> > +{
> > +	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
> > +					pfrag, sk->sk_allocation)))
> =

> Where is that 32U coming from?

From sk_page_frag_refill(). mptcp_page_frag_refill() is almost the
same, it just changes the amount of memory reserved.

Another option would have renaming sk_page_frag_refill() to
__sk_page_frag_refill() adding an additional argument for the reserved
memory, and implement sk_page_frag_refill() and
mptcp_page_frag_refill() on top of that.

I can't recall why I explicitly avoided such option ;) (possibly to
avoid touching the ntworking core more)

/P


--===============1699719265541102608==--
