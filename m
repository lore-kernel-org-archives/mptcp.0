Content-Type: multipart/mixed; boundary="===============7309852631313039327=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Conference talk ideas, round 2
Date: Wed, 16 May 2018 18:12:47 +0200
Message-ID: <CAKuKrBmR5ugU4v8AWFSubK8Pn0thhnLmxyQOxkRnn-814ixPDQ@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1805151718550.75056@jbutler7-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 630

--===============7309852631313039327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Christoph,

On Wed, May 16, 2018 at 2:26 AM, Mat Martineau
<mathew.j.martineau(a)linux.intel.com> wrote:
>
> On Tue, 15 May 2018, Christoph Paasch wrote:
>
>> Hello Matthieu,
>>
>> On 15/05/18 - 18:23:01, Matthieu Baerts wrote:
>>>
>>> On Tue, May 15, 2018 at 12:59 AM, Mat Martineau <
>>> mathew.j.martineau(a)linux.intel.com> wrote:
>>>>
>>>> On Mon, 14 May 2018, Matthieu Baerts wrote:
>>>>>
>>>>> On Mon, May 14, 2018 at 6:02 AM, Mat Martineau <
>>>>> mathew.j.martineau(a)linux.intel.com> wrote:
>>>>>
>>>>>       Hello -
>>>>>
>>>>>       We had a meeting last week to discuss reshaping our netdev
>>>>> conference MPTCP talk proposal based on feedback from the committee.
>>>>>       The plan is to re-focus on upstreaming concerns, challenges, and
>>>>> progress.
>>>>>
>>>>>       I worked on outlining some topics that might fit with the talk.=
 I
>>>>> don't think this is exhaustive, and I'm also not saying
>>>>>       everything here is required to be in the talk. I'm looking forw=
ard
>>>>> to your comments and additional ideas.
>>>>>
>>>>>
>>>>> Thank you for the list!
>>>>>
>>>>> Should we focus our talk on: Why is adding intrusive protocols like M=
PTCP
>>>>> to the upstream kernel so complicated?
>>>>>
>>>>>
>>>> I think the complexity of MPTCP is unique in that additional protocols
>>>> don't usually overlap with an existing protocol - especially a protoco=
l as
>>>> heavily used and optimized as TCP. I'm not sure how many MPTCP-like
>>>> protocols are out there, but we definitely can focus on the complexity=
 of
>>>> MPTCP upstreaming. The most similar thing I can think of is the Blueto=
oth
>>>> L2CAP-ERTM code in the kernel, but the layering there was cleaner (I w=
rote
>>>> that ERTM kernel code and upstreamed it after maintaining it separatel=
y for
>>>> a while - sound familiar?).
>>>>
>>>> In terms of topic priorities, I think the last two top-level bullet po=
ints
>>>> (large change logistics and "show us the code") are less important tha=
n the
>>>> earlier points.
>>>>
>>>>
>>>> The conference committee announced acceptance of a QUIC talk, and it m=
ade
>>>> me think about how QUIC doesn't have these kernel issues since it buil=
ds on
>>>> UDP. In contrast, the design of MPTCP pushes complexity in to the kern=
el in
>>>> order to look like TCP on the wire and to fit with legacy applications.
>>>>
>>>
>>> Thank you Mat for your comments! I tried to compile everything you wrote
>>> here below.
>>>
>>>
>>>> If you want and if nobody has already started it, I can have a look to
>>>>>
>>>>> prepare a first draft for a description for this talk.
>>>>>
>>>>
>>>> It would be very helpful if you can prepare that draft. Thank you!
>>>>
>>>
>>> Here is my new proposal with some comments:
>>>
>>> * Title of the submission: Why is adding Multipath TCP to the upstream
>>>>
>>>> kernel complicated?
>>>>
>>>
>>> At the end, it seems it is what we are going to present but feel free to
>>> propose anything else!
>>>
>>> We could maybe do a reference to published paper ;-)
>>>
>>>     How hard can it be? Adding Multipath TCP to the upstream kernel.
>>
>>
>> I like this title ;-)
>>
>
> I do too, especially considering the titles and summaries that have been =
announced so far.


Great, I will use this one!

>>> * Label: Moonshot / Nuts and bolts
>>>>
>>>>
>>>
>>> I guess it is more a "Moonshot" but in the Nuts and bolts description i=
t is
>>> written: "These are presentations that might take a deep dive into
>>> implementation and development of technology in Linux kernel networking=
".
>>> What do you think?
>>
>>
>> I feel it's more of a Nuts and bolts-style presentation.
>>
>> I wouldn't consider MPTCP "the next big thing" in Linux kernel networkin=
g.
>> Except if we would come with an entirely new architecture for TCP :-)
>
>
> Agreed.


