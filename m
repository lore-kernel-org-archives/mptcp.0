Content-Type: multipart/mixed; boundary="===============8548114075905071917=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: add the address ID
 assignment bitmap
Date: Thu, 03 Dec 2020 15:44:14 +0100
Message-ID: <54eb53dd24315546f527dee512723d05dbe730d3.camel@redhat.com>
In-Reply-To: 06b47a4071c049ad0595f1bcfa970cec83f4fb6f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7023

--===============8548114075905071917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-03 at 15:41 +0100, Paolo Abeni wrote:
> On Tue, 2020-12-01 at 19:58 +0800, Geliang Tang wrote:
> > Currently the address ID set by the netlink PM from user-space is
> > overridden by the kernel. This patch added the address ID assignment
> > bitmap to allow user-space to set the address ID.
> > =

> > Use a per netns bitmask id_bitmap (256 bits) to keep track of in-use ID=
s.
> > And use next_id to keep track of the highest ID currently in use. If the
> > user-space provides an ID at endpoint creation time, try to use it. If
> > already in use, endpoint creation fails. Otherwise pick the first ID
> > available after the highest currently in use, with wrap-around.
> > =

> > Test:
> > =

> >  # pm_nl_ctl add 10.0.0.1
> >  # pm_nl_ctl add 10.0.0.2
> >  # pm_nl_ctl add 10.0.0.3 id 100
> >  # pm_nl_ctl add 10.0.0.4
> >  # pm_nl_ctl add 10.0.0.5 id 254
> >  # pm_nl_ctl add 10.0.0.6
> >  # pm_nl_ctl add 10.0.0.7
> >  # pm_nl_ctl add 10.0.0.8
> >  # pm_nl_ctl dump
> >  id 1 flags  10.0.0.1
> >  id 2 flags  10.0.0.2
> >  id 3 flags  10.0.0.7
> >  id 4 flags  10.0.0.8
> >  id 100 flags  10.0.0.3
> >  id 101 flags  10.0.0.4
> >  id 254 flags  10.0.0.5
> >  id 255 flags  10.0.0.6

whoops, I almost forgot. It would be gread adding explicit self-tests
checking:
- the usage of the id provided by the user
- the wrap-around =


Thanks!

Paolo

--===============8548114075905071917==--
