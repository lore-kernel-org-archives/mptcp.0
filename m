Content-Type: multipart/mixed; boundary="===============7791605864359976097=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Wed, 20 Nov 2019 16:49:54 +0100
Message-ID: <8e9cf7581f71e6cb2f6165bec1c5cf0257e8d76e.camel@redhat.com>
In-Reply-To: 43b514ba-69b9-b103-1777-323daf209bc2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2618

--===============7791605864359976097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 16:36 +0100, Matthieu Baerts wrote:
> Hi Florian, Paolo,
> =

> On 20/11/2019 16:25, Paolo Abeni wrote:
> > On Wed, 2019-11-20 at 16:10 +0100, Florian Westphal wrote:
> > > Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > > > > There were doubts as to the repeated invocations of mptcp_send_fr=
ag()
> > > > > (RFC patch 13/14, "sendmsg: don't restart mptcp_sendmsg_frag"), I=
 have
> > > > > dropped it from this iteration -- mptcp_sendmsg_frag needs rework=
 which
> > > > > isn't related to this patch series.
> > > > =

> > > > The series looks good to me, with one minor comment on patch 1.
> > > =

> > > Thanks, I can fix that up.
> > > =

> > > How to proceed?  There are several patches in-flight.  I think it mig=
ht
> > > make sense to apply this series as-is, with no squashing.
> > =

> > I'm personally ok with that.
> > =

> > Can we wait for the series 'Awaiting Upstream' being applied, before
> > going with this one?
> =

> I was replying to Florian to say that I was going to do that :)
> I would like to apply these two series:
> =

>    https://patchwork.ozlabs.org/project/mptcp/list/?state=3D8&delegate=3D=
100661
> =

> Ideally, I would also like to move commits after kselftests introduction =

> but this can wait if needed.

If you could do that, I would appreciate the effort a lot: v1 patches
rebasing could be started just after that.

Note: will cause some conflict on Makefile, due to pm.c being added
after ctrl.c

Cheers,

Paolo

--===============7791605864359976097==--