Thank you, I will change that as well!

>>> Here are the three possible labels:
>>>
>>>    - "Moonshot" - These are sessions about the next big thing in Linux
>>>    kernel networking. If you are thinking about new and exciting techno=
logy or
>>>    big idea and want feedback, then consider submitting a "moonshot" pr=
oposal.
>>>    As an example, the first time XDP was presented in Netdev it would h=
ave
>>>    probably have qualified as a "moonshot".
>>>    - "Nuts and bolts" - These are presentations that might take a deep =
dive
>>>    into implementation and development of technology in Linux kernel
>>>    networking. If you have well tested ideas and code that you would li=
ke to
>>>    push forward inclusion and adoption by the community (kernel/user sp=
ace)
>>>    then consider submitting a "nuts and bolts" proposal. It is also acc=
eptable
>>>    in a "nuts and bolts" session to have a talk to document how things =
work
>>>    under the covers especially if they are already in deployment in the
>>>    kernel/user space but have never been documented. An example of a "n=
uts and
>>>    bolts" session is DSA which was first described in Netdev 2.1.
>>>    - "Hands on" - These are more what traditionally has been thought of=
 as
>>>    tutorials. These sessions focus on configuring and using Linux kernel
>>>    networking technologies and features. This is an opportunity to share
>>>    deployment experience and wisdom about how to best employ kernel
>>>    technology. To provide a truly "hands on" experience, there should b=
e real
>>>    examples and case studies presented that the audience could try out =
in real
>>>    time. Previous Netdev sessions on iptables are good examples of "han=
ds on"
>>>    sessions.
>>>
>>> * Submission type: talk
>>>>
>>>>
>>>
>>> Here are more info about what they call a "talk" type:
>>>
>>>    - Talk - One or more of authors elaborating on a proposal within a 30
>>>    minute session. A 2-10 pages (not including references) paper submis=
sion of
>>>    the talk is required in odt or latex format. "Nuts-and-bolts" as wel=
l as
>>>    "moonshot" submissions are a fit here.
>>>
>>> I don't know about the 2-10 pages paper. Is it to describe the technolo=
gy
>>> or what we are going to present? Is it really needed to describe MPTCP?
>>
>>
>> Example papers of the last netdev conference can be found here: https://=
www.netdevconf.org/2.2/papers/netdev22papers.tgz
>>
>> I think we should briefly describe the technology and then dive into the
>> presentation's topics.
>>
>> Basically, the outline you already put on sharelatex.com looks good to m=
e.


