Content-Type: multipart/mixed; boundary="===============1121137342018914007=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 7/7] mptcp: add netlink event support
Date: Wed, 20 Jan 2021 13:27:09 +0100
Message-ID: <20210120122709.GO19605@breakpoint.cc>
In-Reply-To: 85d38d39-fe36-5605-88be-f67ed14864f8@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7441

--===============1121137342018914007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > + * MPTCP_EVENT_CREATED: token, family, saddr4 | saddr6, daddr4 | daddr=
6,
> > + *                         sport, dport
> > + *    A new MPTCP connection has been created. It is the good time to =
allocate
> > + *    memory and send ADD_ADDR if needed. Depending on the traffic-pat=
terns
> > + *    it can take a long time until the MPTCP_EVENT_ESTABLISHED is sen=
t.
> > + *
> > + * MPTCP_EVENT_ESTABLISHED: token, family, saddr4 | saddr6, daddr4 | d=
addr6,
> > + *			    sport, dport
> > + *    A MPTCP connection is established (can start new subflows).
> > + *
> > + * MPTCP_EVENT_CLOSED: token
> > + *    A MPTCP connection has stopped.
> > + *
> > + * MPTCP_EVENT_ANNOUNCED: token, rem_id, family, daddr4 | daddr6 [, dp=
ort]
> > + *    A new address has been announced by the peer.
> > + *
> > + * MPTCP_EVENT_REMOVED: token, rem_id
> > + *    An address has been lost by the peer.
> > + *
> > + * MPTCP_EVENT_SUB_ESTABLISHED: token, family, saddr4 | saddr6,
> > + *                              daddr4 | daddr6, sport, dport, backup,
> > + *                              if_idx
> =

> Even if it is quite obvious, should we add a comment for this one like for
> the others, e.g.
> =

>   A new subflow has been established.
> =

> (at least to explain that "sub" stands for "subflow" :) )

Done.

> > + *
> > + * MPTCP_EVENT_SUB_CLOSED: token, family, saddr4 | saddr6, daddr4 | da=
ddr6,
> > + *                         sport, dport, backup, if_idx
> > + *    A subflow has been closed.
> =

> I noticed that the error (copy of sk_err) is not in the arguments.
> Is it simply because we don't need them in the first version or because
> there is a technical issue?

No, i've added it now for v2.  It exports ssk->sk_err in the subflow
announcements.

> > + * MPTCP_EVENT_SUB_PRIORITY: token, family, saddr4 | saddr6, daddr4 | =
daddr6,
> > + *                              sport, dport, backup, if_idx
> > + */
> =

> May we add a short description here too?
> =

>   The priority of a subflow has changed.

Sure, I took the one from mptc kernel.

> > +static int mptcp_event_sub_established(struct sk_buff *skb, const stru=
ct mptcp_sock *msk, const struct sock *ssk)
> =

> (tiny detail: is it OK to have such long line? Same for the functions bel=
ow.
> Just to avoid checkpatch warnings but it is maybe not catched by
> checkpatch?)

No, checkpatch barfs here.  I've added linebreaks everywhere.

> > +static int mptcp_event_sub_closed(struct sk_buff *skb, const struct mp=
tcp_sock *msk, const struct sock *ssk)
> > +{
> > +	if (mptcp_event_sub_established(skb, msk, ssk))
> =

> That looks strange to call mptcp_event_sub_established() in
> mptcp_event_sub_closed() but I understand we want to pack the same info :)

I've renamed the function for next iteration.

> > +	struct net *net =3D sock_net((const struct sock *)msk);
> > +        struct nlmsghdr *nlh;
> =

> (detail: the indentation is not correct)

Right, I've fixed this up.

> > +	return mptcp_nl_mcast_send(net, skb, GFP_ATOMIC);
> =

> Just out of curiosity, is it always OK to have a "return f()" here while =
the
> current function returns a "void"? I am sure it is OK because the called
> function also returns "void" but no issues with some compilers (and some
> options) nor static analytic tools?

Its ok, but actually comes from an older iteration where return type was
'int'.  But since there is no way to deal with a netlink error in
a sensible way here i later changed it to void.

I've altered this to the more common
foo();
return;

> > +	if (nla_put_u32(skb, MPTCP_ATTR_REM_ID, info->id))
> =

> I think it's a u8 for rem ID.
> Same above in mptcp_event_addr_removed()

Indeed, fixed it up.

> > +	if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
> > +		goto nla_put_failure;
> > +
> > +	switch (info->family) {
> > +	case AF_INET:
> > +		if (nla_put_in_addr(skb, MPTCP_ATTR_DADDR4, info->addr.s_addr))
> =

> (I should not review that late, I blocked here a few seconds thinking you
> were using the "source" addr for DADDR :) )

Right, it would be better to use __be32 instead of struct inaddr but
that would result in more (useless) code churn so I left that as-is.

> > +	case MPTCP_EVENT_UNSPEC:
> > +		WARN_ON_ONCE(1);
> > +		break;
> =

> Probably useless but should we move this to the end and add "default"?

gcc emits a warning if you add a new name to an enum and a switch
statement doesn't handle that.

This is why there is no default branch but all the other 'should not
happen' values are listed verbatim with a warn-on.
--===============1121137342018914007==--
