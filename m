Content-Type: multipart/mixed; boundary="===============6323990222730195523=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Conference talk ideas, round 2
Date: Mon, 14 May 2018 15:59:57 -0700
Message-ID: <alpine.OSX.2.21.1805141442370.64899@mjmartin-mac01.sea.intel.com>
In-Reply-To: CAKuKrBmjLFC2LM1i9yWzSMXFi-Nj_cD1F4VKAnNc-9w+BtuSpQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 626

--===============6323990222730195523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Matthieu,

On Mon, 14 May 2018, Matthieu Baerts wrote:

> Hi Mat,
> =

> On Mon, May 14, 2018 at 6:02 AM, Mat Martineau <mathew.j.martineau(a)linu=
x.intel.com> wrote:
>
>       Hello -
>
>       We had a meeting last week to discuss reshaping our netdev conferen=
ce MPTCP talk proposal based on feedback from the committee.
>       The plan is to re-focus on upstreaming concerns, challenges, and pr=
ogress.
>
>       I worked on outlining some topics that might fit with the talk. I d=
on't think this is exhaustive, and I'm also not saying
>       everything here is required to be in the talk. I'm looking forward =
to your comments and additional ideas.
> =

> =

> Thank you for the list!
> =

> Should we focus our talk on: Why is adding intrusive protocols like MPTCP=
 to the upstream kernel so complicated?
>

I think the complexity of MPTCP is unique in that additional protocols =

don't usually overlap with an existing protocol - especially a protocol as =

heavily used and optimized as TCP. I'm not sure how many MPTCP-like =

protocols are out there, but we definitely can focus on the complexity of =

MPTCP upstreaming. The most similar thing I can think of is the Bluetooth =

L2CAP-ERTM code in the kernel, but the layering there was cleaner (I wrote =

that ERTM kernel code and upstreamed it after maintaining it separately =

for a while - sound familiar?).

In terms of topic priorities, I think the last two top-level bullet points =

(large change logistics and "show us the code") are less important than =

the earlier points.


The conference committee announced acceptance of a QUIC talk, and it made =

me think about how QUIC doesn't have these kernel issues since it builds =

on UDP. In contrast, the design of MPTCP pushes complexity in to the =

kernel in order to look like TCP on the wire and to fit with legacy =

applications.

> If you want and if nobody has already started it, I can have a look to pr=
epare a first draft for a description for this talk.

It would be very helpful if you can prepare that draft. Thank you!


Mat


> =

> Best regards,
> Matthieu
>
>       * Why is adding MPTCP to the upstream kernel complicated?
>
>       =C2=A0 =C2=A0 * Differences in requirements and features from exist=
ing implementation
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Every TCP socket affected vs. staying=
 out of the way for normal TCP
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Multipath protocol development and re=
search vs giving TCP users/maintainers weight
>
>       =C2=A0 =C2=A0 * Protocol challenges
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Coupled receive windows across TCP su=
bflows
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Behavior change for duplicate acks
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Per-packet metadata (tx path) and opt=
ion writing
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * TCP option parsing - packets are curr=
ently dropped after options are parsed
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Collapse/coalesce of skbs after recei=
ve - per-packet headers lost in TCP layer
>
>       =C2=A0 =C2=A0 * Must do all this without adversely affecting TCP or=
 networking structs (like sk_buff)
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * TCP performance not reduced
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Memory requirements for TCP not incre=
ased
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Maintainability not made harder
>
>       =C2=A0 =C2=A0 * Compare to KCM, which adds metadata to each stream,=
 didn't require TCP changes
>
>       * What fits well in the networking subsystem
>
>       =C2=A0 =C2=A0 * Some connection code (callbacks exist)
>
>       =C2=A0 =C2=A0 * Creating a new socket type for MPTCP
>
>       =C2=A0 =C2=A0 * New ULP capability
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * No rules yet for multiple users, beca=
use TLS is the only user
>
>       =C2=A0 =C2=A0 * In-kernel sockets
>
>       =C2=A0 =C2=A0 * do_tcp_sendpages() to send data buffered at the con=
nection level
>
>       =C2=A0 =C2=A0 * tcp_read_sock() to get incoming skbs
>
>       * What's a challenge in the networking subsystem
>
>       =C2=A0 =C2=A0 * Indirect calls are now more expensive
>
>       =C2=A0 =C2=A0 * MPTCP builds on TCP in a unique way
>
>       * What we have tried
>
>       =C2=A0 =C2=A0 * Identify where other features could use TCP extensi=
on capabilities and merge before MPTCP
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Options framework used by TCP-MD5 and=
 SMC
>
>       =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Didn't work out - expensive indirect =
calls and no MPTCP frame of reference for the maintainer
>
>       =C2=A0 =C2=A0 * Sharing code demonstrating architectural approaches=
 that use current upstream netdev functionality
>
>       =C2=A0 =C2=A0 * Moving components to userspace
>
>       =C2=A0 =C2=A0 * Forking and reducing functionality of existing MPTC=
P code base
>
>       * Large change logistics
>
>       =C2=A0 =C2=A0 * Reshaping code in to a reviewable patch set or patc=
h sets. Implement functionality in stages?
>
>       * Fundamental challenge of "show us the code" - must decide what se=
ems upstreamable, implement it, share, and iterate.
>

--
Mat Martineau
Intel OTC

--===============6323990222730195523==--