Thank you Christoph, I will dedicate time tomorrow to update this
paper if we need to send it with the proposal. (Apparently, we don't)

>>> * Estimate of length of time for presentation: 30 minutes
>>>>
>>>>
>>>
>>> It seems Talk are limited to 30 minutes.
>>>
>>> * Description of proposal:
>>>>
>>>>     A community project is underway to add Multipath TCP to the upstre=
am
>>>> Linux kernel. This talk will briefly introduce the audience to this TCP
>>>> extension (RFC 6824) and mention some use cases already in production.=
 The
>>>> rest of the talk will be dedicated to interactive discussions of the
>>>> challenges in converging on an upstream MPTCP implementation.
>>>>
>>>>     The current MPTCP implementation, already used by millions of devi=
ces,
>>>> cannot be proposed upstream as it is due to its too invasive architect=
ure.
>>>> This architecture was good when the protocol was in development and
>>>> research but now that it is stabilised, the design should be revamped =
for
>>>> an upstream inclusion.
>>
>>
>> I suggest to change the last sentence to:
>>
>> This architecture stems from the needs that were established when MPTCP =
was
>> still a research project. However, now that the protocol has stabilized =
and
>> the implementation is being used in production environments, the design
>> needs to be revamped for an upstream inclusion.
>
>
> +1 on Christoph's suggestion


Thank you for this better explanation!

>>>>
>>>> But this task is far from being easy as the design
>>>> of MPTCP pushes complexity into the kernel in order to look like TCP o=
n the
>>>> wire and to fit with legacy applications and middleboxes.
>>
>>
>> I would not mention legacy applications as there is no real need to make
>> MPTCP look like TCP from an application's point-of-view.
>>
>> I suggest:
>>
>> But this task is far from being easy as the MPTCP protocol design tightly
>> couples with TCP in order to look like regular TCP on the wire, allowing=
 it
>> to traverse the Internet with all its middleboxes and firewalls.


Indeed, before we wanted all applications uses MPTCP by default, it is
no longer the case. Better to insist on the middleboxes then!

>>>> This makes the
>>>> complexity of this upstream project a bit unique in that additional
>>>> protocols don't usually overlap that much with an existing protocol -
>>>> especially a protocol as heavily used and optimised as TCP.
>>>>
>>>>     During this talk, we will present the different challenges we have
>>>> faced and we are still facing today: from the protocol challenges to t=
he
>>>> design without adversely affecting TCP or networking structures throug=
h the
>>>> fundamental challenge of "show us the code" way to have discussions wi=
th
>>>> main contributors and maintainers.
>>
>>
>> This above paragraph brings it to the point! Great!
>>
>>>>     Note that the previous presentation by Octavian at Netdev 0.1 focu=
sed
>>>> on the operation of the protocol and migration of the existing MPTCP L=
inux
>>>> implementation. This talk will more specifically address what "upstream
>>>> MPTCP" looks like, how MPTCP compares to in-kernel TCP users like TLS =
and
>>>> KCM, the unique challenges in extending TCP for this protocol, and mov=
ing
>>>> some functionalities to userspace.
>>
>>
>> Not sure, this is needed. Mat - what do you think?
>
>
> I don't think it's needed for the summary.


Should I add this as a note for the committee?

>>>>     For more information about this project:
>>>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>>>>
>>>
>>> That is around 300 words. I don't think we need to mention all technical
>>> bits from Mat's list but I do think it could be interesting to use this
>>> list as a base for both the 2-10 pages paper and the talk itself. Again=
 I
>>> am not sure the paper is really
>
>
> Right, not everything in my list belongs in the summary.
>
>>
>> From what I understand in the submission instructions, the paper is need=
ed
>> and it will be published.
>
>
> Yes, the paper is a requirement. It doesn't have to be finalized until th=
e time of the conference (or maybe even later?) as far as I know.


Oh thank you, I missed that point :)
On the website, I can indeed see this:

* Call for Presentation Proposals closes on May 20, 2018.
* Draft papers/slides due on June 30,2018.

>>>
>>> needed but it can be useful to prepare the
>>> talk as well. That is why I just prepared a first draft on ShareLatex:
>>> https://www.sharelatex.com/read/mdnhtfgxpkhg
>>>
>>> The beginning is mainly inspired by this paper, I guess/hope it is fine=
 as
>>> I am co-author and the goal is not to publish the paper:
>>> https://inl.info.ucl.ac.be/system/files/PAM2016_54-deconinck.pdf
>>> The rest is Mat's list. If we want to go in this direction, I can conve=
rt
>>> bullet points into sentences if they were not magically converted durin=
g my
>>> night :)
>>> Unfortunately with ShareLatex, you need an account to edit text. Then y=
ou
>>> can go to https://www.sharelatex.com/8294638822ybsnsmmwkzcp
>>>
>>> Of course, feel free to comment this new proposal, rewrite it completely
>>> with a better English if needed and edit the paper on ShareLatex! :)
>>
>>
>> I will try to find time at the end of the day today to go over the paper=
 and
>> fill in some blanks.
>
>
> I can spend some time editing on Wednesday PDT too.


Thank you!

Here is the updated text I propose to send. I can wait for the meeting
we will have tomorrow to send it.

`````````````
> * Title of the submission: How hard can it be? Adding Multipath TCP to th=
e upstream kernel.
>
> * Label: Nuts and bolts
>
> * Submission type: talk
>
> * Estimate of length of time for presentation: 30 minutes
>
> * Description of proposal:
>     A community project is underway to add Multipath TCP to the upstream =
Linux kernel. This talk will briefly introduce the audience to this TCP ext=
ension (RFC 6824) and mention some use cases already in production. The res=
t of the talk will be dedicated to interactive discussions of the challenge=
s in converging on an upstream MPTCP implementation.
>
>     The current MPTCP implementation, already used by millions of devices=
, cannot be proposed upstream as it is due to its too invasive architecture=
. This architecture stems from the needs that were established when MPTCP w=
as still a research project. However, now that the protocol has stabilized =
and the implementation is being used in production environments, the design=
 needs to be revamped for an upstream inclusion. But this task is far from =
being easy as the MPTCP protocol design tightly couples with TCP in order t=
o look like regular TCP on the wire, allowing it to traverse the Internet w=
ith all its middleboxes and firewalls. This makes the complexity of this up=
stream project a bit unique in that additional protocols don't usually over=
lap that much with an existing protocol - especially a protocol as heavily =
used and optimised as TCP.
>
>     During this talk, we will present the different challenges we have fa=
ced and we are still facing today: from the protocol challenges to the desi=
gn without adversely affecting TCP or networking structures through the fun=
damental challenge of "show us the code" way to have discussions with main =
contributors and maintainers.
>
>     For more information about this project: https://github.com/multipath=
-tcp/mptcp_net-next/wiki
>
> * Extra note: the previous presentation about upstreaming MPTCP by Octavi=
an at Netdev 0.1 focused on the operation of the protocol and migration of =
the existing MPTCP Linux implementation. This talk will more specifically a=
ddress what "upstream MPTCP" looks like, how MPTCP compares to in-kernel TC=
P users like TLS and KCM, the unique challenges in extending TCP for this p=
rotocol, and moving some functionalities to userspace.
`````````````

