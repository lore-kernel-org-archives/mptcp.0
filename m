Content-Type: multipart/mixed; boundary="===============7684098742068194171=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Fri, 02 Mar 2018 09:57:07 -0800
Message-ID: <20180302175707.GZ2038@MacBook-Pro-4.local>
In-Reply-To: alpine.OSX.2.21.1803020721250.35336@avkulkar-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 341

--===============7684098742068194171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/03/18 - 07:37:40, Mat Martineau wrote:
> =

> On Fri, 2 Mar 2018, Matthieu Baerts wrote:
> =

> > Hi Mat, Christoph,
> > =

> > On Thu, Mar 1, 2018 at 9:05 PM, Mat Martineau <mathew.j.martineau(a)lin=
ux.intel.com> wrote:
> >       On Thu, 1 Mar 2018, Christoph Paasch wrote:
> > =

> >             On 01/03/18 - 18:05:40, Matthieu Baerts wrote:
> >                   Hi Christoph,
> > =

> >                   On Wed, Feb 28, 2018 at 11:41 PM, Christoph Paasch <c=
paasch(a)apple.com>
> >                   wrote:
> > =

> >                         Yeah, feedback was disappointingly scarce :/
> > =

> >                         It probably was not what he had completely in m=
ind, as he didn't talk about
> >                         a TCP-option framework but simply about moving =
TCP-MD5 code out of the
> >                         TCP-stack. So, with our proposal we went a bit =
further.
> > =

> > =

> >                   Or maybe simply unlucky with who was available at thi=
s time to have a look
> >                   at them :)
> > =

> > =

> >                         TLS is a good example. They actually do have a =
lookup table where the
> >                         driver
> >                         is calling back into the TCP-stack to get the T=
LS-record information.
> > =

> >                         We had discussed this with people from Mellanox=
 that proposed the
> >                         TLS hardware offloading: https://lists.01.org/
> >                         pipermail/mptcp/2017-November/000165.html
> > =

> > =

> > =

> >                   Thank you for the link!
> > =

> >                   Yes, that would be good! Just a short weekly sync cou=
ld be useful.
> > =

> >                         Do you have a Webex or other means to set this =
up?
> > =

> > =

> >                   I think I can setup a webex (even if it is less fun t=
o use that on a Linux
> >                   desktop :) ). We already used talky.io, more Linux fr=
iendly if we need to
> >                   share screen and others, maybe not needed.
> > =

> > =

> >             talky.io is fine for me as well.
> > =

> > =

> >       I haven't used it before, but it looks like a fine option. Thank =
you for setting this up.
> > =

> > =

> > The good thing is that we can have a public URL, just in case someone e=
lse would help for this upstreaming task:
> > https://talky.io/mptcp_upstreaming
> > =

> > I can also define a shared key if needed.
> =

> Yes, since this is an open list it's important to have a public URL.
> =

> > =

> >                   Another issue may be the time. I think you are all in=
 the west coast of the
> >                   US :-)
> >                   But I am sure I can find time on the evening for a sh=
ort meeting!
> > =

> > =

> >             Ideally for me, it would be at 9am (for you 6pm). Otherwise=
, I can make 8am
> >             as well (5pm for you).
> > =

> >             I don't know what the opinion of the others is on the timin=
g.
> > =

> > =

> >       I'm also in the Pacific time zone, as are my coworkers Peter and =
Ossama. Personally, 9am works better.
> > =

> > =

> > 9am (6pm here) is good for me!
> > =

> > When would you like to have our first meeting? At 6pm, I should not hav=
e any other meetings.
> > Exceptionally I will not be available this Tuesday 6th of March. Just t=
o propose a date, what about Wednesday 7th of March?
> =

> Wednesday the 7th of March is the one morning next week I have a conflict=
 at
> 9am, but I am available at 9:30. Other mornings at 9 are ok.

On my side, any day at 9am next week is fine.


Cheers,
Christoph

> =

> > =

> >                         Looking forward to the netlink PM! :-)
> > =

> > =

