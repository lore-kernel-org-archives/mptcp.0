Content-Type: multipart/mixed; boundary="===============6572708552724652215=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/9] mptcp: fix race from mptcp_close/mptcp join
Date: Mon, 02 Dec 2019 14:29:22 +0100
Message-ID: <20191202132922.GM795@breakpoint.cc>
In-Reply-To: 4b1827db5dae62d9f75899c1951fce56edffb5e4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2738

--===============6572708552724652215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > +	/* mptcp socket already closing? */
> > +	if (parent->sk_state !=3D TCP_ESTABLISHED)
> > +		goto out;
> > +
> > +	ret =3D true;
> >  	list_add_tail(&subflow->node, &msk->conn_list);
> =

> =

> This relies on mptcp_close() setting msk status before acquiring the
> msk socket lock, right? If so perhaps we can add a comment there to
> document the locking schema?

No, if mptcp_close would set its state after acquiring the lock this
will still work, either the above check triggers (mptcp_close already
finished) or mptcp_close is still blocked on the lock.

The second case is no different from "mptcp_close was not called".
--===============6572708552724652215==--
