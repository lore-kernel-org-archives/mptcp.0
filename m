Content-Type: multipart/mixed; boundary="===============4081636234480480019=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 09/10] mptcp: token: fold destroy_token helper
Date: Tue, 27 Aug 2019 20:08:38 +0200
Message-ID: <20190827180838.GD20113@breakpoint.cc>
In-Reply-To: ebf2bdc7-8133-664e-c4d0-bb68c33e566c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1721

--===============4081636234480480019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > -void token_destroy_request(u32 token)
> > +/**
> > + * mptcp_token_destroy_request - remove mptcp connection/token
> > + * @token - token of mptcp connection to remove
> > + *
> > + * Remove the not-yey-fully-established incoming connection identified
> =

> yey? or "yay!!!"? maybe more "yet" I guess :-D

Right.  I'll run aspell on the series next time.

> > + * by @token. If the connection isn't found, no action is taken.
> =

> Is it to explain why we don't do anything with *cur?

Right, I'll remove cur.

> >  	spin_lock_bh(&token_tree_lock);
> > -	conn =3D destroy_token(token);
> > +	conn =3D radix_tree_delete(&token_tree, token);
> >  	if (conn)
> =

> Is it no longer needed to check "conn !=3D &token_used" here?

Right, I'll add it back -- thanks!

--===============4081636234480480019==--
