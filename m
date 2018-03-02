Content-Type: multipart/mixed; boundary="===============5146758708742877194=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Next steps discussion
Date: Fri, 02 Mar 2018 07:37:40 -0800
Message-ID: <alpine.OSX.2.21.1803020721250.35336@avkulkar-mobl.amr.corp.intel.com>
In-Reply-To: CAKuKrBmH39FMa=0Q4VJJa0AhXeayEmd_SvC5e0dFdeJfft-CMA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 340

--===============5146758708742877194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 2 Mar 2018, Matthieu Baerts wrote:

> Hi Mat, Christoph,
> =

> On Thu, Mar 1, 2018 at 9:05 PM, Mat Martineau <mathew.j.martineau(a)linux=
.intel.com> wrote:
>       On Thu, 1 Mar 2018, Christoph Paasch wrote:
>
>             On 01/03/18 - 18:05:40, Matthieu Baerts wrote:
>                   Hi Christoph,
>
>                   On Wed, Feb 28, 2018 at 11:41 PM, Christoph Paasch <cpa=
asch(a)apple.com>
>                   wrote:
>
>                         Yeah, feedback was disappointingly scarce :/
>
>                         It probably was not what he had completely in min=
d, as he didn't talk about
>                         a TCP-option framework but simply about moving TC=
P-MD5 code out of the
>                         TCP-stack. So, with our proposal we went a bit fu=
rther.
> =

>
>                   Or maybe simply unlucky with who was available at this =
time to have a look
>                   at them :)
> =

>
>                         TLS is a good example. They actually do have a lo=
okup table where the
>                         driver
>                         is calling back into the TCP-stack to get the TLS=
-record information.
>
>                         We had discussed this with people from Mellanox t=
hat proposed the
>                         TLS hardware offloading: https://lists.01.org/
>                         pipermail/mptcp/2017-November/000165.html
> =

> =

>
>                   Thank you for the link!
>
>                   Yes, that would be good! Just a short weekly sync could=
 be useful.
>
>                         Do you have a Webex or other means to set this up?
> =

>
>                   I think I can setup a webex (even if it is less fun to =
use that on a Linux
>                   desktop :) ). We already used talky.io, more Linux frie=
ndly if we need to
>                   share screen and others, maybe not needed.
> =

>
>             talky.io is fine for me as well.
> =

>
>       I haven't used it before, but it looks like a fine option. Thank yo=
u for setting this up.
> =

> =

> The good thing is that we can have a public URL, just in case someone els=
e would help for this upstreaming task:
> https://talky.io/mptcp_upstreaming
> =

> I can also define a shared key if needed.

Yes, since this is an open list it's important to have a public URL.

>
>                   Another issue may be the time. I think you are all in t=
he west coast of the
>                   US :-)
>                   But I am sure I can find time on the evening for a shor=
t meeting!
> =

>
>             Ideally for me, it would be at 9am (for you 6pm). Otherwise, =
I can make 8am
>             as well (5pm for you).
>
>             I don't know what the opinion of the others is on the timing.
> =

>
>       I'm also in the Pacific time zone, as are my coworkers Peter and Os=
sama. Personally, 9am works better.
> =

> =

> 9am (6pm here) is good for me!
> =

> When would you like to have our first meeting? At 6pm, I should not have =
any other meetings.
> Exceptionally I will not be available this Tuesday 6th of March. Just to =
propose a date, what about Wednesday 7th of March?

Wednesday the 7th of March is the one morning next week I have a conflict =

at 9am, but I am available at 9:30. Other mornings at 9 are ok.

>
>                         Looking forward to the netlink PM! :-)
> =

>
>                   I hope I will have time very soon to clean this.
>                   Mat, do you prefer to talk about that directly by comme=
nting the patches on
>                   mptcp-dev ML?
> =

>
>       That's fine with me. I did read the paper (unfortunately I hadn't c=
ome across it before!), and it looks like our approaches
>       have a lot in common - it will be informative to compare the detail=
s.
> =

> =

> Good idea! I will work on the rebase/clean-up and send it to mptcp-dev ML=
. I will add you in cc.
>
>       From earlier in this sub-thread:
>
>             =C2=A0 =C2=A0 =C2=A0This is what I'm working on now. For outg=
oing packets, I have a way
>             =C2=A0 =C2=A0 =C2=A0to optionally allocate sk_buffs with extr=
a control block space. For
>             =C2=A0 =C2=A0 =C2=A0incoming packets, my initial experiment i=
s with preventing packet
>             =C2=A0 =C2=A0 =C2=A0coalesce/collapse so TCP options are stil=
l in the skb headroom. I
>             =C2=A0 =C2=A0 =C2=A0don't consider that a long-term solution,=
 though. Some kind of
>             =C2=A0 =C2=A0 =C2=A0lookup table will probably be needed.
>
>             That looks interesting!
>
>             On some systems with hardware acceleration to bypass the main=
 CPU for established connections, I guess they also
>             have to modify the skb to share info between the main CPU and=
 another component. Do you have any ideas how they
>             are doing that? It is maybe not a real problem for them to in=
crease the size of the skb if most of the traffic
>             goes in the "fast path".
> =

>
>       Are you referring to userspace stacks (like DPDK), or optimizations=
 like GRO? I'm not sure of the specific answer to your
>       question, but from what I see the drivers try to allocate enough sp=
ace in the skbs to accomodate the storage needs through
>       the skb's lifetime.
> =

> =

> Sorry, I was not clear. I don't know if it is common to do that, maybe no=
t because it is not upstream.
> =

> In short, the NIC (or another external HW module) of a router/switch is d=
oing some learning about the flows it needs to forward. Once
> this NIC/module knows the flow, the Linux network stack no longer see the=
 rest of a traffic because it has been "accelerated".
> Here is a longer description when this is done by the NIC:
> https://www.netronome.com/media/documents/WP_Hardware_Acceleration.pdf#WP=
_Hardware_Acceleration.indd%3A.3203%3A27
> =

> But I guess there are some info that the NIC/module cannot learn by itsel=
f when looking at the beginning of the flow like what QoS to
> apply, if a specific flow can be "accelerated" or not, etc. These info ar=
e certainly shared in the skb.
> =

> Now that I am thinking more about this scenario, it will maybe not help f=
or our MPTCP case. I was supposing these info shared via the skb
> could be randomly present. But even if the skb is bigger all the time, I =
guess this is not a problem for them because at the end, the
> Linux network stack will only see a very small part of the traffic, not a=
 big deal to have more cache misses for the slow path only (and
> some other exceptions).
> In other words, their skb is maybe too big as well but that's not a probl=
em.

The only case where I'm allocating larger skbs is on the outgoing path =

where MPTCP code can control allocation, and it happens in a way that's =

transparent to most users of the skb. While it would be great to have the =

space on received skbs I wanted to leave control of incoming skb =

allocation with the drivers.

I'm using an updated version of this:

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/commit/=
?h=3Dsharedcb&id=3D8fffadb6b1ee0dc23e8eed43e40e15f5a6277307

In short, the shinfo part of the skb has additional bytes allocated but =

code that expects a "normal" skb sees only the normal part of the skb. =

It's fine for the payload part of the skb to be any size, since the shinfo =

area is tracked separately.

Thanks,

--
Mat Martineau
Intel OTC

--===============5146758708742877194==--
