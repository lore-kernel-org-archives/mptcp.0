Content-Type: multipart/mixed; boundary="===============5799070949894236494=="
MIME-Version: 1.0
From: Stephen Brennan <stephen at brennan.io>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC] MPTCP Path Management Generic Netlink API
Date: Mon, 12 Mar 2018 13:55:07 -0700
Message-ID: <20180312205507.GA9725@greed.cult>
In-Reply-To: 20180312032743.GK74937@MacBook-Pro-4.local
X-Status: 
X-Keywords:                  
X-UID: 368

--===============5799070949894236494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph,

Thanks for the info, I think I understand the plan a lot better now!

On Sun, Mar 11, 2018 at 08:27:43PM -0700, Christoph Paasch wrote:
> Hello Stephen,
> =

> On 08/03/18 - 15:46:29, Stephen Brennan wrote:
> > Hi Ossama,
> > =

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

> I saw your patches and will do a review soon.
> =

> > I do have some inline comments drawn from my experience, but first one
> > question. Is the implementation strategy for the Netlink PM to simply be
> > another path manager (selectable among the other path managers), or wou=
ld
> > it replace the other path managers in some way?
> =

> Long-term we definitely want to go away from having the kernel-moduled
> path-managers. They were very useful when we had to write research papers,
> but for upstreaming it's not a good design :)

How do you plan to handle schedulers? Given the good experimental results
of the min-RTT-first scheduler, will that be the only option? Or will it
remain as a kernel module due to the time-sensitive nature of scheduling?

I ask because I've found scheduling to be sometimes related to path
management. For instance, the system I worked on in my thesis essentially
routes subflows through proxies. A piece of future work we've been looking
into has been to "explore" new proxies without risk of disrupting the
connection due to packet loss. We would do this by only transmitting
redundant data segments along the subflow being "explored".

Stephen


--===============5799070949894236494==--
