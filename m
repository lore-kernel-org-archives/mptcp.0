Content-Type: multipart/mixed; boundary="===============7807995159120140902=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming strategy and design
Date: Mon, 21 Aug 2017 17:34:01 -0700
Message-ID: <alpine.OSX.2.21.1708211532470.4642@bgstaab-mobl2.amr.corp.intel.com>
In-Reply-To: 20170819235530.GB81310@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 80

--===============7807995159120140902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Lorenzo and Christoph,

On Sat, 19 Aug 2017, Christoph Paasch wrote:

> Hello Lorenzo,
>
>
> thanks for chiming in. Please see inline:
>
> On 19/08/17 - 13:43:38, Lorenzo Colitti wrote:
>> Sorry I'm late to this thread. I've been thinking about this for a while,
>> and wanted to share some of those thoughts in the hope that they are use=
ful.

Glad that you're here, Lorenzo!

>> Reading through the 4.4 patch, many of the points made by Mat make sense=
 to
>> me. Especially, off-by-default is important (upstream cares deeply about
>> backwards compatibility). In fact, personally I don't see a lot of
>> advantage to enabling MPTCP on unmodified applications that directly call
>> the socket API. But perhaps there are use cases there that I don't see.
>
> I agree that we should have off-by-default and opt-in through a
> socket-option (or similar mechanism).
>
>
> Wrt., to using MPTCP on unmodified applications, Daniel Borkmann told me
> once that a big use-case for MPTCP would be data-center applications where
> one cannot change the application (e.g., because it's closed-source).
> If I am not mistaken, at the time he was working on SCTP and they were
> trying to do some magic with LD_PRELOAD to make these apps seamlessly use
> SCTP.
>
> But I would say bad luck for these apps then ;-)

I've also heard anecdotes of data center use cases for unmodified =

applications, but it seems like that won't be the most common usage. =

Applications (user or data-center) can make better use of MPTCP if they're =

written for it, but regular TCP applications could get some of MPTCP's =

benefits using proxies or LD_PRELOAD techniques.

>> Having as much code in userspace as possible will help.  Moving path
>> management to userspace seems like it could be an easy way to do that (a=
nd
>> thinking specifically about how Android does networking, the kernel does=
n't
>> really have enough information to decide which subflows should go where,
>> anyway).
>>
>> For a mobile device, the simplest approach seems to be to just to
>> have zero or one subflows per interface, with explicit addition and remo=
val
>> of subflows from userspace, and possibly a setsockopt to add and disable
>> MP_PRIO.
>
> +1

For userspace path management and control of adding/removing subflows, do =

you prefer to have per-application control, or does systemwide control =

through a netlink socket work? I have been leaning in the netlink =

direction as a way to keep the application interface simpler, and am =

hoping to get more information to determine if that's the best approach.

>> What I think that means is that there needs to be a subflow abstraction =

>> that userspace can see. One way to do this might be to expose the subflo=
ws
>> as individual sockets on which read() and write() return EINVAL, but on
>> which connect() and setsockopt() can operate as normal - connect() to
>> establish a subflow, setsockopt() to do things like set subflows to back=
up,
>> ask the kernel to send the MP_PRIO option, and so on. Not sure what you'd
>> do on a server to get the subflows for accepted connections, though. For
>> blocking calls you could use accept() on the master socket, but really y=
ou
>> want an asynchronous notification when a connection comes in. Perhaps gi=
ve
>> up support for urgent data and re-use POLLPRI? There is precedent for
>> reusing POLLPRI for things that aren't urgent data, but such as solution
>> might be seen as too hacky by upstream.

On the server side, is there application-level knowledge that would affect =

the decision to accept, reject, initiate, or close a subflow? Or would it =

be a set policy (say, maximum of X subflows per connection) that could be =

managed without notifying the application?

>> The alternative would be to expose only one filedescriptor and use
>> subsetsockopts to affect the individual flows, like
>> draft-hesmans-mptcp-socket-02
>> does. On Android specifically, routing traffic on a particular network
>> (e.g., wifi vs. cellular) requires that sk->sk_mark be set to an
>> appropriate value, so there must be a way to do that for each subflow.
>
> Yes, I think both approaches would be fine. Although, I'm not sure what
> upstream's opinion is on adding more socket-options. Which is why the fir=
st
> option might probably be better.

Since we could add SOL_MPTCP we wouldn't be cluttering up TCP's option =

space, so it seems reasonable to propose some new options.

> Wrt. to the asynchronous mechanism for accepting new subflows. What about
> using the error-queue that is used today for SO_TIMESTAMP? This could wake
> up the socket and signal that there is a new subflow. Then the app can do=
 an
