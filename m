Content-Type: multipart/mixed; boundary="===============5599805552127861953=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use mptcp worker for path
 management
Date: Mon, 22 Jun 2020 15:03:10 +0200
Message-ID: <20200622130310.GQ26990@breakpoint.cc>
In-Reply-To: 3274892c9713c52432c0e06d1b66a0a5028c9ec1.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4769

--===============5599805552127861953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2020-06-22 at 13:18 +0200, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > I'm wondering if we should keep using an MPTCP-specific workqueue.
> > > Server side, we don't expect the work to trigger very often, but shou=
ld
> > > that ever happen, top will tell easily.
> > =

> > You mean switch msk->work from system_wq to a custom workqueue?
> =

> yep, e.g. reusing and renaming 'pm_wq'. When the PM works a lot (in
> "ndiffports" mode as in issues/33), the pm_wq is visible in top - at
> least in dbg build, I never tested with regular kconfig - and I like
> being able to identify it easily. WDYT?

Can you do this?

I am not at all sure how you would like this to look like 8-(

(Merge parts of protocol.c into pm.c?)
--===============5599805552127861953==--
