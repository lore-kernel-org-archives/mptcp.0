Content-Type: multipart/mixed; boundary="===============3353718759901409258=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Patent-question
Date: Wed, 09 Oct 2019 13:13:02 +0200
Message-ID: <222d913760299f0f8acf6881819b696b5c67e90e.camel@redhat.com>
In-Reply-To: 47A900F1-55E0-489E-8A2C-BC915E03A61C@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2068

--===============3353718759901409258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-10-07 at 09:35 -0700, Christoph Paasch wrote:
> I just got off the phone with the lawyers regarding the patent.
> =

> In order to get something started regarding the claims on the patent,
> I need confirmation on what exactly are the restrictions and/or
> wording required by the Linux community.
> =

> So, in that sense my question becomes: What made DaveM change his
> mind on https://lists.openwall.net/netdev/2014/05/13/96 ?
> =

> Is there anyone who can find this out?

We discussed this topic with our corporate lawyer.

It appears its best that the implementation submitted for mainline
kernel inclusion of the detail that appears to be the subject of the
patent be done with code authored by you as and Apple employee.

It should be apparent from the written records (e.g. mailing list
archives) that you've consulted with others at Apple who are aware of
the relationship between the patent and the implementation.

Failing that, a Signed-off-by from you -- using your @apple.com address
on the patch implementing the relevant V1 bits.

Thanks

--===============3353718759901409258==--
