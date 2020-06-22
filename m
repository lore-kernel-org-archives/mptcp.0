Content-Type: multipart/mixed; boundary="===============3592314663638635020=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use mptcp worker for path
 management
Date: Mon, 22 Jun 2020 16:51:07 +0200
Message-ID: <f32389b8a22047ec4c5366f8b8e76209512726b0.camel@redhat.com>
In-Reply-To: 20200622130310.GQ26990@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4771

--===============3592314663638635020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 15:03 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Mon, 2020-06-22 at 13:18 +0200, Florian Westphal wrote:
> > > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > > I'm wondering if we should keep using an MPTCP-specific workqueue.
> > > > Server side, we don't expect the work to trigger very often, but sh=
ould
> > > > that ever happen, top will tell easily.
> > > =

> > > You mean switch msk->work from system_wq to a custom workqueue?
> > =

> > yep, e.g. reusing and renaming 'pm_wq'. When the PM works a lot (in
> > "ndiffports" mode as in issues/33), the pm_wq is visible in top - at
> > least in dbg build, I never tested with regular kconfig - and I like
> > being able to identify it easily. WDYT?
> =

> Can you do this?

I'll try to run the perf tests on non-debug build, but I see your
point. Let's keep the patch simple - as is now. We can look for a
workqueue only if mptcp workqueue usage proves to be relevant in non
debug build.

Thanks,

Paolo

--===============3592314663638635020==--
