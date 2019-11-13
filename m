Content-Type: multipart/mixed; boundary="===============4394456071408147884=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Wed, 13 Nov 2019 19:32:46 +0100
Message-ID: <4583b5c2b716c15d2ebc9398537f7899760be121.camel@redhat.com>
In-Reply-To: 7ef4b901-57b7-4d0b-c599-ada67ea7a4f9@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2517

--===============4394456071408147884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-13 at 19:13 +0100, Matthieu Baerts wrote:
> Hi Paolo, Christoph,
> =

> On 13/11/2019 18:37, Paolo Abeni wrote:
> > On Wed, 2019-11-13 at 17:35 +0100, Matthieu Baerts wrote:
> > > Should we already add the MIB counter? And/or add a TODO in the code?
> > =

> > I think adding more MIB counter is a later tasks.
> =

> Should we add a comment in the code is it useless when there are =

> thousands of lines around? :)

At this point, I would like to avoid adding todos inside comments for
the first 2 chunks patches - to avoid additional complex rebases
squashing even later.

Cheers,

Paolo

--===============4394456071408147884==--
