Content-Type: multipart/mixed; boundary="===============2659162738156455235=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use mptcp worker for path
 management
Date: Mon, 22 Jun 2020 13:30:16 +0200
Message-ID: <3274892c9713c52432c0e06d1b66a0a5028c9ec1.camel@redhat.com>
In-Reply-To: 20200622111817.GP26990@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4765

--===============2659162738156455235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 13:18 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > I'm wondering if we should keep using an MPTCP-specific workqueue.
> > Server side, we don't expect the work to trigger very often, but should
> > that ever happen, top will tell easily.
> =

> You mean switch msk->work from system_wq to a custom workqueue?

yep, e.g. reusing and renaming 'pm_wq'. When the PM works a lot (in
"ndiffports" mode as in issues/33), the pm_wq is visible in top - at
least in dbg build, I never tested with regular kconfig - and I like
being able to identify it easily. WDYT?

Thanks!

Paolo

--===============2659162738156455235==--
