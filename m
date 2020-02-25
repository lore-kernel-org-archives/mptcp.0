Content-Type: multipart/mixed; boundary="===============7143142576503949977=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/8] mptcp: update mptcp ack sequence
 from work queue
Date: Tue, 25 Feb 2020 13:56:12 +0100
Message-ID: <2f4f13e9cfd97e89c8fec414a1c2dd3881732ca8.camel@redhat.com>
In-Reply-To: 20200225124926.GI19559@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3786

--===============7143142576503949977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-25 at 13:49 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > +	do {
> > > +		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> > > +
> > > +		if (!ssk)
> > > +			break;
> > > +
> > > +		lock_sock(ssk);
> > =

> > I'm wondering if bh_lock_sock(ssk) would suffice here?
> > =

> > If so we could do the skbs move from mptcp_release_cb() in patch 8.
> > =

> > But it looks like the full lock_sock() is required by the skb_orphan()
> > call, which in turn modifies ssk->sk_forward_alloc, so no luck right?
> =

> Yep, the destructor of the skbs on the ssk rx queue assumes its called
> with the ssk owned.
> =

> We could of course do bh_lock+then check 'owned' but I'm not sure its
> worth it.

Yup, also I think is not trivial take the correct delayed action with
multiple subflows.

> I'd suggest to keep the 'direct move from release_cb' in mind as
> something we could try to do later.

Agreed! definitely not needed now - and possibly even not needed later,
given the complexity.

Thanks,

Paolo

--===============7143142576503949977==--
