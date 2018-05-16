Content-Type: multipart/mixed; boundary="===============2658670785729948357=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Conference talk ideas, round 2
Date: Tue, 15 May 2018 17:26:18 -0700
Message-ID: <alpine.OSX.2.21.1805151718550.75056@jbutler7-mobl.amr.corp.intel.com>
In-Reply-To: 20180515170337.GI9303@MacBook-Pro-19.local
X-Status: 
X-Keywords:                  
X-UID: 629

--===============2658670785729948357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 15 May 2018, Christoph Paasch wrote:

> Hello Matthieu,
>
> On 15/05/18 - 18:23:01, Matthieu Baerts wrote:
>> On Tue, May 15, 2018 at 12:59 AM, Mat Martineau <
>> mathew.j.martineau(a)linux.intel.com> wrote:
>>> On Mon, 14 May 2018, Matthieu Baerts wrote:
>>>> On Mon, May 14, 2018 at 6:02 AM, Mat Martineau <
>>>> mathew.j.martineau(a)linux.intel.com> wrote:
>>>>
>>>>       Hello -
>>>>
>>>>       We had a meeting last week to discuss reshaping our netdev
>>>> conference MPTCP talk proposal based on feedback from the committee.
>>>>       The plan is to re-focus on upstreaming concerns, challenges, and
>>>> progress.
>>>>
>>>>       I worked on outlining some topics that might fit with the talk. I
>>>> don't think this is exhaustive, and I'm also not saying
>>>>       everything here is required to be in the talk. I'm looking forwa=
rd
>>>> to your comments and additional ideas.
>>>>
>>>>
>>>> Thank you for the list!
>>>>
>>>> Should we focus our talk on: Why is adding intrusive protocols like MP=
TCP
>>>> to the upstream kernel so complicated?
>>>>
>>>>
>>> I think the complexity of MPTCP is unique in that additional protocols
>>> don't usually overlap with an existing protocol - especially a protocol=
 as
>>> heavily used and optimized as TCP. I'm not sure how many MPTCP-like
>>> protocols are out there, but we definitely can focus on the complexity =
of
>>> MPTCP upstreaming. The most similar thing I can think of is the Bluetoo=
th
>>> L2CAP-ERTM code in the kernel, but the layering there was cleaner (I wr=
ote
>>> that ERTM kernel code and upstreamed it after maintaining it separately=
 for
>>> a while - sound familiar?).
>>>
>>> In terms of topic priorities, I think the last two top-level bullet poi=
nts
>>> (large change logistics and "show us the code") are less important than=
 the
>>> earlier points.
>>>
>>>
>>> The conference committee announced acceptance of a QUIC talk, and it ma=
de
>>> me think about how QUIC doesn't have these kernel issues since it build=
s on
>>> UDP. In contrast, the design of MPTCP pushes complexity in to the kerne=
l in
>>> order to look like TCP on the wire and to fit with legacy applications.
>>>
>>
>> Thank you Mat for your comments! I tried to compile everything you wrote
>> here below.
>>
>>
>>> If you want and if nobody has already started it, I can have a look to
>>>> prepare a first draft for a description for this talk.
>>>>
>>>
>>> It would be very helpful if you can prepare that draft. Thank you!
>>>
>>
>> Here is my new proposal with some comments:
>>
>> * Title of the submission: Why is adding Multipath TCP to the upstream
>>> kernel complicated?
>>>
>>
>> At the end, it seems it is what we are going to present but feel free to
>> propose anything else!
>>
>> We could maybe do a reference to published paper ;-)
>>
>>     How hard can it be? Adding Multipath TCP to the upstream kernel.
>
> I like this title ;-)
>

I do too, especially considering the titles and summaries that have been =

announced so far.

>>
>> * Label: Moonshot / Nuts and bolts
>>>
>>
>> I guess it is more a "Moonshot" but in the Nuts and bolts description it=
 is
>> written: "These are presentations that might take a deep dive into
>> implementation and development of technology in Linux kernel networking".
>> What do you think?
>
> I feel it's more of a Nuts and bolts-style presentation.
>
> I wouldn't consider MPTCP "the next big thing" in Linux kernel networking.
> Except if we would come with an entirely new architecture for TCP :-)

Agreed.

