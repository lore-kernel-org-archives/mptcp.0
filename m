Content-Type: multipart/mixed; boundary="===============2533862599532996426=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/3] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Tue, 03 Dec 2019 12:06:09 +0100
Message-ID: <d6031f0abaebb276f6e6dbc28b3e997844a469d9.camel@redhat.com>
In-Reply-To: 5a3e7828-b09c-90cf-4c83-484ff1447e1b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2766

--===============2533862599532996426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-03 at 11:45 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 03/12/2019 10:09, Paolo Abeni wrote:
> > On Tue, 2019-12-03 at 08:54 +0100, Matthieu Baerts wrote:
> > > Hi Christoph, Paolo,
> > > =

> > > On 02/12/2019 18:15, Christoph Paasch wrote:
> > > > From: Paolo Abeni <pabeni(a)redhat.com>
> > > > =

> > > > For simplicity's sake use directly sha256 primitives (and pull them
> > > > as a required build dep).
> > > > Add optional, boot-time self-tests for the hmac function.
> > > > =

> > > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > > =

> > > Sorry for this detail but regarding the Signed-off-by, should I write
> > > this instead?
> > > =

> > >     Co-developed-by: Christoph Paasch <cpaasch(a)apple.com>
> > >     Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > >     Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > > =

> > > Or do we have a "Signed-off-by" here from Christoph because you
> > > (Christoph) are the sender of this patch here?
> > =

> > Likely the 2nd option ;)
> > =

> > > But can we keep it if you
> > > are not the one who will send this patch to netdev? :)
> > =

> > Not a big deal to me, but strictly speaking I think keeping it for
> > netdev submission would be correct only if Christoph will do the netdev
> > submission, too.
> =

> So for you, when we apply this, better to only keep one your signed-off =

> and add the signed-off of the submitter (probably Mat)?

Exactly!

> > Note: before the submission it would be good to review once again the
> > tag correctness.
> =

> Good idea!
> I think we should also review the whole commit messages in general. =

> Maybe some are no longer up to date after all the squashes we did :)

+1!

Cheers,

Paolo

--===============2533862599532996426==--
