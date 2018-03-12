Content-Type: multipart/mixed; boundary="===============3072033237491803839=="
MIME-Version: 1.0
From: Stephen Brennan <stephen at brennan.io>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Mon, 12 Mar 2018 14:10:16 -0700
Message-ID: <20180312211016.GB9725@greed.cult>
In-Reply-To: CAPyD+=AKor9ZD9W=OQxir=8LT-boHtduNSCi=4JPRUDNK9+vJQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 370

--===============3072033237491803839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ossama,

One other thought that came up about this is that the performance of each
subflow might be a consideration in path management. I don't know what
existing facilities exist for userspace to see statistics about subflow
performance (estimated RTT, loss events, etc). If these facilities don't
exist, they may be a worthy addition to this API.

A related question is, will this API address data scheduling at all?

Finally, a couple comments inline :)

On Mon, Mar 12, 2018 at 10:27:29AM -0700, Othman, Ossama wrote:
> Hi Stephen,
> =

> On Thu, Mar 8, 2018 at 3:46 PM, Stephen Brennan <stephen(a)brennan.io> wr=
ote:
> > I'm very interested in the idea of a MPTCP path manager Netlink API, si=
nce
> > I actually posted a patch on mptcp-dev recently containing a path manag=
er
> > which did send and receive some commands over a Netlink API. My API was=
 not
> > nearly as complete as this one, but it's nice to see that path manageme=
nt
> > policy could move further into user-space. That certainly makes the sor=
t of
> > research I was working on a lot easier.
> =

> Thanks for pointing this out!  I'm interested in seeing your approach,
> so I'll take a look, too.

I doubt my approach will be of much use -- it is highly specialized to a
particular use case.

I wish I had implemented some sort of connection identifier as your API
describes - it would have made some of my operations much better.

> > Is there any event for "new network interface added"? Or would the
> > user-space daemon need to subscribe to that information elsewhere?
> =

> The daemon subscribes to rtnetlink events to determine when network
> interfaces have been added or removed, and propagates those events to
> the path manager plugins.  I'm not sure if this is the best approach
> since we could also propagate such network interface related events
> from the kernel MPTCP implementation, similar to how the
> multipath-tcp.org implementation propagates such events to its
> in-kernel path managers.  Ultimately I opted to listen for network
> interface changes in the user space to avoid adding more code in the
> kernel.

This makes perfect sense; don't reinvent the wheel!

Thanks for being open to suggestions. I look forward to what this
implementation will look like!

Stephen


--===============3072033237491803839==--
