Content-Type: multipart/mixed; boundary="===============3758697939802005741=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] mptcp: Implement interim path manager
Date: Tue, 17 Sep 2019 10:57:09 -0700
Message-ID: <69fd09f53044f7be76c50eafe2d18a82bc2f6224.camel@linux.intel.com>
In-Reply-To: 4ec74729b6d259927f2b72635b54c9740dd74197.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1865

--===============3758697939802005741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-17 at 11:37 +0200, Paolo Abeni wrote:
> Hi,
> =

> On Fri, 2019-09-06 at 18:30 -0700, Peter Krystad wrote:
> > Two features: 1) After an incoming connection is fully established
> > announce a second local address and 2) When an outgoing connection
> > is fully established, and an ADD_ADDR option has been received,
> > initiate a secondary subflow to that address.
> > =

> > The second local address may be configured through the
> > net.mptcp.pm.announce_addr sysctl variable. If configured
> > then for listeners this address will be announced with the
> > ADD_ADDR option, and for clients the local socket will be bound
> > to this address (or INADDR_ANY if not specified).
> > =

> > Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> =

> Thanks for completing this!
> =

> I fear there are possibly some other races pending there - if I read
> the code correctly, the pm data structures are protected by the ssk
> socket lock but have per msk scope.
> =

Yes, I think you're right, but the purpose here is to just get something we
can test multiple subflows with, thus the name 'interim'.

> As a very minor thing, I personally would prefer more a name like
> 'small', 'simple' or 'basic' instead of 'interim'.

Well, now is the time to change it so I will re-submit with new name and
address your comment on patch 1.

Peter.

> =

> Anyhow I think this would work well to exercise the MP_JOIN code path
> and we can improve on top if needed.
> =

> So overall I'm ok with merging this as-is.
> =

> Cheers,
> =

> Paolo
> =



--===============3758697939802005741==--