> >                   I hope I will have time very soon to clean this.
> >                   Mat, do you prefer to talk about that directly by com=
menting the patches on
> >                   mptcp-dev ML?
> > =

> > =

> >       That's fine with me. I did read the paper (unfortunately I hadn't=
 come across it before!), and it looks like our approaches
> >       have a lot in common - it will be informative to compare the deta=
ils.
> > =

> > =

> > Good idea! I will work on the rebase/clean-up and send it to mptcp-dev =
ML. I will add you in cc.
> > =

> >       From earlier in this sub-thread:
> > =

> >             =C2=A0 =C2=A0 =C2=A0This is what I'm working on now. For ou=
tgoing packets, I have a way
> >             =C2=A0 =C2=A0 =C2=A0to optionally allocate sk_buffs with ex=
tra control block space. For
> >             =C2=A0 =C2=A0 =C2=A0incoming packets, my initial experiment=
 is with preventing packet
> >             =C2=A0 =C2=A0 =C2=A0coalesce/collapse so TCP options are st=
ill in the skb headroom. I
> >             =C2=A0 =C2=A0 =C2=A0don't consider that a long-term solutio=
n, though. Some kind of
> >             =C2=A0 =C2=A0 =C2=A0lookup table will probably be needed.
> > =

> >             That looks interesting!
> > =

> >             On some systems with hardware acceleration to bypass the ma=
in CPU for established connections, I guess they also
> >             have to modify the skb to share info between the main CPU a=
nd another component. Do you have any ideas how they
> >             are doing that? It is maybe not a real problem for them to =
increase the size of the skb if most of the traffic
> >             goes in the "fast path".
> > =

> > =

> >       Are you referring to userspace stacks (like DPDK), or optimizatio=
ns like GRO? I'm not sure of the specific answer to your
> >       question, but from what I see the drivers try to allocate enough =
space in the skbs to accomodate the storage needs through
> >       the skb's lifetime.
> > =

> > =

> > Sorry, I was not clear. I don't know if it is common to do that, maybe =
not because it is not upstream.
> > =

> > In short, the NIC (or another external HW module) of a router/switch is=
 doing some learning about the flows it needs to forward. Once
> > this NIC/module knows the flow, the Linux network stack no longer see t=
he rest of a traffic because it has been "accelerated".
> > Here is a longer description when this is done by the NIC:
> > https://www.netronome.com/media/documents/WP_Hardware_Acceleration.pdf#=
WP_Hardware_Acceleration.indd%3A.3203%3A27
> > =

> > But I guess there are some info that the NIC/module cannot learn by its=
elf when looking at the beginning of the flow like what QoS to
> > apply, if a specific flow can be "accelerated" or not, etc. These info =
are certainly shared in the skb.
> > =

> > Now that I am thinking more about this scenario, it will maybe not help=
 for our MPTCP case. I was supposing these info shared via the skb
> > could be randomly present. But even if the skb is bigger all the time, =
I guess this is not a problem for them because at the end, the
> > Linux network stack will only see a very small part of the traffic, not=
 a big deal to have more cache misses for the slow path only (and
> > some other exceptions).
> > In other words, their skb is maybe too big as well but that's not a pro=
blem.
> =

> The only case where I'm allocating larger skbs is on the outgoing path wh=
ere
> MPTCP code can control allocation, and it happens in a way that's
> transparent to most users of the skb. While it would be great to have the
> space on received skbs I wanted to leave control of incoming skb allocati=
on
> with the drivers.
> =

> I'm using an updated version of this:
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/commi=
t/?h=3Dsharedcb&id=3D8fffadb6b1ee0dc23e8eed43e40e15f5a6277307
> =

> In short, the shinfo part of the skb has additional bytes allocated but c=
ode
> that expects a "normal" skb sees only the normal part of the skb. It's fi=
ne
> for the payload part of the skb to be any size, since the shinfo area is
> tracked separately.
> =

> Thanks,
> =

> --
> Mat Martineau
> Intel OTC


--===============7684098742068194171==--
