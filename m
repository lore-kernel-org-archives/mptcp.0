Content-Type: multipart/mixed; boundary="===============8267088251080373180=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH iproute2-next 2/2] ss: mptcp: add msk diag
 interface support
Date: Wed, 01 Jul 2020 12:30:29 +0200
Message-ID: <9799ca7bca8d6037ff9258d3ac09f09b75dcb343.camel@redhat.com>
In-Reply-To: alpine.OSX.2.23.453.2006301625150.31270@lferrari-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4879

--===============8267088251080373180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-30 at 16:27 -0700, Mat Martineau wrote:
> On Thu, 25 Jun 2020, Paolo Abeni wrote:
> =

> > This implement support for MPTCP sockets type, comprising
> > extended socket info. Note that we need to add an extended
> > attribute carrying the actual protocol number to the diag
> > request.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > misc/ss.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++-----
> > 1 file changed, 105 insertions(+), 10 deletions(-)
> > =

> > diff --git a/misc/ss.c b/misc/ss.c
> > index f3d01812..3ccd1586 100644
> > --- a/misc/ss.c
> > +++ b/misc/ss.c
> > @@ -63,6 +63,10 @@
> > #define AF_VSOCK PF_VSOCK
> > #endif
> > =

> > +#ifndef IPPROTO_MPTCP
> > +#define IPPROTO_MPTCP 262
> > +#endif
> > +
> =

> With IPPROTO_MPTCP defined in include/uapi/linux/in.h (in this repo) does =

> it need to be redefined here?

The build fails without the above. =


I think linux/in.h is pulled indirectly from others include headers,
using the system-wide include dir. Possibly with some specific #include
order and/or changing the gcc command line we can fix the build issue
without the specific #ifdef above, but it looked simpler/more robust
this way ;)

Thanks,

Paolo

--===============8267088251080373180==--
