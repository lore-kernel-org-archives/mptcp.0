Content-Type: multipart/mixed; boundary="===============7268461089241024946=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] selftests: allow compilation on older systems
Date: Tue, 15 Oct 2019 14:31:56 +0200
Message-ID: <5fab2cfe5c72b0188770363c4657c7e1ccbfd560.camel@redhat.com>
In-Reply-To: 20191015102645.GP25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2139

--===============7268461089241024946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 12:26 +0200, Florian Westphal wrote:
> Davide Caratti <dcaratti(a)redhat.com> wrote:
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > @@ -18,7 +18,8 @@
> >  =

> >  #include <netdb.h>
> >  #include <netinet/in.h>
> > -#include <netinet/tcp.h>
> > +
> > +#include <linux/tcp.h>
> > =

> > ^^ this ensures that TCP_ULP is defined, if the 'kernel-headers' package
> > is newer than 4.13.
> =

> ii  linux-libc-dev:amd64            4.9.168-1+deb9u5               amd64
> Linux support headers for userspace development
> =

> I don't care though, I can carry this patch in my private branch.

we can also keep this patch merged until the whole thing is addressed
entirely (because the same argument also applies to the definition of
IPPROTO_MPTCP)-

the patch LGTM and probably it also fixes a build failure on some system,
like Florian's Debian, that has been introduced with "selftests: test
setsockopt(..., TCP_ULP, "mptcp", ...)".

Ok?
-- =

davide

--===============7268461089241024946==--
