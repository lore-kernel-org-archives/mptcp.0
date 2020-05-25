Content-Type: multipart/mixed; boundary="===============5525799684756532293=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: move crypto test to KUNIT
Date: Mon, 25 May 2020 10:17:41 +0200
Message-ID: <dda3ea16cab64e379f4e6fba802817ed867b9e56.camel@redhat.com>
In-Reply-To: 15ed1aff118fea0f63e9068531e1d6940d399d9c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4473

--===============5525799684756532293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-25 at 09:26 +0200, Davide Caratti wrote:
> On Fri, 2020-05-22 at 12:10 +0200, Paolo Abeni wrote:
> > currently MPTCP uses a custom hook to executed unit test at
> > boot time. Let's use the KUNIT framework instead.
> > Additionally move the relevant code to a separate file and
> > export the function needed by the test when self-tests
> > are build as a module.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> >  net/mptcp/Kconfig       | 19 +++++++----
> >  net/mptcp/Makefile      |  3 ++
> >  net/mptcp/crypto.c      | 65 ++-----------------------------------
> >  net/mptcp/crypto_test.c | 71 +++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 90 insertions(+), 68 deletions(-)
> >  create mode 100644 net/mptcp/crypto_test.c
> > =

> =

> [...]
> =

> > diff --git a/net/mptcp/crypto_test.c b/net/mptcp/crypto_test.c
> > new file mode 100644
> > index 000000000000..3a7c40f5e8f8
> > --- /dev/null
> > +++ b/net/mptcp/crypto_test.c
> > @@ -0,0 +1,71 @@
> > +#include <kunit/test.h>
> =

> Nit: I think we need a SPDX line here (or non-conventional users of
> checkpatch might see a warning)

Right you are! I'll fix that in the next iteration!

Thanks,

Paolo

--===============5525799684756532293==--