Best regards,
Matthieu


>
> Thanks,
> Mat
>
>
>>
>>
>> Christoph
>>
>>>
>>> Best regards,
>>> Matthieu
>>>
>>>
>>>>
>>>>
>>>> Mat
>>>>
>>>>
>>>>
>>>>
>>>>> Best regards,
>>>>> Matthieu
>>>>>
>>>>>       * Why is adding MPTCP to the upstream kernel complicated?
>>>>>
>>>>>           * Differences in requirements and features from existing
>>>>> implementation
>>>>>
>>>>>               * Every TCP socket affected vs. staying out of the way =
for
>>>>> normal TCP
>>>>>
>>>>>               * Multipath protocol development and research vs giving=
 TCP
>>>>> users/maintainers weight
>>>>>
>>>>>           * Protocol challenges
>>>>>
>>>>>               * Coupled receive windows across TCP subflows
>>>>>
>>>>>               * Behavior change for duplicate acks
>>>>>
>>>>>               * Per-packet metadata (tx path) and option writing
>>>>>
>>>>>               * TCP option parsing - packets are currently dropped af=
ter
>>>>> options are parsed
>>>>>
>>>>>               * Collapse/coalesce of skbs after receive - per-packet
>>>>> headers lost in TCP layer
>>>>>
>>>>>           * Must do all this without adversely affecting TCP or
>>>>> networking structs (like sk_buff)
>>>>>
>>>>>               * TCP performance not reduced
>>>>>
>>>>>               * Memory requirements for TCP not increased
>>>>>
>>>>>               * Maintainability not made harder
>>>>>
>>>>>           * Compare to KCM, which adds metadata to each stream, didn't
>>>>> require TCP changes
>>>>>
>>>>>       * What fits well in the networking subsystem
>>>>>
>>>>>           * Some connection code (callbacks exist)
>>>>>
>>>>>           * Creating a new socket type for MPTCP
>>>>>
>>>>>           * New ULP capability
>>>>>
>>>>>               * No rules yet for multiple users, because TLS is the o=
nly
>>>>> user
>>>>>
>>>>>           * In-kernel sockets
>>>>>
>>>>>           * do_tcp_sendpages() to send data buffered at the connection
>>>>> level
>>>>>
>>>>>           * tcp_read_sock() to get incoming skbs
>>>>>
>>>>>       * What's a challenge in the networking subsystem
>>>>>
>>>>>           * Indirect calls are now more expensive
>>>>>
>>>>>           * MPTCP builds on TCP in a unique way
>>>>>
>>>>>       * What we have tried
>>>>>
>>>>>           * Identify where other features could use TCP extension
>>>>> capabilities and merge before MPTCP
>>>>>
>>>>>               * Options framework used by TCP-MD5 and SMC
>>>>>
>>>>>               * Didn't work out - expensive indirect calls and no MPT=
CP
>>>>> frame of reference for the maintainer
>>>>>
>>>>>           * Sharing code demonstrating architectural approaches that =
use
>>>>> current upstream netdev functionality
>>>>>
>>>>>           * Moving components to userspace
>>>>>
>>>>>           * Forking and reducing functionality of existing MPTCP code=
 base
>>>>>
>>>>>       * Large change logistics
>>>>>
>>>>>           * Reshaping code in to a reviewable patch set or patch sets.
>>>>> Implement functionality in stages?
>>>>>
>>>>>       * Fundamental challenge of "show us the code" - must decide what
>>>>> seems upstreamable, implement it, share, and iterate.
>>>>>
>
> --
> Mat Martineau
> Intel OTC




-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============7309852631313039327==--
