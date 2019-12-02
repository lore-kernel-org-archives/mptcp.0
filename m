Content-Type: multipart/mixed; boundary="===============3362186379342562228=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/9] mptcp: fix race from mptcp_close/mptcp join
Date: Mon, 02 Dec 2019 15:38:33 +0100
Message-ID: <e2aa798034272ffa93cbacdda78cc3f6cd3bf051.camel@redhat.com>
In-Reply-To: 20191202132922.GM795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2740

--===============3362186379342562228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-12-02 at 14:29 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > +	/* mptcp socket already closing? */
> > > +	if (parent->sk_state !=3D TCP_ESTABLISHED)
> > > +		goto out;
> > > +
> > > +	ret =3D true;
> > >  	list_add_tail(&subflow->node, &msk->conn_list);
> > =

> > This relies on mptcp_close() setting msk status before acquiring the
> > msk socket lock, right? If so perhaps we can add a comment there to
> > document the locking schema?
> =

> No, if mptcp_close would set its state after acquiring the lock this
> will still work, either the above check triggers (mptcp_close already
> finished) or mptcp_close is still blocked on the lock.
> =

> The second case is no different from "mptcp_close was not called".

Ah, I see mptcp_close still have to acquire the ssk socket lock! =


Yep, no additional changes required.

Thanks,

Paolo

--===============3362186379342562228==--
