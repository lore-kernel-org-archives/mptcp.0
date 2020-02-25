Content-Type: multipart/mixed; boundary="===============8432417435363641791=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/8] mptcp: update mptcp ack sequence
 from work queue
Date: Tue, 25 Feb 2020 13:49:26 +0100
Message-ID: <20200225124926.GI19559@breakpoint.cc>
In-Reply-To: 8049d9054ab08f3c7a68176d7fcae77478f50065.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3781

--===============8432417435363641791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > +	do {
> > +		struct sock *ssk =3D mptcp_subflow_recv_lookup(msk);
> > +
> > +		if (!ssk)
> > +			break;
> > +
> > +		lock_sock(ssk);
> =

> I'm wondering if bh_lock_sock(ssk) would suffice here?
> =

> If so we could do the skbs move from mptcp_release_cb() in patch 8.
> =

> But it looks like the full lock_sock() is required by the skb_orphan()
> call, which in turn modifies ssk->sk_forward_alloc, so no luck right?

Yep, the destructor of the skbs on the ssk rx queue assumes its called
with the ssk owned.

We could of course do bh_lock+then check 'owned' but I'm not sure its
worth it.

I'd suggest to keep the 'direct move from release_cb' in mind as
something we could try to do later.

When I tested an older version of this patch set on top of mptcp-next
then the number of times the work queue ran with nothing todo (no
data in any subflow, no retransmission pending, nothing to reclaim from
rtx queue etc. was really small -- a low 3-digit number for entire mptcp
selftest run iirc. (with poll).

--===============8432417435363641791==--