>
>> Here are the three possible labels:
>>
>>    - "Moonshot" - These are sessions about the next big thing in Linux
>>    kernel networking. If you are thinking about new and exciting technol=
ogy or
>>    big idea and want feedback, then consider submitting a "moonshot" pro=
posal.
>>    As an example, the first time XDP was presented in Netdev it would ha=
ve
>>    probably have qualified as a "moonshot".
>>    - "Nuts and bolts" - These are presentations that might take a deep d=
ive
>>    into implementation and development of technology in Linux kernel
>>    networking. If you have well tested ideas and code that you would lik=
e to
>>    push forward inclusion and adoption by the community (kernel/user spa=
ce)
>>    then consider submitting a "nuts and bolts" proposal. It is also acce=
ptable
>>    in a "nuts and bolts" session to have a talk to document how things w=
ork
>>    under the covers especially if they are already in deployment in the
>>    kernel/user space but have never been documented. An example of a "nu=
ts and
>>    bolts" session is DSA which was first described in Netdev 2.1.
>>    - "Hands on" - These are more what traditionally has been thought of =
as
>>    tutorials. These sessions focus on configuring and using Linux kernel
>>    networking technologies and features. This is an opportunity to share
>>    deployment experience and wisdom about how to best employ kernel
>>    technology. To provide a truly "hands on" experience, there should be=
 real
>>    examples and case studies presented that the audience could try out i=
n real
>>    time. Previous Netdev sessions on iptables are good examples of "hand=
s on"
>>    sessions.
>>
>> * Submission type: talk
>>>
>>
>> Here are more info about what they call a "talk" type:
>>
>>    - Talk - One or more of authors elaborating on a proposal within a 30
>>    minute session. A 2-10 pages (not including references) paper submiss=
ion of
>>    the talk is required in odt or latex format. "Nuts-and-bolts" as well=
 as
>>    "moonshot" submissions are a fit here.
>>
>> I don't know about the 2-10 pages paper. Is it to describe the technology
>> or what we are going to present? Is it really needed to describe MPTCP?
>
> Example papers of the last netdev conference can be found here: https://w=
ww.netdevconf.org/2.2/papers/netdev22papers.tgz
>
> I think we should briefly describe the technology and then dive into the
> presentation's topics.
>
> Basically, the outline you already put on sharelatex.com looks good to me.
>
>
>> * Estimate of length of time for presentation: 30 minutes
>>>
>>
>> It seems Talk are limited to 30 minutes.
>>
>> * Description of proposal:
>>>     A community project is underway to add Multipath TCP to the upstream
>>> Linux kernel. This talk will briefly introduce the audience to this TCP
>>> extension (RFC 6824) and mention some use cases already in production. =
The
>>> rest of the talk will be dedicated to interactive discussions of the
>>> challenges in converging on an upstream MPTCP implementation.
>>>
>>>     The current MPTCP implementation, already used by millions of devic=
es,
>>> cannot be proposed upstream as it is due to its too invasive architectu=
re.
>>> This architecture was good when the protocol was in development and
>>> research but now that it is stabilised, the design should be revamped f=
or
>>> an upstream inclusion.
>
> I suggest to change the last sentence to:
>
> This architecture stems from the needs that were established when MPTCP w=
as
> still a research project. However, now that the protocol has stabilized a=
nd
> the implementation is being used in production environments, the design
> needs to be revamped for an upstream inclusion.

+1 on Christoph's suggestion

>
>>> But this task is far from being easy as the design
>>> of MPTCP pushes complexity into the kernel in order to look like TCP on=
 the
>>> wire and to fit with legacy applications and middleboxes.
>
> I would not mention legacy applications as there is no real need to make
> MPTCP look like TCP from an application's point-of-view.
>
> I suggest:
>
> But this task is far from being easy as the MPTCP protocol design tightly
> couples with TCP in order to look like regular TCP on the wire, allowing =
it
> to traverse the Internet with all its middleboxes and firewalls.
>
>>> This makes the
>>> complexity of this upstream project a bit unique in that additional
>>> protocols don't usually overlap that much with an existing protocol -
>>> especially a protocol as heavily used and optimised as TCP.
>>>
>>>     During this talk, we will present the different challenges we have
>>> faced and we are still facing today: from the protocol challenges to the
>>> design without adversely affecting TCP or networking structures through=
 the
>>> fundamental challenge of "show us the code" way to have discussions with
>>> main contributors and maintainers.
>
> This above paragraph brings it to the point! Great!
>
>>>     Note that the previous presentation by Octavian at Netdev 0.1 focus=
ed
>>> on the operation of the protocol and migration of the existing MPTCP Li=
nux
>>> implementation. This talk will more specifically address what "upstream
>>> MPTCP" looks like, how MPTCP compares to in-kernel TCP users like TLS a=
nd
>>> KCM, the unique challenges in extending TCP for this protocol, and movi=
ng
>>> some functionalities to userspace.
>
> Not sure, this is needed. Mat - what do you think?

I don't think it's needed for the summary.

