Content-Type: multipart/mixed; boundary="===============0314651272902481674=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming strategy and design
Date: Wed, 02 Aug 2017 10:04:46 -0700
Message-ID: <alpine.OSX.2.21.1708020927320.17933@wgho-mobl1.amr.corp.intel.com>
In-Reply-To: 20170802050903.GF66276@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 70

--===============0314651272902481674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 1 Aug 2017, Christoph Paasch wrote:

> Hello,
>
> I'm adding Lorenzo (in CC) from Google to this thread. Lorenzo works on t=
he
> networking of Android at Google.
> Lorenzo, you can subscribe to the mailing-list at
> https://lists.01.org/mailman/listinfo/mptcp.
>
>
> I discussed MPTCP with him at the IETF two weeks back, and he was interes=
ted
> in helping making MPTCP upstreamable.
> I let him chime in on the discussion.

Welcome, Lorenzo! Great to hear that you're interested in lending your =

expertise.

>
> Wrt. to the below, yes I agree with the appraoch Mat outlined.
> On my side, I will be able to spend more cycles now on Linux. I will start
> by porting the code from multipath-tcp.org up to upstream's version (we h=
ave
> been lagging behind quite a bit again). That way we have a common base wh=
ere
> we can easily see how well the RFC-patches (for example more generic
> capabilities in TCP) would work with MPTCP.
>

Thanks, Christoph. That will be a big help.


Mat


>
>
> On 18/07/17 - 17:31:51, Mat Martineau wrote:
>>
>> Hello everyone,
>>
>> Our goal on this mailing list is to add an MPTCP implementation to the
>> upstream Linux kernel. There's a fair amount of work to be done to achie=
ve
>> this, and a number of options for how to go about it. Some of this revis=
its
>> previous discussions on this list and elsewhere, but I want to be sure we
>> have some level of consensus about the direction to head in.
>>
>> A couple of us on this list have had discussions with the Linux net
>> maintainers, and they have some some specific needs concerning modificat=
ions
>> to the Linux TCP stack:
>>
>>  * TCP complexity can't increase. It's already a complex,
>> performance-sensitive piece of software that every Linux user depends on.
>> Intrusive changes have a risk of creating bugs or changing operation of =
the
>> stack in unexpected ways.
>>
>>  * sk_buff structure size can't get bigger. It's already large and, if
>> anything, they hope to reduce it's size. Changes to the data structure s=
ize
>> are amplified by the large number of instances in a system handling a lo=
t of
>> traffic.
>>
>>  * An additional protocol like MPTCP should be opt-in, so users of regul=
ar
>> TCP continue to get the same type of connection and performance unless M=
PTCP
>> is requested.
>>
>> I also recommend reading "On submitting kernel patches"
>> (http://halobates.de/on-submitting-patches.pdf) to get an idea of the
>> process and hurdles involved in merging major core functionality for the
>> Linux kernel.
>>
>>
>> Various Strategies
>> ------------------
>>
>> One approach is to attempt to merge the multipath-tcp.org fork. This is =
an
>> implementation in which the multipath-tcp.org community has invested a l=
ot
>> of time and effort, and it is in production for major applications (see
>> https://tools.ietf.org/html/rfc8041). This is a tremendous amount of cod=
e to
>> review at once (even separating out modules), and currently doesn't fit =
with
>> what the maintainers have asked for (non-intrusive, sk_buff size, MPTCP =
by
>> default). I don't think the maintainers would consider merging such an
>> extensive piece git history, especially where there are a fair number of
>> commits without an "mptcp:" label on the subject line or without a DCO
>> signoff (https://www.kernel.org/doc/html/latest/process/submitting-patch=
es.html#sign-your-work-the-developer-s-certificate-of-origin).
>> Today, the fork is at kernel v4.4 and current upstream development is at
>> v4.13-rc1, so the fork would have to catch up and stay current.
>>
>> The other extreme is to rewrite from scratch. This would allow increment=
al
>> development with maintainer review from the start, but doesn't take
>> advantage of existing code.
>>
>> The most realistic approach is somewhere in between, where we write new =
code
>> that fits maintainer expectations and utilize components from the fork w=
here
>> licensing allows and the code fits. We'll have to find the right balance:
>> over-reliance on new code could take extra time, but constantly reworking
>> the fork and keeping it up-to-date with net-next is also a lot of overhe=
ad.
>>
>> To start with, we can create RFC patches (code that's ready for comment
>> rather than merge -- not "RFC" in the IETF sense) that allow us to extend
>> TCP in the ways that are useful for both MPTCP and other extended TCP
>> features. The maintainers would be able to review those standalone patch=
es,
>> and there's potential to backport the patches to prove them out with the
>> multipath-tcp.org code. Does this sound sensible? Any other approaches to
>> consider, or details that we should discuss here?
>>
>>
>> Design for Upstream
>> -------------------
>>
>> As a starting point for discussion, here are some characteristics that m=
ight
>> make MPTCP more upstream-friendly:
>>
>>  * MPTCP is used when requested by the application, either through an
>> IPPROTO_MPTCP parameter to socket() or by using the new ULP (Upper Layer
>> Protocol) capability.
>>
>>  * Move away from meta-sockets, treating each subflow more like a regular
>> TCP connection. The overall MPTCP connection is coordinated by an upper
>> layer socket that is distinct from tcp_sock.
>>
>>  * Move functionality to userspace where possible, like tracking ADD_ADD=
Rs
>> received, initiating new subflows, or accepting new subflows.
>>
>>  * Avoid adding locks to coordinate access to data that's shared between
>> subflows. Utilize capabilities like compare-and-swap (cmpxchg), atomics,=
 and
>> RCU to deal with shared data efficiently.
>>
>>  * Add generic capabilities to the TCP stack where it looks useful to ot=
her
>> protocol extensions. Examples: dynamically register handlers for TCP opt=
ion
>> headers, make it possible to pass TCP options to/from an upper layer.
>>
>> Any comment on these? Maybe each deserves a thread of its own.
>>
>>
>> Thanks again to Rao, Christoph, Peter, and Ossama for your help, work, a=
nd
>> interest. I'm looking forward to your insights.
>>
>>
>> --
>> Mat Martineau
>> Intel OTC
>> _______________________________________________
>> mptcp mailing list
>> mptcp(a)lists.01.org
>> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel OTC

--===============0314651272902481674==--
