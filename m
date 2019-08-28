Content-Type: multipart/mixed; boundary="===============5041881423787393022=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 00/10] mptcp: refactor token code
Date: Tue, 27 Aug 2019 17:18:35 -0700
Message-ID: <c619761004c77d9a7917dc4304af3897a2bb58f1.camel@linux.intel.com>
In-Reply-To: 20190827180645.GC20113@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1731

--===============5041881423787393022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-27 at 20:06 +0200, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > For the 'mptcp_' prefix, we made sure to add them to all functions
> > exposed outside net/mptcp and Peter got the excellent idea to move all
> > functions only needed in net/mptcp into net/mptcp/protocol.h. We didn't
> > add 'mptcp_' prefix for all these "internal" functions but it certainly
> > makes sense to do that. I guess it is useful when debugging if you see
> > these functions in a call trace or in the list of functions available
> > for tracing.
> > =

> > Do you think we should do the same for "crypto" and "subflow" and "pm"?
> > I guess "pm" and "subflow" are keywords mainly used in "mptcp" but it is
> > maybe not clear for everybody.
> =

> Yes.  Subflow is maybe fine though.
> =

> pm is 'power mangement', so I think it makes sense to prefix mptcp_
> there.

Although I argued against this when creating net/mptcp/protocol.h I respect
the namespace pollution issue more now. Matthieu are you volunteering to do
this or do you want to have a go? Up to you.

Peter.

> > The patches look very good to me, just a few questions and one or two
> > typos, nothing important. I guess other people will also have a look at
> > them :)
> =

> Thanks a lot for the review, I will respin a new version later this
> week.
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============5041881423787393022==--
