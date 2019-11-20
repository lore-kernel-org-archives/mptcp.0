Content-Type: multipart/mixed; boundary="===============2676284153213035344=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Wed, 20 Nov 2019 16:25:35 +0100
Message-ID: <c420dc6ea000ee8fa951ab89689b63785a4df0f7.camel@redhat.com>
In-Reply-To: 20191120151016.GC20235@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2615

--===============2676284153213035344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 16:10 +0100, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > > There were doubts as to the repeated invocations of mptcp_send_frag()
> > > (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I have
> > > dropped it from this iteration -- mptcp_sendmsg_frag needs rework whi=
ch
> > > isn't related to this patch series.
> > =

> > The series looks good to me, with one minor comment on patch 1.
> =

> Thanks, I can fix that up.
> =

> How to proceed?  There are several patches in-flight.  I think it might
> make sense to apply this series as-is, with no squashing.

I'm personally ok with that. =


Can we wait for the series 'Awaiting Upstream' being applied, before
going with this one?

Than v1 support can be rebased on top of the resulting tree (still to
be applied just before self-tests).

> We can then do another squash-marathon later on before next upstream
> submission.

Yep, we will likely need some kind of "code-freeze", and squash/bugfix
only before the submission.

Cheers,

Paolo

--===============2676284153213035344==--