> accept() to get the fd.

MSG_ZEROCOPY is a recent addition that uses the error queue in a similar =

way: https://lwn.net/Articles/726917/

> I have another question: How do you see the risk of "malicious" apps that
> then create subflows on cell and just send plenty of data over the cellul=
ar
> interface? Because, if we expose path-management at the user-space level =
an
> app can take full control over the behavior of MPTCP.

I'd see this as a benefit of the netlink-based path manager, which would =

act at the system level.

>> One general thing I've heard is that having the API flow be similar to t=
he
>> single-TCP-socket model is an advantage - for example, I hear that one of
>> the reasons for the low adoption of TFO on Linux is that the API is
>> different to standard TCP because it uses sendto() instead of connect, a=
nd
>> that makes it hard to use lots of libraries such as openssl that want "a
>> filedescriptor of a connected socket".

Agreed - ease of use and familiarity are important. Applications without =

MPTCP already have the ability to open multiple TCP connections and make =

use of different network paths, but then they have extra complexity to =

manage. MPTCP can hide that complexity from the application.

>> The scheduler seems like it could belong in the kernel, because it has to
>> react quickly to events such as receiving packets. Perhaps this could use
>> similar mechanisms to the existing pluggable congestion control algorith=
ms?
>
> Yes, we already have this today where schedulers are implemented as
> pluggable modules that can be selected either through sysctl or a
> socket-option (exactly the same as congestion control).
>
> These schedulers however currently don't have many configuration knobs to
> tune them.

Application with more specific scheduling needs could give hints to =

schedulers using control messages.

>> Another option, for advanced clients, would be to have userspace pass in=
 a
>> scheduling algorithm written in EBPF. One thing that might be helpful is=
 to
>> have a "send all packets on all subflows" scheduler for cases, though I'm
>> not sure if that's feasible.
>
> I like that idea of an ebpf-style scheduler.

The recent "socket tap" patch set on netdev made me start thinking of how =

eBPF might apply to MPTCP. Scheduling would be a good fit!


Regards,
Mat


>
>
> Cheers,
> Christoph
>
>>
>> Regards,
>> Lorenzo
>>
>> On Wed, Aug 2, 2017 at 2:09 PM, Christoph Paasch <cpaasch(a)apple.com> w=
rote:
>>
>>> Hello,
>>>
>>> I'm adding Lorenzo (in CC) from Google to this thread. Lorenzo works on=
 the
>>> networking of Android at Google.
>>> Lorenzo, you can subscribe to the mailing-list at
>>> https://lists.01.org/mailman/listinfo/mptcp.
>>>
>>>
>>> I discussed MPTCP with him at the IETF two weeks back, and he was
>>> interested
>>> in helping making MPTCP upstreamable.
>>> I let him chime in on the discussion.
>>>
>>>
>>>
>>> Wrt. to the below, yes I agree with the appraoch Mat outlined.
>>> On my side, I will be able to spend more cycles now on Linux. I will st=
art
>>> by porting the code from multipath-tcp.org up to upstream's version (we
>>> have
>>> been lagging behind quite a bit again). That way we have a common base
>>> where
>>> we can easily see how well the RFC-patches (for example more generic
>>> capabilities in TCP) would work with MPTCP.
>>>
>>>
>>> Cheers,
>>> Christoph
>>>
>>>
>>>
>>> On 18/07/17 - 17:31:51, Mat Martineau wrote:
>>>>
>>>> Hello everyone,
>>>>
>>>> Our goal on this mailing list is to add an MPTCP implementation to the
>>>> upstream Linux kernel. There's a fair amount of work to be done to
>>> achieve
>>>> this, and a number of options for how to go about it. Some of this
>>> revisits
>>>> previous discussions on this list and elsewhere, but I want to be sure=
 we
