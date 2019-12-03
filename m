Content-Type: multipart/mixed; boundary="===============1686381669983852062=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Tue, 03 Dec 2019 10:51:16 -0800
Message-ID: <20191203185116.GH84163@MacBook-Pro-64.local>
In-Reply-To: 864b0fbf6edf30973dc7be562f77eccf18efc6d0.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2773

--===============1686381669983852062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/12/19 - 10:09:56, Paolo Abeni wrote:
> On Tue, 2019-12-03 at 08:54 +0100, Matthieu Baerts wrote:
> > Hi Christoph, Paolo,
> > =

> > On 02/12/2019 18:15, Christoph Paasch wrote:
> > > From: Paolo Abeni <pabeni(a)redhat.com>
> > > =

> > > For simplicity's sake use directly sha256 primitives (and pull them
> > > as a required build dep).
> > > Add optional, boot-time self-tests for the hmac function.
> > > =

> > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > =

> > Sorry for this detail but regarding the Signed-off-by, should I write =

> > this instead?
> > =

> >    Co-developed-by: Christoph Paasch <cpaasch(a)apple.com>
> >    Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> >    Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > =

> > Or do we have a "Signed-off-by" here from Christoph because you =

> > (Christoph) are the sender of this patch here? =

> =

> Likely the 2nd option ;)
> =

> > But can we keep it if you =

> > are not the one who will send this patch to netdev? :)
> =

> Not a big deal to me, but strictly speaking I think keeping it for
> netdev submission would be correct only if Christoph will do the netdev
> submission, too.
> =

> Note: before the submission it would be good to review once again the
> tag correctness.

Yes, sorry for the added Signed-off-by. My script applies patches from
e-mails with "-s" and I forgot to remove this one here.


Thanks,
Christoph

--===============1686381669983852062==--
