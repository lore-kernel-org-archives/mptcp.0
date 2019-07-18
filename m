Content-Type: multipart/mixed; boundary="===============8135522854735141110=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 8/9] mptcp: Add handling of outgoing MP_JOIN
 requests
Date: Thu, 18 Jul 2019 10:58:26 -0700
Message-ID: <3d2e2e2ea2ec1a73559a0ce53039729e44f16c62.camel@linux.intel.com>
In-Reply-To: b4a80d24babfeb7d2747a4db85505d5b4134af0a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1537

--===============8135522854735141110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 10:04 +0200, Paolo Abeni wrote:
> On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> > @@ -329,6 +381,17 @@ int token_new_join(struct sock *sk)
> >  	return -1;
> >  }
> >  =

> > +struct sock *token_lookup(u32 token)
> > +{
> > +	struct sock *conn;
> > +
> =

> Possibly some locking is missing ??? like:
> =

> 	spin_lock_bh(&token_tree_lock);
> > +	conn =3D lookup_token(token);
> > +	if (conn)
> > +		sock_hold(conn);
> > +
> 	spin_unlock_bh(&token_tree_lock);
> =


Yes, I think you are right. Will clean up.

Peter.

> Sorry for not noticing earlier,
> =

> Paolo
> =



--===============8135522854735141110==--