>
>>>
>>>     For more information about this project:
>>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>>>
>>
>> That is around 300 words. I don't think we need to mention all technical
>> bits from Mat's list but I do think it could be interesting to use this
>> list as a base for both the 2-10 pages paper and the talk itself. Again I
>> am not sure the paper is really

Right, not everything in my list belongs in the summary.

>
> From what I understand in the submission instructions, the paper is needed
> and it will be published.

Yes, the paper is a requirement. It doesn't have to be finalized until the =

time of the conference (or maybe even later?) as far as I know.

>
>> needed but it can be useful to prepare the
>> talk as well. That is why I just prepared a first draft on ShareLatex:
>> https://www.sharelatex.com/read/mdnhtfgxpkhg
>>
>> The beginning is mainly inspired by this paper, I guess/hope it is fine =
as
>> I am co-author and the goal is not to publish the paper:
>> https://inl.info.ucl.ac.be/system/files/PAM2016_54-deconinck.pdf
>> The rest is Mat's list. If we want to go in this direction, I can convert
>> bullet points into sentences if they were not magically converted during=
 my
>> night :)
>> Unfortunately with ShareLatex, you need an account to edit text. Then you
>> can go to https://www.sharelatex.com/8294638822ybsnsmmwkzcp
>>
>> Of course, feel free to comment this new proposal, rewrite it completely
>> with a better English if needed and edit the paper on ShareLatex! :)
>
> I will try to find time at the end of the day today to go over the paper =
and
> fill in some blanks.

I can spend some time editing on Wednesday PDT too.

Thanks,
Mat

>
>
> Christoph
>
>>
>> Best regards,
>> Matthieu
>>
>>
>>>
>>>
>>> Mat
>>>
>>>
>>>
>>>
>>>> Best regards,
>>>> Matthieu
>>>>
>>>>       * Why is adding MPTCP to the upstream kernel complicated?
>>>>
>>>>           * Differences in requirements and features from existing
>>>> implementation
>>>>
>>>>               * Every TCP socket affected vs. staying out of the way f=
or
>>>> normal TCP
>>>>
>>>>               * Multipath protocol development and research vs giving =
TCP
>>>> users/maintainers weight
>>>>
>>>>           * Protocol challenges
>>>>
>>>>               * Coupled receive windows across TCP subflows
>>>>
>>>>               * Behavior change for duplicate acks
>>>>
>>>>               * Per-packet metadata (tx path) and option writing
>>>>
>>>>               * TCP option parsing - packets are currently dropped aft=
er
>>>> options are parsed
>>>>
>>>>               * Collapse/coalesce of skbs after receive - per-packet
>>>> headers lost in TCP layer
>>>>
>>>>           * Must do all this without adversely affecting TCP or
>>>> networking structs (like sk_buff)
>>>>
>>>>               * TCP performance not reduced
>>>>
>>>>               * Memory requirements for TCP not increased
>>>>
>>>>               * Maintainability not made harder
>>>>
>>>>           * Compare to KCM, which adds metadata to each stream, didn't
>>>> require TCP changes
>>>>
>>>>       * What fits well in the networking subsystem
>>>>
>>>>           * Some connection code (callbacks exist)
>>>>
>>>>           * Creating a new socket type for MPTCP
>>>>
>>>>           * New ULP capability
>>>>
>>>>               * No rules yet for multiple users, because TLS is the on=
ly
>>>> user
>>>>
>>>>           * In-kernel sockets
>>>>
>>>>           * do_tcp_sendpages() to send data buffered at the connection
>>>> level
>>>>
>>>>           * tcp_read_sock() to get incoming skbs
>>>>
>>>>       * What's a challenge in the networking subsystem
>>>>
>>>>           * Indirect calls are now more expensive
>>>>
>>>>           * MPTCP builds on TCP in a unique way
>>>>
>>>>       * What we have tried
>>>>
>>>>           * Identify where other features could use TCP extension
>>>> capabilities and merge before MPTCP
>>>>
>>>>               * Options framework used by TCP-MD5 and SMC
>>>>
>>>>               * Didn't work out - expensive indirect calls and no MPTCP
>>>> frame of reference for the maintainer
>>>>
>>>>           * Sharing code demonstrating architectural approaches that u=
se
>>>> current upstream netdev functionality
>>>>
>>>>           * Moving components to userspace
>>>>
>>>>           * Forking and reducing functionality of existing MPTCP code =
base
>>>>
>>>>       * Large change logistics
>>>>
>>>>           * Reshaping code in to a reviewable patch set or patch sets.
>>>> Implement functionality in stages?
>>>>
>>>>       * Fundamental challenge of "show us the code" - must decide what
>>>> seems upstreamable, implement it, share, and iterate.
>>>>

--
Mat Martineau
Intel OTC

--===============2658670785729948357==--
