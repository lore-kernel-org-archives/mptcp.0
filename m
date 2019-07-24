Content-Type: multipart/mixed; boundary="===============8437841773418641417=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/9] Implement outgoing MP_JOIN
Date: Wed, 24 Jul 2019 16:11:35 -0700
Message-ID: <77f974bc77498c33b9be773762b65a2667a83ac3.camel@linux.intel.com>
In-Reply-To: 09d58df12dd7563eb38b55ef29912b98d2232aec.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1552

--===============8437841773418641417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-18 at 10:27 +0200, Paolo Abeni wrote:
> Hi,
> =

> On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> > This is several accumulated fixes that are required for MP_JOIN
> > (secondary subflows) plus the outgoing code.
> =

> This is great work! Thank you!
> =

> I had a few question on individual patches, but I think the only
> functionally relevant is about locking on 8/9.
> =

> > Both outgoing and incoming MP_JOIN now inter-operate
> > with the multipath.org implementation although there is
> > still a deadlock when incoming is fully established.
> > Since the incoming direction did not work at all before
> > this is an improvement. I have not yet tested running our
> > implmentation against itself.
> =

> I think we can possibly have to revisit part of the current locking
> schema - specifically I think we could/should substiture acquiring the
> msk lock in *_finish_connect() with a new spinlock.

I suspect this may be true unless I resolve above mention deadlock....

> =

> > The final patch in the set is an "interim path manager", this
> > is throw-away code that I include for testing purposes. For an
> > incoming connection it is necessary for the server to advertise
> > a secondary address and for my testing I have been hard-coding the IP
> > address of my secondary interface when I build the kernel.
> > Obviously not the final solution but we need to discuss what
> > approach to use for the self tests. I also think we may not want
> > to publish this patch on our net-next branch.
> =

> I think that patch is actually good/needed - at least 'transiently'. I
> think we can expand it a bit to allow self-testing on different
> hosts/setups without re-compiling the kernel.
> =

> Perhpas it can be split in 2 parts, the first one containing the code
> we intend to keep in the git repo (e.g. pm_create_subflow(),
> pm_remove_addr() and pm_create_subflow() looks goot to me!) and the 2nd
> half contaning only the hacks to enable self-tests - to be reverted
> dropped later.
> =

> WDYT?

Good idea. For v2 of the MP_JOIN patchset I will split it like this, with t=
he
keeper code in this patchset and the throwaway code in a patch that I will
post separately (with sysctl for announce address).

Peter.



> =

> Paolo
> =

> =

> =



--===============8437841773418641417==--
