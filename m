Content-Type: multipart/mixed; boundary="===============5555480262438059322=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC v3 08/10] mptcp: enable JOIN requests even if
 cookies are in use
Date: Thu, 30 Jul 2020 12:59:40 +0200
Message-ID: <20200730105940.GC5271@breakpoint.cc>
In-Reply-To: 76ef7e91f19a212e036223a052b92b0ac92dd144.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5391

--===============5555480262438059322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > +/* WRITE/READ_ONCE are used, as no locking exists for the state table.
> > + * Locking would also be useless given there is no guarantee that
> > + * the state is still valid once cookie comes back.
> > + */
> > +static void mptcp_join_store_state(struct join_entry *entry,
> > +				   const struct mptcp_subflow_request_sock *subflow_req)
> > +{
> > +	WRITE_ONCE(entry->token, subflow_req->token);
> > +	WRITE_ONCE(entry->remote_nonce, subflow_req->remote_nonce);
> > +	WRITE_ONCE(entry->local_nonce, subflow_req->local_nonce);
> > +	WRITE_ONCE(entry->backup, subflow_req->backup);
> > +	WRITE_ONCE(entry->join_id, subflow_req->remote_id);
> > +	WRITE_ONCE(entry->local_id, subflow_req->local_id);
> > +	WRITE_ONCE(entry->valid, 1);
> > +}
> =

> If I read correctly, thread/CPU 1 may overwrite partially the entry
> while thread/CPU 2 is fetching the data into subflow_req for the 3rd
> ack, correct?

Yes.

> With enough bad luck the copied values could contain consistent data
> (nonces, token) to do the hmac matching but e.g. mismatching 'ids' or
> 'backup' flags. Am I missing something?

Nope, thats correct.  As per discussion on IRC i'll add locks to avoid
this problem.

> > +void subflow_init_req_cookie_join_save(const struct mptcp_subflow_requ=
est_sock *subflow_req,
> > +				       struct sk_buff *skb)
> > +{
> > +	struct net *net =3D read_pnet(&subflow_req->sk.req.ireq_net);
> > +	struct join_entry *e;
> > +
> > +	e =3D __mptcp_join_entry_slot(skb, net);
> =

> I guess we don't need to validate the entry because hmac checking will
> follow and the hash arity is 1, right? that is, if the found entry does
> not match, no other attempt is possible. (no changes proposed/suggested
> here, just double checking I read this correctly).

I can't validate the entry, I don't see anything that could be used
to do that.  The only 'check' is that the entry was filled already
and no other CPU 'resurrected' a request socket from that entry so far.

But theoretically the entry could be 2 days old and for a completely
different msk (that then needs to have the same token of course).

When we 'restore' the rsk from the cookie store, the ACK cookie was
valid, so it should never happen for 'random' ACKs.

Also, the join path should check that the received token (in the cookie
ACK mptcp options) is the expected one.

I'll add a intentional bug, restoring a wrong local or remote nonce,
to the cookie-rsk path to make sure the join fails as expected.

> Overall I think this approach should be much more easily accepted
> upstream!

Yes, there is less surgery in TCP and listen qlen isn't ignored.
--===============5555480262438059322==--