>>>> have some level of consensus about the direction to head in.
>>>>
>>>> A couple of us on this list have had discussions with the Linux net
>>>> maintainers, and they have some some specific needs concerning
>>> modifications
>>>> to the Linux TCP stack:
>>>>
>>>>  * TCP complexity can't increase. It's already a complex,
>>>> performance-sensitive piece of software that every Linux user depends =
on.
>>>> Intrusive changes have a risk of creating bugs or changing operation of
>>> the
>>>> stack in unexpected ways.
>>>>
>>>>  * sk_buff structure size can't get bigger. It's already large and, if
>>>> anything, they hope to reduce it's size. Changes to the data structure
>>> size
>>>> are amplified by the large number of instances in a system handling a
>>> lot of
>>>> traffic.
>>>>
>>>>  * An additional protocol like MPTCP should be opt-in, so users of
>>> regular
>>>> TCP continue to get the same type of connection and performance unless
>>> MPTCP
>>>> is requested.
>>>>
>>>> I also recommend reading "On submitting kernel patches"
>>>> (http://halobates.de/on-submitting-patches.pdf) to get an idea of the
>>>> process and hurdles involved in merging major core functionality for t=
he
>>>> Linux kernel.
>>>>
>>>>
>>>> Various Strategies
>>>> ------------------
>>>>
>>>> One approach is to attempt to merge the multipath-tcp.org fork. This is
>>> an
>>>> implementation in which the multipath-tcp.org community has invested a
>>> lot
>>>> of time and effort, and it is in production for major applications (see
>>>> https://tools.ietf.org/html/rfc8041). This is a tremendous amount of
>>> code to
>>>> review at once (even separating out modules), and currently doesn't fit
>>> with
>>>> what the maintainers have asked for (non-intrusive, sk_buff size, MPTCP
>>> by
>>>> default). I don't think the maintainers would consider merging such an
>>>> extensive piece git history, especially where there are a fair number =
of
>>>> commits without an "mptcp:" label on the subject line or without a DCO
>>>> signoff (https://www.kernel.org/doc/html/latest/process/
>>> submitting-patches.html#sign-your-work-the-developer-s-
>>> certificate-of-origin).
>>>> Today, the fork is at kernel v4.4 and current upstream development is =
at
>>>> v4.13-rc1, so the fork would have to catch up and stay current.
>>>>
>>>> The other extreme is to rewrite from scratch. This would allow
>>> incremental
>>>> development with maintainer review from the start, but doesn't take
>>>> advantage of existing code.
>>>>
>>>> The most realistic approach is somewhere in between, where we write new
>>> code
>>>> that fits maintainer expectations and utilize components from the fork
>>> where
>>>> licensing allows and the code fits. We'll have to find the right balan=
ce:
>>>> over-reliance on new code could take extra time, but constantly rework=
ing
>>>> the fork and keeping it up-to-date with net-next is also a lot of
>>> overhead.
>>>>
>>>> To start with, we can create RFC patches (code that's ready for comment
>>>> rather than merge -- not "RFC" in the IETF sense) that allow us to ext=
end
>>>> TCP in the ways that are useful for both MPTCP and other extended TCP
>>>> features. The maintainers would be able to review those standalone
>>> patches,
>>>> and there's potential to backport the patches to prove them out with t=
he
>>>> multipath-tcp.org code. Does this sound sensible? Any other approaches
>>> to
>>>> consider, or details that we should discuss here?
>>>>
>>>>
>>>> Design for Upstream
>>>> -------------------
>>>>
>>>> As a starting point for discussion, here are some characteristics that
>>> might
>>>> make MPTCP more upstream-friendly:
>>>>
>>>>  * MPTCP is used when requested by the application, either through an
>>>> IPPROTO_MPTCP parameter to socket() or by using the new ULP (Upper Lay=
er
>>>> Protocol) capability.
>>>>
>>>>  * Move away from meta-sockets, treating each subflow more like a regu=
lar
>>>> TCP connection. The overall MPTCP connection is coordinated by an upper
>>>> layer socket that is distinct from tcp_sock.
>>>>
>>>>  * Move functionality to userspace where possible, like tracking
>>> ADD_ADDRs
>>>> received, initiating new subflows, or accepting new subflows.
>>>>
>>>>  * Avoid adding locks to coordinate access to data that's shared betwe=
en
>>>> subflows. Utilize capabilities like compare-and-swap (cmpxchg), atomic=
s,
>>> and
>>>> RCU to deal with shared data efficiently.
>>>>
>>>>  * Add generic capabilities to the TCP stack where it looks useful to
>>> other
>>>> protocol extensions. Examples: dynamically register handlers for TCP
>>> option
>>>> headers, make it possible to pass TCP options to/from an upper layer.
>>>>
>>>> Any comment on these? Maybe each deserves a thread of its own.
>>>>
>>>>
>>>> Thanks again to Rao, Christoph, Peter, and Ossama for your help, work,
>>> and
>>>> interest. I'm looking forward to your insights.
>>>>
>>>>
>>>> --
>>>> Mat Martineau
>>>> Intel OTC
>>>> _______________________________________________
>>>> mptcp mailing list
>>>> mptcp(a)lists.01.org
>>>> https://lists.01.org/mailman/listinfo/mptcp
>>>
>

--
Mat Martineau
Intel OTC

--===============7807995159120140902==--
