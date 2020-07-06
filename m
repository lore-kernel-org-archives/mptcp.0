Content-Type: multipart/mixed; boundary="===============6400913270472057678=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/4] mptcp: msk diag support
Date: Mon, 06 Jul 2020 11:38:27 +0200
Message-ID: <be82f2e7e7109a0e9f32180124ead2b080e052f3.camel@redhat.com>
In-Reply-To: 18fabf01-df03-922e-e6c7-3331c5acc356@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4924

--===============6400913270472057678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-07-03 at 21:11 +0200, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> =

> On 03/07/2020 00:06, Mat Martineau wrote:
> > On Thu, 2 Jul 2020, Paolo Abeni wrote:
> > =

> > > This introduces basic mptcp sockets diag support.
> > > As IPPROTO_MPTCP excedes 8 bits, we need some changes at the inet_dia=
g =

> > > level:
> > > a new attribute is introduced to allow user-space providing u32 proto=
col
> > > values.
> > > =

> > > Patch 2 introduces new token APIs to allow traversing the existing =

> > > msks, while
> > > patch 3 bring in the actual diag implementation.
> > > =

> > > Patch 4 includes some basic functional tests
> > > =

> > > v2 -> v3:
> > > - changed token iterator APIs: use RCU && get_sock
> > > - tests cleanup
> > =

> > Thanks for the v3 fixes Paolo, my concerns in v2 are addressed. There i=
s =

> > the proto range checking issue Christoph noted in patch 1 to fix before =

> > merging.
> =

> Thank you for the patches and the reviews!
> =

> These patches have been added at the end.
> =

> Tests are re-running with INET_DIAG enabled. Export is going to be done =

> soon after.

Note that diag self-tests requiere a version of iproute2 including the
pending 2 patches, otherwise tests will be skipped - so no failure but
also no tests.

Thanks,

Paolo

--===============6400913270472057678==--
