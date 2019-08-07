Content-Type: multipart/mixed; boundary="===============5615944127322754017=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 09/10] Use pm_get_local_id() to get the real
 local address id.
Date: Wed, 07 Aug 2019 15:08:55 -0700
Message-ID: <6f1a546e48c6c0bc7e2042a526077688bf74697c.camel@linux.intel.com>
In-Reply-To: 85a5ecdc57fdf6ec3dc2f1bf3ff3eaf405408327.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1603

--===============5615944127322754017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-02 at 16:42 +0200, Paolo Abeni wrote:
> On Thu, 2019-07-25 at 18:58 -0700, Peter Krystad wrote:
> > diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> > index b31d98ba5c0d..8e4da2d05f45 100644
> > --- a/net/mptcp/token.c
> > +++ b/net/mptcp/token.c
> > @@ -223,13 +223,15 @@ int token_join_request(struct request_sock *req, =
const struct sk_buff *skb)
> >  	spin_lock_bh(&token_tree_lock);
> >  	conn =3D lookup_token(subflow_req->token);
> >  	spin_unlock_bh(&token_tree_lock);
> > -	if (conn) {
> > -		// @@ get real local address id for this skb->saddr
> > -		subflow_req->local_id =3D 0;
> > -		new_req_join(req, conn, skb);
> > -		return 0;
> > -	}
> > -	return -1;
> > +	if (!conn)
> > +		return -1;
> > +
> > +	if (pm_get_local_id(req, conn, skb))
> > +		return -1;
> > +
> > +	new_req_join(req, conn, skb);
> > +
> > +	return 0;
> >  }
> =

> I'm sorry for the late doubt, but I think we should acquire a refcnt to
> conn while holding the token_tree_lock to protect vs cuncurrent
> shutdown of the 'conn' socket after the lookup.
> =

> Perhaps adding a new helper, alike 'token_lookup_get()' would help.

Agreed will add taking this reference.

> token_join_valid() has possibly the same issue.

Agreed will do it here too.

Peter.

> =

> /P
> =



--===============5615944127322754017==--
