Content-Type: multipart/mixed; boundary="===============3207275108093881036=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH RFC 08/11] tcp: syncookies: keep mptcp option
 enabled
Date: Mon, 27 Jul 2020 10:57:28 +0200
Message-ID: <20200727085728.GH23458@breakpoint.cc>
In-Reply-To: 377c3773a4003f9667c9f03fad2e7537a3fdb1ba.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5300

--===============3207275108093881036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> >  	treq =3D tcp_rsk(req);
> >  	treq->tfo_listener =3D false;
> >  =

> > -	if (IS_ENABLED(CONFIG_MPTCP))
> > -		treq->is_mptcp =3D 0;
> > +	if (treq->is_mptcp) {
> > +		int err =3D mptcp_subflow_init_cookie_req(req, sk, skb);
> > +
> > +		if (err)
> > +			goto out_free;
> > +	}
> =

> It looks like 'treq->is_mptcp' is not initialized here ?

Yes, this is resolved now.

> What about moving the whole oops selection, init_reqsk_alloc() call,
> is_mptcp init and mptcp_subflow_init_cookie_req() call in an header
> only helper? (say tcp_reqsk_alloc() or the like)

ipv6 uses tcp6_request_sock_ops, so they are not 100% the same,
unfortunately.

What did you have in mind?
--===============3207275108093881036==--
