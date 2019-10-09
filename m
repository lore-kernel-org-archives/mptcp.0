Content-Type: multipart/mixed; boundary="===============8504040088250480675=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Yet another rebase/squash/cleanup proposal
Date: Wed, 09 Oct 2019 09:42:02 +0200
Message-ID: <0dcd0966e91af6124ebccf286c893bc0d27b2c2a.camel@redhat.com>
In-Reply-To: 2c92b0518b6db5ecac582964dcc6454aa31a6715.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2064

--===============8504040088250480675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-08 at 17:28 +0200, Paolo Abeni wrote:
> On Tue, 2019-10-08 at 17:20 +0200, Matthieu Baerts wrote:
> > Hi Florian,
> > =

> > On 08/10/2019 16:48, Florian Westphal wrote:
> > > Hi.
> > > =

> > > Here is yet another rebase proposal, I've pushed it here:
> > > https://git.breakpoint.cc/cgit/fw/mptcp-next.git/log/?h=3Dexport_send=
msg_rebase_13
> > > =

> > > Its also accessible via
> > > git fetch git://git.breakpoint.cc/fw/mptcp-next.git export_sendmsg_re=
base_13
> > > =

> > > In short:
> > > - folds two commits
> > > - fixes the kbuild warnings we got with rfcv2
> > > - gets rid of refcounting in mptcp_subflow_get_ref
> > =

> > Wow, thanks for the work!
> > =

> > Can I re-create the TopGit tree with that? I guess Paolo has already
> > reviewed the changes, right?
> =

> I'm still reviewing it. So far so good. I will add an explicit ack here
> when completed.

The squash LGTM,

refcount changes look good and correct

/P

--===============8504040088250480675==--
