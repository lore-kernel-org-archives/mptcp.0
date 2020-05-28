Content-Type: multipart/mixed; boundary="===============2821673124666769513=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/4] mptcp: token container refactor
Date: Thu, 28 May 2020 11:29:57 +0200
Message-ID: <5c86b8638331a7b99849b4cbd9ad4aaf828c69c5.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2005271555540.6568@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 4520

--===============2821673124666769513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 16:05 -0700, Mat Martineau wrote:
> Hi Paolo,
> =

> On Mon, 25 May 2020, Paolo Abeni wrote:
> =

> > This series supersede the RTC patch for token refactor. The relevant pa=
tch
> > is unchanged, but this additional bring in some related minor cleanup
> > (patch 1/4) and KUNIT (!!!) self-tests (4/4). To make things cleaner it=
 also
> > moves the existing in-kernel tests (crypto) to KUNIT.
> > =

> > The most relevant changes from v1 are in patch 2/4.
> > =

> > This addresses most of the issues raised by Christoph, Davide and Mat, =
with the
> > notable exception of shirinking the hash table bucket size - I'm unable=
 to do
> > that with the current fixes for the list curruption noted by Christoph.
> > =

> > I hope the trade-off beween the self-contained fix and the avoided memo=
ry
> > optimization is acceptable.
> > =

> > Paolo Abeni (4):
> >  mptcp: add __init annotation on setup functions
> >  mptcp: refactor token container.
> >  mptcp: move crypto test to KUNIT
> >  mptcp: introduce token KUNIT self-tests
> > =

> =

> The series looks good to me. Is this something we should let bake in =

> mptcp-next for a little bit or do you want to submit for net-next while =

> it's still open?
> =

> I'm curious to see if there's any netdv pushback on the boot-time memory =

> allocation.

I hope should not be problematic, but only the submission could prove
it ;)

My idea would be staging this thing a bit in the export branch to let
syzkaller and internal usage find the most gross mistakes. I'm open to
other options ;)

Thanks!

Paolo=20

--===============2821673124666769513==--
