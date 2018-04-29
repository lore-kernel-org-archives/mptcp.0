Content-Type: multipart/mixed; boundary="===============6022838450764481847=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Sun, 29 Apr 2018 16:08:14 +0200
Message-ID: <CAKuKrBkv0Cd3n326c=zCoCc3isspfxY6MyP9yx7NADowH-KAnA@mail.gmail.com>
In-Reply-To: alpine.OSX.2.21.1804271605590.34300@rabrown-mobl8.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 563

--===============6022838450764481847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Thank you for your review and input!

On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <
mathew.j.martineau(a)linux.intel.com> wrote:

>
> Hi Matthieu -
>
> On Fri, 27 Apr 2018, Matthieu Baerts wrote:
>
> Hello,
>>
>> Following yesterday's discussion about NetDev 0x12, here is a proposition
>> of mail to send to NetDev committee. I already put some comments. Note t=
hat
>> I have followed the submission guidelines from:
>> https://www.netdevconf.org/0x12/submit-proposal.html#proposals
>>
>> Please comment it before Monday morning. Sorry for the rush but the
>> deadline is the 1st of May :)
>>
>> * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat Martineau
>>>
>> (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and myself,
>> Matthieu Baerts (Tessares)
>>
>> I wrote down the names of people who participated in the discussion in
>> the ML and during the weekly meetings. I can add more people if more peo=
ple
>> would like to join the preparation and presentation of this tutorial.
>> @Christoph, Mat, Peter, Ossama: can I write your names there?
>>
>
> Ossama won't be able to attend. It looks like most sessions have 1 or 2
> presenters, so I don't know if 4 is too many. I'm sure they'll give us so=
me
> feedback if they want to limit the number of presenters.
>

OK thank you!
Yes indeed, I am sure they will say something if we are too many.

* Title of the submission: MPTCP: from the basic to an upstreamable base
>>>
>>
>> We certainly need a better title, please comment!
>>
>
> "Multipath TCP: Present Use Cases and an Upstream Future" ?
>

I was trying to find something that catch the attention but it is maybe not
needed for these kind of presentation.

> * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
>>
>> "hands-on" seems to be the correct one according to the Submission Types.
>> https://www.netdevconf.org/0x12/submit-proposal.html#types
>>
>
> It's a little bit of "nuts & bolts" too, but I agree that hands-on is the
> better match.
>

Thank you!

* Submission type (one of talk, presentation, workshop): tutorial,
>>>
>> instructor-led sessions (minimum 1 hour long and not to exceed 1.5 hours.
>> The instructor will go over the technology either through code review or
>> execution and interact with the attendees.)
>>
>> I guess there is a typo here: presentation should be replaced by tutorial
>> in the guidelines.
>>
>> Estimate of length of time for presentation: 1h
>>>
>>
>> That's what we agreed yesterday but I can change.
>>
>> Affiliations of submitters (needed for conflict of interest check):
>>> Apple,
>>>
>> Intel, Tessares
>>
>> Description of proposal:
>>>     A project to add an implementation of the MultiPath TCP protocol to
>>> the
>>>
>> Linux kernel is in progress by a small community. The goal of this
>> tutorial is to discover what is this TCP extension (RFC 6824), what are =
the
>> different use-cases already in production by some companies and what are
>> the challenges to upstream MPTCP. We hope having interactive discussions
>> and getting feedback from experienced developers will help us in this ta=
sk
>> of easily bringing MPTCP to all Linux users, a technology already used by
>> millions of people.
>>
>
>     In a bit more detail, we will start with a basic introduction of
>>> MPTCP.
>>>
>> A few use-cases will be presented with a demo to explain how useful this
>> protocol is in today's Internet and how it can be extended with API's li=
ke
>> Netlink and BPF.
>>
>
> I recognize how Netlink is associated with a userspace path manager, but
> what's the BPF extensibility you're referring to?
>

It was only to mention that it would be possible to extend MPTCP with eBPF.
Even if it is not already available in the current Open-Source
implementation, there is already the possibility to get a version with a
programmable scheduler: https://progmp.net

Then we will have some explanations about how MPTCP is currently
>> implemented. This current implementation is quite intrusive and that is
>> certainly not something we would like to have upstream. We would like to
>> express what we have in mind to change that, with some samples and initi=
ate
>> discussions.
>>
>
> My edit of the above:
>
> """
>
> A community project is underway to add Multipath TCP to the upstream Linux
> kernel. This tutorial will introduce the audience to this TCP extension
> (RFC 6824), show some use cases already in production, and discuss the
> challenges in converging on an upstream MPTCP implementation.
>

Should we insist on the "discussion" part? Like saying: "discuss with the
audience"? "have interactive discussions"?
It is maybe not needed but it was mainly to express the interactivity, it
is a tutorial, not just a "simple" presentation.

We will use the current MPTCP implementation to demonstrate the utility of
> the protocol on today's internet, and to show how this implementation can
> currently be extended with netlink and BPF. This not only has practical
> application for deploying MPTCP now, but also illustrates how the APIs and
> code will need to evolve in order to properly coexist with the optimized
> Linux TCP core we all rely on. We will discuss our ideas for bringing MPT=
CP
> to the upstream kernel so the technology is available to all Linux users.
>

To "attract" people, should we mention that the current implementation is
already used by millions of users?
I like how your improve the last bit :-)

"""
>
> Feel free to edit/merge/expand/discard as needed :)
>

Thank you for your edit, it is indeed cleaner!

    For more information about this project:
>>>
>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>
>
I guess I can keep this, right?

Please feel free to comment this as well. We are still far from the max 350
>> words limit we found last time. But on the other hand, I can no longer f=
ind
>> this limit on their website :)
>>
>
> Hope the above is helpful. Thanks again for your work on this proposal.
>

Yes it is, thank you for your help!

Matthieu


>
> Mat
>
>
>
>
>> Thank you for your help!
>>
>> Have a good day/evening,
>> Matthieu
>>
>> On 25/04/2018 21:58, Mat Martineau wrote:
>>
>>>
>>> Hi Matthieu -
>>>
>>> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
>>>
>>> Hello,
>>>>
>>>>
>>>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to 13th,=
 2018.
>>>>
>>>>
>>>> We already talked about this event on this ML and at our weekly
>>>> meetings but here is a summary of the discussions we had:
>>>>
>>>>  - we would like to have a presentation there mainly to get feedback
>>>> and advice from other kernel developers
>>>>  - a presentation would clearly indicate that this MPTCP Upstream
>>>> project exists and we could get help from more developers
>>>>  - we would like to indicate that having MPTCP upstream is asked by
>>>> different companies, some are even ready to contribute ; it is then
>>>> important to have MPTCP upstream
>>>>
>>>>
>>>> Also note that:
>>>>
>>>>  - David Miller will not be present in Montr=C3=A9al [1] but other main
>>>> contributors should be there (we don't have a list)
>>>>
>>>
>>> Side note, in the past day David reiterated his statement about not
>>> attending or supporting the conference:
>>>
>>> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2
>>>
>>>  - A presentation by Octavian Purdila about "MPTCP Upstreaming" has
>>>> already been given in 2015 (NetDev 0.1) [2]
>>>>  - 3 types of presentation are available: talks, tutorials and
>>>> workshops [3]
>>>>  - Call for Presentation Proposals closes on May 1st, 2018.
>>>>
>>>>
>>>> The current idea we briefly discussed during our weekly meetings is to
>>>> give a tutorial:
>>>>
>>>>  - It is not useful to give almost the same presentation as the one of
>>>> Octavian
>>>>  - It will allow us more flexibility somehow to explain what is MPTCP,
>>>> the different use-cases, why it is important to have it upstream and w=
hat
>>>> problems we are currently facing.
>>>>  - David Miller and many other kernel developers will go to LPC in
>>>> November: a good place to give a talk this time.
>>>>
>>>>
>>>> Do you have any ideas on what we could show in this tutorial?
>>>>
>>>>
>>>> I recently discussed with my colleague Olivier Bonaventure who has a
>>>> lot of experiences in giving different introductions and more about MP=
TCP
>>>> and here is what he suggests:
>>>>
>>>>  - A first part about a basic introduction of MPTCP
>>>>  - Indicate different use-cases -- if possible with a "closed demo" to
>>>> be sure it is working -- asking people to setup something is not easy =
in
>>>> 1h, max 1h30.
>>>>
>>>
>>>  From the description at [3], either "instructor-led" 60-90 minute
>>> tutorials or "student-participation" 2-3 hour sessions are possible. The
>>> closed demo maps well to their "instructor-led" category. Looking at the
>>> schedule, the past two Netdev Conferences have had one tutorial each, of
>>> 60-70 minutes. I think it helps to be closer to an hour in length to ho=
ld
>>> the audience's attention.
>>>
>>>  - Then trying to have interactive discussions or explanations about how
>>>> MPTCP is currently implemented or should be implemented if it goes
>>>> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we need =
to
>>>> support middleboxes, we need to link subflows of the same connection
>>>> together, we need a scheduler, a PM, etc.
>>>>
>>>
>>> It's difficult to predict how interactive an audience will be. I've only
>>> attended one Netdev Conference, and it seemed like there were a lot more
>>> people with expertise and interest in drivers, lower layers (XDP, BPF, =
TC,
>>> netfilter), and network topology/simulation. Discussion around middlebox
>>> support and the userspace API might have more audience interaction. If =
we
>>> want to drive a discussion, we could try to strike a balance between to=
pics
>>> for the broader audience and those with more knowledge of TCP internals.
>>> (Hopefully some TCP internals people are still planning to attend)
>>>
>>>  - Of course, we should focus our discussions on the upstreaming aspect,
>>>> e.g. reducing the footprint of MPTCP in the current TCP stack: what ar=
e we
>>>> allow to do, what not. It is linked to many previous discussions we ha=
d on
>>>> this ML, e.g. why we need more indirect function calls and how to redu=
ce
>>>> the impact, etc.
>>>>
>>>
>>> The previous talk ([2]) had a section like this. I haven't watched it
>>> recently, I should look at it again to see what kind of questions the
>>> audience was asking. As you mentioned above we should be careful to have
>>> new content compared to the previous session.
>>>
>>>  - If we have time, we could discuss about how users could interact with
>>>> MPTCP: enable it per connection, control the path manager, maybe the
>>>> scheduler, etc.
>>>>
>>>>
>>>> What do you think about this? Feel free to comment and even propose
>>>> completely different ideas!
>>>>
>>>
>>> Thank you for outlining these ideas. I see that this topic is on our
>>> meeting agenda so it will be good to discuss the tutorial there.
>>>
>>>
>>> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
>>>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>>>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
>>>>
>>>
>>>
> --
> Mat Martineau
> Intel OTC
>



-- =

[image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
<https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Louva=
in-la-Neuve,+Belgium>

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

--===============6022838450764481847==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBNYXQsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFu
ayB5b3UgZm9yIHlvdXIgcmV2aWV3IGFuZCBpbnB1dCE8YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNz
PSJnbWFpbF9leHRyYSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiBTYXQsIEFwciAy
OCwgMjAxOCBhdCAyOjQ0IEFNLCBNYXQgTWFydGluZWF1IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEg
aHJlZj0ibWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20iIHRhcmdldD0i
X2JsYW5rIj5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguaW50ZWwuY29tPC9hPiZndDs8L3NwYW4+
IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+PGJyPgpIaSBNYXR0aGlldSAtPHNwYW4gY2xhc3M9ImdtYWlsLSI+
PGJyPgo8YnI+Ck9uIEZyaSwgMjcgQXByIDIwMTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+
Cjxicj4KPC9zcGFuPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KSGVsbG8sPGJyPgo8YnI+PHNwYW4gY2xhc3M9ImdtYWlsLSI+
CkZvbGxvd2luZyB5ZXN0ZXJkYXkmIzM5O3MgZGlzY3Vzc2lvbiBhYm91dCBOZXREZXYgMHgxMiwg
aGVyZSBpcyBhIHByb3Bvc2l0aW9uIG9mIG1haWwgdG8gc2VuZCB0byBOZXREZXYgY29tbWl0dGVl
LiBJIGFscmVhZHkgcHV0IHNvbWUgY29tbWVudHMuIE5vdGUgdGhhdCBJIGhhdmUgZm9sbG93ZWQg
dGhlIHN1Ym1pc3Npb24gZ3VpZGVsaW5lcyBmcm9tOiA8YSBocmVmPSJodHRwczovL3d3dy5uZXRk
ZXZjb25mLm9yZy8weDEyL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3Byb3Bvc2FscyIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdi
cj4yL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3Byb3Bvc2E8d2JyPmxzPC9hPjxicj4KPGJyPgpQbGVh
c2UgY29tbWVudCBpdCBiZWZvcmUgTW9uZGF5IG1vcm5pbmcuIFNvcnJ5IGZvciB0aGUgcnVzaCBi
dXQgdGhlIGRlYWRsaW5lIGlzIHRoZSAxc3Qgb2YgTWF5IDopPGJyPgo8YnI+CjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KKiBO
YW1lKHMpIG9mIHRoZSBzdWJtaXR0ZXIocyk6IENocmlzdG9waCBQYWFzY2ggKEFwcGxlKSwgTWF0
IE1hcnRpbmVhdSA8YnI+CjwvYmxvY2txdW90ZT4KKEludGVsKSwgUGV0ZXIgS3J5c3RhZCAoSW50
ZWwpLCBPc3NhbWEgT3RobWFuIChJbnRlbCkgYW5kIG15c2VsZiwgTWF0dGhpZXUgQmFlcnRzIChU
ZXNzYXJlcyk8YnI+Cjxicj4KSSB3cm90ZSBkb3duIHRoZSBuYW1lcyBvZiBwZW9wbGUgd2hvIHBh
cnRpY2lwYXRlZCBpbiB0aGUgZGlzY3Vzc2lvbiBpbiB0aGUgTUwgYW5kIGR1cmluZyB0aGUgd2Vl
a2x5IG1lZXRpbmdzLiBJIGNhbiBhZGQgbW9yZSBwZW9wbGUgaWYgbW9yZSBwZW9wbGUgd291bGQg
bGlrZSB0byBqb2luIHRoZSBwcmVwYXJhdGlvbiBhbmQgcHJlc2VudGF0aW9uIG9mIHRoaXMgdHV0
b3JpYWwuPGJyPgpAQ2hyaXN0b3BoLCBNYXQsIFBldGVyLCBPc3NhbWE6IGNhbiBJIHdyaXRlIHlv
dXIgbmFtZXMgdGhlcmU/PGJyPgo8L3NwYW4+PC9ibG9ja3F1b3RlPgo8YnI+Ck9zc2FtYSB3b24m
IzM5O3QgYmUgYWJsZSB0byBhdHRlbmQuIEl0IGxvb2tzIGxpa2UgbW9zdCBzZXNzaW9ucyBoYXZl
IDEgb3IgMiBwcmVzZW50ZXJzLCBzbyBJIGRvbiYjMzk7dCBrbm93IGlmIDQgaXMgdG9vIG1hbnku
IEkmIzM5O20gc3VyZSB0aGV5JiMzOTtsbCBnaXZlIHVzIHNvbWUgZmVlZGJhY2sgaWYgdGhleSB3
YW50IHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgcHJlc2VudGVycy48c3BhbiBjbGFzcz0iZ21haWwt
Ij48YnI+PC9zcGFuPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9LIHRoYW5rIHlv
dSE8L2Rpdj48ZGl2PlllcyBpbmRlZWQsIEkgYW0gc3VyZSB0aGV5IHdpbGwgc2F5IHNvbWV0aGlu
ZyBpZiB3ZSBhcmUgdG9vIG1hbnkuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48c3Bh
biBjbGFzcz0iZ21haWwtIj4KCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQg
cmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KKiBUaXRsZSBvZiB0aGUgc3VibWlz
c2lvbjogTVBUQ1A6IGZyb20gdGhlIGJhc2ljIHRvIGFuIHVwc3RyZWFtYWJsZSBiYXNlPGJyPgo8
L2Jsb2NrcXVvdGU+Cjxicj4KV2UgY2VydGFpbmx5IG5lZWQgYSBiZXR0ZXIgdGl0bGUsIHBsZWFz
ZSBjb21tZW50ITxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgomcXVvdDtNdWx0aXBhdGgg
VENQOiBQcmVzZW50IFVzZSBDYXNlcyBhbmQgYW4gVXBzdHJlYW0gRnV0dXJlJnF1b3Q7ID88c3Bh
biBjbGFzcz0iZ21haWwtIj48YnI+PC9zcGFuPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48
ZGl2Pkkgd2FzIHRyeWluZyB0byBmaW5kIHNvbWV0aGluZyB0aGF0IGNhdGNoIHRoZSBhdHRlbnRp
b24gYnV0IGl0IGlzIG1heWJlIG5vdCBuZWVkZWQgZm9yIHRoZXNlIGtpbmQgb2YgcHJlc2VudGF0
aW9uLjwvZGl2PjxkaXY+IDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJn
YigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9ImdtYWlsLSI+Cgo8
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+CgomZ3Q7ICogTGFiZWwgKG9uZSBvZiBtb29uc2hvdCwgbnV0cyYjMzk7biBib2x0cywg
aGFuZHMtb24pOiBoYW5kcy1vbjxicj4KPGJyPgomcXVvdDtoYW5kcy1vbiZxdW90OyBzZWVtcyB0
byBiZSB0aGUgY29ycmVjdCBvbmUgYWNjb3JkaW5nIHRvIHRoZSBTdWJtaXNzaW9uIFR5cGVzLjxi
cj4KPGEgaHJlZj0iaHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9z
YWwuaHRtbCN0eXBlcyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93
d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdicj4yL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3R5cGVzPC9h
Pjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpJdCYjMzk7cyBhIGxpdHRsZSBiaXQgb2Yg
JnF1b3Q7bnV0cyAmYW1wOyBib2x0cyZxdW90OyB0b28sIGJ1dCBJIGFncmVlIHRoYXQgaGFuZHMt
b24gaXMgdGhlIGJldHRlciBtYXRjaC48c3BhbiBjbGFzcz0iZ21haWwtIj48YnI+PC9zcGFuPjwv
YmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSE8YnI+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBw
eCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3Bh
ZGRpbmctbGVmdDoxZXgiPjxzcGFuIGNsYXNzPSJnbWFpbC0iPgo8YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cgo8YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Ciog
U3VibWlzc2lvbiB0eXBlIChvbmUgb2YgdGFsaywgcHJlc2VudGF0aW9uLCB3b3Jrc2hvcCk6IHR1
dG9yaWFsLCA8YnI+CjwvYmxvY2txdW90ZT4KaW5zdHJ1Y3Rvci1sZWQgc2Vzc2lvbnMgKG1pbmlt
dW0gMSBob3VyIGxvbmcgYW5kIG5vdCB0byBleGNlZWQgMS41IGhvdXJzLiBUaGUgaW5zdHJ1Y3Rv
ciB3aWxsIGdvIG92ZXIgdGhlIHRlY2hub2xvZ3kgZWl0aGVyIHRocm91Z2ggY29kZSByZXZpZXcg
b3IgZXhlY3V0aW9uIGFuZCBpbnRlcmFjdCB3aXRoIHRoZSBhdHRlbmRlZXMuKTxicj4KPGJyPgpJ
IGd1ZXNzIHRoZXJlIGlzIGEgdHlwbyBoZXJlOiBwcmVzZW50YXRpb24gc2hvdWxkIGJlIHJlcGxh
Y2VkIGJ5IHR1dG9yaWFsIGluIHRoZSBndWlkZWxpbmVzLjxicj4KPGJyPgo8YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CkVzdGlt
YXRlIG9mIGxlbmd0aCBvZiB0aW1lIGZvciBwcmVzZW50YXRpb246IDFoPGJyPgo8L2Jsb2NrcXVv
dGU+Cjxicj4KVGhhdCYjMzk7cyB3aGF0IHdlIGFncmVlZCB5ZXN0ZXJkYXkgYnV0IEkgY2FuIGNo
YW5nZS48YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPgpBZmZpbGlhdGlvbnMgb2Ygc3VibWl0dGVycyAobmVlZGVk
IGZvciBjb25mbGljdCBvZiBpbnRlcmVzdCBjaGVjayk6IEFwcGxlLCA8YnI+CjwvYmxvY2txdW90
ZT4KSW50ZWwsIFRlc3NhcmVzPGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90
ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQg
cmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KRGVzY3JpcHRpb24gb2YgcHJvcG9z
YWw6PGJyPgrCoCDCoCBBIHByb2plY3QgdG8gYWRkIGFuIGltcGxlbWVudGF0aW9uIG9mIHRoZSBN
dWx0aVBhdGggVENQIHByb3RvY29sIHRvIHRoZSA8YnI+CjwvYmxvY2txdW90ZT4KTGludXgga2Vy
bmVsIGlzIGluIHByb2dyZXNzIGJ5IGEgc21hbGwgY29tbXVuaXR5LiBUaGUgZ29hbCBvZiB0aGlz
IHR1dG9yaWFsIGlzIHRvIGRpc2NvdmVyIHdoYXQgaXMgdGhpcyBUQ1AgZXh0ZW5zaW9uIChSRkMg
NjgyNCksIHdoYXQgYXJlIHRoZSBkaWZmZXJlbnQgdXNlLWNhc2VzIGFscmVhZHkgaW4gcHJvZHVj
dGlvbiBieSBzb21lIGNvbXBhbmllcyBhbmQgd2hhdCBhcmUgdGhlIGNoYWxsZW5nZXMgdG8gdXBz
dHJlYW0gTVBUQ1AuIFdlIGhvcGUgaGF2aW5nIGludGVyYWN0aXZlIGRpc2N1c3Npb25zIGFuZCBn
ZXR0aW5nIGZlZWRiYWNrIGZyb20gZXhwZXJpZW5jZWQgZGV2ZWxvcGVycyB3aWxsIGhlbHAgdXMg
aW4gdGhpcyB0YXNrIG9mIGVhc2lseSBicmluZ2luZyBNUFRDUCB0byBhbGwgTGludXggdXNlcnMs
IGEgdGVjaG5vbG9neSBhbHJlYWR5IHVzZWQgYnkgbWlsbGlvbnMgb2YgcGVvcGxlLjxicj4KPC9i
bG9ja3F1b3RlPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQs
MjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CsKgIMKgIEluIGEgYml0IG1vcmUgZGV0YWls
LCB3ZSB3aWxsIHN0YXJ0IHdpdGggYSBiYXNpYyBpbnRyb2R1Y3Rpb24gb2YgTVBUQ1AuIDxicj4K
PC9ibG9ja3F1b3RlPgpBIGZldyB1c2UtY2FzZXMgd2lsbCBiZSBwcmVzZW50ZWQgd2l0aCBhIGRl
bW8gdG8gZXhwbGFpbiBob3cgdXNlZnVsIHRoaXMgcHJvdG9jb2wgaXMgaW4gdG9kYXkmIzM5O3Mg
SW50ZXJuZXQgYW5kIGhvdyBpdCBjYW4gYmUgZXh0ZW5kZWQgd2l0aCBBUEkmIzM5O3MgbGlrZSBO
ZXRsaW5rIGFuZCBCUEYuPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+CkkgcmVjb2duaXpl
IGhvdyBOZXRsaW5rIGlzIGFzc29jaWF0ZWQgd2l0aCBhIHVzZXJzcGFjZSBwYXRoIG1hbmFnZXIs
IGJ1dCB3aGF0JiMzOTtzIHRoZSBCUEYgZXh0ZW5zaWJpbGl0eSB5b3UmIzM5O3JlIHJlZmVycmlu
ZyB0bz88c3BhbiBjbGFzcz0iZ21haWwtIj48YnI+PC9zcGFuPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pkl0IHdhcyBvbmx5IHRvIG1lbnRpb24gdGhhdCBpdCB3b3VsZCBiZSBwb3Nz
aWJsZSB0byBleHRlbmQgTVBUQ1Agd2l0aCBlQlBGLjwvZGl2PjxkaXY+RXZlbiBpZiBpdCBpcyBu
b3QgYWxyZWFkeSBhdmFpbGFibGUgaW4gdGhlIGN1cnJlbnQgT3Blbi1Tb3VyY2UgaW1wbGVtZW50
YXRpb24sIHRoZXJlIGlzIGFscmVhZHkgdGhlIHBvc3NpYmlsaXR5IHRvIGdldCBhIHZlcnNpb24g
d2l0aCBhICBwcm9ncmFtbWFibGUgc2NoZWR1bGVyOiA8YSBocmVmPSJodHRwczovL3Byb2dtcC5u
ZXQiPmh0dHBzOi8vcHJvZ21wLm5ldDwvYT48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2Nr
cXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgi
PjxzcGFuIGNsYXNzPSJnbWFpbC0iPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpUaGVuIHdlIHdpbGwgaGF2ZSBzb21lIGV4
cGxhbmF0aW9ucyBhYm91dCBob3cgTVBUQ1AgaXMgY3VycmVudGx5IGltcGxlbWVudGVkLiBUaGlz
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXMgcXVpdGUgaW50cnVzaXZlIGFuZCB0aGF0IGlzIGNl
cnRhaW5seSBub3Qgc29tZXRoaW5nIHdlIHdvdWxkIGxpa2UgdG8gaGF2ZSB1cHN0cmVhbS4gV2Ug
d291bGQgbGlrZSB0byBleHByZXNzIHdoYXQgd2UgaGF2ZSBpbiBtaW5kIHRvIGNoYW5nZSB0aGF0
LCB3aXRoIHNvbWUgc2FtcGxlcyBhbmQgaW5pdGlhdGUgZGlzY3Vzc2lvbnMuPGJyPgo8L2Jsb2Nr
cXVvdGU+Cjxicj48L3NwYW4+Ck15IGVkaXQgb2YgdGhlIGFib3ZlOjxicj4KPGJyPgomcXVvdDsm
cXVvdDsmcXVvdDs8YnI+Cjxicj4KQSBjb21tdW5pdHkgcHJvamVjdCBpcyB1bmRlcndheSB0byBh
ZGQgTXVsdGlwYXRoIFRDUCB0byB0aGUgdXBzdHJlYW0gTGludXgga2VybmVsLiBUaGlzIHR1dG9y
aWFsIHdpbGwgaW50cm9kdWNlIHRoZSBhdWRpZW5jZSB0byB0aGlzIFRDUCBleHRlbnNpb24gKFJG
QyA2ODI0KSwgc2hvdyBzb21lIHVzZSBjYXNlcyBhbHJlYWR5IGluIHByb2R1Y3Rpb24sIGFuZCBk
aXNjdXNzIHRoZSBjaGFsbGVuZ2VzIGluIGNvbnZlcmdpbmcgb24gYW4gdXBzdHJlYW0gTVBUQ1Ag
aW1wbGVtZW50YXRpb24uPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlNob3Vs
ZCB3ZSBpbnNpc3Qgb24gdGhlICZxdW90O2Rpc2N1c3Npb24mcXVvdDsgcGFydD8gTGlrZSBzYXlp
bmc6ICZxdW90O2Rpc2N1c3Mgd2l0aCB0aGUgYXVkaWVuY2UmcXVvdDs/ICZxdW90O2hhdmUgaW50
ZXJhY3RpdmUgZGlzY3Vzc2lvbnMmcXVvdDs/PC9kaXY+PGRpdj5JdCBpcyBtYXliZSBub3QgbmVl
ZGVkIGJ1dCBpdCB3YXMgbWFpbmx5IHRvIGV4cHJlc3MgdGhlIGludGVyYWN0aXZpdHksIGl0IGlz
IGEgdHV0b3JpYWwsIG5vdCBqdXN0IGEgJnF1b3Q7c2ltcGxlJnF1b3Q7IHByZXNlbnRhdGlvbi48
YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgoKV2Ugd2lsbCB1c2UgdGhlIGN1cnJlbnQg
TVBUQ1AgaW1wbGVtZW50YXRpb24gdG8gZGVtb25zdHJhdGUgdGhlIHV0aWxpdHkgb2YgdGhlIHBy
b3RvY29sIG9uIHRvZGF5JiMzOTtzIGludGVybmV0LCBhbmQgdG8gc2hvdyBob3cgdGhpcyBpbXBs
ZW1lbnRhdGlvbiBjYW4gY3VycmVudGx5IGJlIGV4dGVuZGVkIHdpdGggbmV0bGluayBhbmQgQlBG
LiBUaGlzIG5vdCBvbmx5IGhhcyBwcmFjdGljYWwgYXBwbGljYXRpb24gZm9yIGRlcGxveWluZyBN
UFRDUCBub3csIGJ1dCBhbHNvIGlsbHVzdHJhdGVzIGhvdyB0aGUgQVBJcyBhbmQgY29kZSB3aWxs
IG5lZWQgdG8gZXZvbHZlIGluIG9yZGVyIHRvIHByb3Blcmx5IGNvZXhpc3Qgd2l0aCB0aGUgb3B0
aW1pemVkIExpbnV4IFRDUCBjb3JlIHdlIGFsbCByZWx5IG9uLiBXZSB3aWxsIGRpc2N1c3Mgb3Vy
IGlkZWFzIGZvciBicmluZ2luZyBNUFRDUCB0byB0aGUgdXBzdHJlYW0ga2VybmVsIHNvIHRoZSB0
ZWNobm9sb2d5IGlzIGF2YWlsYWJsZSB0byBhbGwgTGludXggdXNlcnMuPGJyPjwvYmxvY2txdW90
ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRvICZxdW90O2F0dHJhY3QmcXVvdDsgcGVvcGxlLCBzaG91
bGQgd2UgbWVudGlvbiB0aGF0IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGFscmVhZHkg
dXNlZCBieSBtaWxsaW9ucyBvZiB1c2Vycz88L2Rpdj48ZGl2PkkgbGlrZSBob3cgeW91ciBpbXBy
b3ZlIHRoZSBsYXN0IGJpdCA6LSk8YnI+PC9kaXY+PGRpdj4gPGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KCiZx
dW90OyZxdW90OyZxdW90Ozxicj4KPGJyPgpGZWVsIGZyZWUgdG8gZWRpdC9tZXJnZS9leHBhbmQv
ZGlzY2FyZCBhcyBuZWVkZWQgOik8c3BhbiBjbGFzcz0iZ21haWwtIj48YnI+PC9zcGFuPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSBmb3IgeW91ciBlZGl0LCBpdCBp
cyBpbmRlZWQgY2xlYW5lciE8L2Rpdj48ZGl2PiA8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxzcGFuIGNsYXNz
PSJnbWFpbC0iPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQp
O3BhZGRpbmctbGVmdDoxZXgiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KwqAgwqAgRm9yIG1vcmUgaW5mb3JtYXRpb24gYWJv
dXQgdGhpcyBwcm9qZWN0OiA8YnI+CjwvYmxvY2txdW90ZT4KPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQvd2lraSIgcmVsPSJub3JlZmVycmVy
IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10PHdicj5jcC9t
cHRjcF9uZXQtbmV4dC93aWtpPC9hPjwvYmxvY2txdW90ZT48L3NwYW4+PC9ibG9ja3F1b3RlPjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBndWVzcyBJIGNhbiBrZWVwIHRoaXMsIHJpZ2h0PzwvZGl2Pjxk
aXY+IDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9ImdtYWlsLSI+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1s
ZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpQbGVhc2Ug
ZmVlbCBmcmVlIHRvIGNvbW1lbnQgdGhpcyBhcyB3ZWxsLiBXZSBhcmUgc3RpbGwgZmFyIGZyb20g
dGhlIG1heCAzNTAgd29yZHMgbGltaXQgd2UgZm91bmQgbGFzdCB0aW1lLiBCdXQgb24gdGhlIG90
aGVyIGhhbmQsIEkgY2FuIG5vIGxvbmdlciBmaW5kIHRoaXMgbGltaXQgb24gdGhlaXIgd2Vic2l0
ZSA6KTxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpIb3BlIHRoZSBhYm92ZSBpcyBoZWxw
ZnVsLiBUaGFua3MgYWdhaW4gZm9yIHlvdXIgd29yayBvbiB0aGlzIHByb3Bvc2FsLjxzcGFuIGNs
YXNzPSJnbWFpbC1IT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+PC9mb250Pjwvc3Bh
bj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5ZZXMgaXQgaXMsIHRoYW5rIHlvdSBm
b3IgeW91ciBoZWxwITwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TWF0dGhpZXU8L2Rpdj48ZGl2
Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9ImdtYWlsLUhPRW5aYiI+PGZvbnQgY29sb3I9
IiM4ODg4ODgiPgo8YnI+Cjxicj4KTWF0PC9mb250Pjwvc3Bhbj48ZGl2IGNsYXNzPSJnbWFpbC1I
T0VuWmIiPjxkaXYgY2xhc3M9ImdtYWlsLWg1Ij48YnI+Cjxicj4KPGJyPgo8YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4K
VGhhbmsgeW91IGZvciB5b3VyIGhlbHAhPGJyPgo8YnI+CkhhdmUgYSBnb29kIGRheS9ldmVuaW5n
LDxicj4KTWF0dGhpZXU8YnI+Cjxicj4KT24gMjUvMDQvMjAxOCAyMTo1OCwgTWF0IE1hcnRpbmVh
dSB3cm90ZTo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KPGJyPgpIaSBNYXR0aGlldSAtPGJyPgo8YnI+Ck9uIEZyaSwg
MjAgQXByIDIwMTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+Cjxicj4KPGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpIZWxs
byw8YnI+Cjxicj4KPGJyPgpOZXREZXYgMHgxMiBpcyBjb21pbmcgdG8gTW9udHLDqWFsIHRoaXMg
c3VtbWVyOiBKdWx5IDExdGggdG8gMTN0aCwgMjAxOC48YnI+Cjxicj4KPGJyPgpXZSBhbHJlYWR5
IHRhbGtlZCBhYm91dCB0aGlzIGV2ZW50IG9uIHRoaXMgTUwgYW5kIGF0IG91ciB3ZWVrbHkgbWVl
dGluZ3MgYnV0IGhlcmUgaXMgYSBzdW1tYXJ5IG9mIHRoZSBkaXNjdXNzaW9ucyB3ZSBoYWQ6PGJy
Pgo8YnI+CsKgLSB3ZSB3b3VsZCBsaWtlIHRvIGhhdmUgYSBwcmVzZW50YXRpb24gdGhlcmUgbWFp
bmx5IHRvIGdldCBmZWVkYmFjayBhbmQgYWR2aWNlIGZyb20gb3RoZXIga2VybmVsIGRldmVsb3Bl
cnM8YnI+CsKgLSBhIHByZXNlbnRhdGlvbiB3b3VsZCBjbGVhcmx5IGluZGljYXRlIHRoYXQgdGhp
cyBNUFRDUCBVcHN0cmVhbSBwcm9qZWN0IGV4aXN0cyBhbmQgd2UgY291bGQgZ2V0IGhlbHAgZnJv
bSBtb3JlIGRldmVsb3BlcnM8YnI+CsKgLSB3ZSB3b3VsZCBsaWtlIHRvIGluZGljYXRlIHRoYXQg
aGF2aW5nIE1QVENQIHVwc3RyZWFtIGlzIGFza2VkIGJ5IGRpZmZlcmVudCBjb21wYW5pZXMsIHNv
bWUgYXJlIGV2ZW4gcmVhZHkgdG8gY29udHJpYnV0ZSA7IGl0IGlzIHRoZW4gaW1wb3J0YW50IHRv
IGhhdmUgTVBUQ1AgdXBzdHJlYW08YnI+Cjxicj4KPGJyPgpBbHNvIG5vdGUgdGhhdDo8YnI+Cjxi
cj4KwqAtIERhdmlkIE1pbGxlciB3aWxsIG5vdCBiZSBwcmVzZW50IGluIE1vbnRyw6lhbCBbMV0g
YnV0IG90aGVyIG1haW4gY29udHJpYnV0b3JzIHNob3VsZCBiZSB0aGVyZSAod2UgZG9uJiMzOTt0
IGhhdmUgYSBsaXN0KTxicj4KPC9ibG9ja3F1b3RlPgo8YnI+ClNpZGUgbm90ZSwgaW4gdGhlIHBh
c3QgZGF5IERhdmlkIHJlaXRlcmF0ZWQgaGlzIHN0YXRlbWVudCBhYm91dCBub3QgYXR0ZW5kaW5n
IG9yIHN1cHBvcnRpbmcgdGhlIGNvbmZlcmVuY2U6PGJyPgo8YnI+CjxhIGhyZWY9Imh0dHBzOi8v
bWFyYy5pbmZvLz9sPWxpbnV4LW5ldGRldiZhbXA7bT0xNTI0NjY4MjcyMDMzMDEmYW1wO3c9MiIg
cmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9tYXJjLmluZm8vP2w9bGlu
dXgtbmV0PHdicj5kZXYmYW1wO209MTUyNDY2ODI3MjAzMzAxJmFtcDt3PTI8L2E+PGJyPgo8YnI+
CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KwqAtIEEgcHJlc2VudGF0aW9uIGJ5IE9jdGF2aWFuIFB1cmRpbGEgYWJvdXQgJnF1
b3Q7TVBUQ1AgVXBzdHJlYW1pbmcmcXVvdDsgaGFzIGFscmVhZHkgYmVlbiBnaXZlbiBpbiAyMDE1
IChOZXREZXYgMC4xKSBbMl08YnI+CsKgLSAzIHR5cGVzIG9mIHByZXNlbnRhdGlvbiBhcmUgYXZh
aWxhYmxlOiB0YWxrcywgdHV0b3JpYWxzIGFuZCB3b3Jrc2hvcHMgWzNdPGJyPgrCoC0gQ2FsbCBm
b3IgUHJlc2VudGF0aW9uIFByb3Bvc2FscyBjbG9zZXMgb24gTWF5IDFzdCwgMjAxOC48YnI+Cjxi
cj4KPGJyPgpUaGUgY3VycmVudCBpZGVhIHdlIGJyaWVmbHkgZGlzY3Vzc2VkIGR1cmluZyBvdXIg
d2Vla2x5IG1lZXRpbmdzIGlzIHRvIGdpdmUgYSB0dXRvcmlhbDo8YnI+Cjxicj4KwqAtIEl0IGlz
IG5vdCB1c2VmdWwgdG8gZ2l2ZSBhbG1vc3QgdGhlIHNhbWUgcHJlc2VudGF0aW9uIGFzIHRoZSBv
bmUgb2YgT2N0YXZpYW48YnI+CsKgLSBJdCB3aWxsIGFsbG93IHVzIG1vcmUgZmxleGliaWxpdHkg
c29tZWhvdyB0byBleHBsYWluIHdoYXQgaXMgTVBUQ1AsIHRoZSBkaWZmZXJlbnQgdXNlLWNhc2Vz
LCB3aHkgaXQgaXMgaW1wb3J0YW50IHRvIGhhdmUgaXQgdXBzdHJlYW0gYW5kIHdoYXQgcHJvYmxl
bXMgd2UgYXJlIGN1cnJlbnRseSBmYWNpbmcuPGJyPgrCoC0gRGF2aWQgTWlsbGVyIGFuZCBtYW55
IG90aGVyIGtlcm5lbCBkZXZlbG9wZXJzIHdpbGwgZ28gdG8gTFBDIGluIE5vdmVtYmVyOiBhIGdv
b2QgcGxhY2UgdG8gZ2l2ZSBhIHRhbGsgdGhpcyB0aW1lLjxicj4KPGJyPgo8YnI+CkRvIHlvdSBo
YXZlIGFueSBpZGVhcyBvbiB3aGF0IHdlIGNvdWxkIHNob3cgaW4gdGhpcyB0dXRvcmlhbD88YnI+
Cjxicj4KPGJyPgpJIHJlY2VudGx5IGRpc2N1c3NlZCB3aXRoIG15IGNvbGxlYWd1ZSBPbGl2aWVy
IEJvbmF2ZW50dXJlIHdobyBoYXMgYSBsb3Qgb2YgZXhwZXJpZW5jZXMgaW4gZ2l2aW5nIGRpZmZl
cmVudCBpbnRyb2R1Y3Rpb25zIGFuZCBtb3JlIGFib3V0IE1QVENQIGFuZCBoZXJlIGlzIHdoYXQg
aGUgc3VnZ2VzdHM6PGJyPgo8YnI+CsKgLSBBIGZpcnN0IHBhcnQgYWJvdXQgYSBiYXNpYyBpbnRy
b2R1Y3Rpb24gb2YgTVBUQ1A8YnI+CsKgLSBJbmRpY2F0ZSBkaWZmZXJlbnQgdXNlLWNhc2VzIC0t
IGlmIHBvc3NpYmxlIHdpdGggYSAmcXVvdDtjbG9zZWQgZGVtbyZxdW90OyB0byBiZSBzdXJlIGl0
IGlzIHdvcmtpbmcgLS0gYXNraW5nIHBlb3BsZSB0byBzZXR1cCBzb21ldGhpbmcgaXMgbm90IGVh
c3kgaW4gMWgsIG1heCAxaDMwLjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+CsKgRnJvbSB0aGUgZGVz
Y3JpcHRpb24gYXQgWzNdLCBlaXRoZXIgJnF1b3Q7aW5zdHJ1Y3Rvci1sZWQmcXVvdDsgNjAtOTAg
bWludXRlIHR1dG9yaWFscyBvciAmcXVvdDtzdHVkZW50LXBhcnRpY2lwYXRpb24mcXVvdDsgMi0z
IGhvdXIgc2Vzc2lvbnMgYXJlIHBvc3NpYmxlLiBUaGUgY2xvc2VkIGRlbW8gbWFwcyB3ZWxsIHRv
IHRoZWlyICZxdW90O2luc3RydWN0b3ItbGVkJnF1b3Q7IGNhdGVnb3J5LiBMb29raW5nIGF0IHRo
ZSBzY2hlZHVsZSwgdGhlIHBhc3QgdHdvIE5ldGRldiBDb25mZXJlbmNlcyBoYXZlIGhhZCBvbmUg
dHV0b3JpYWwgZWFjaCwgb2YgNjAtNzAgbWludXRlcy4gSSB0aGluayBpdCBoZWxwcyB0byBiZSBj
bG9zZXIgdG8gYW4gaG91ciBpbiBsZW5ndGggdG8gaG9sZCB0aGUgYXVkaWVuY2UmIzM5O3MgYXR0
ZW50aW9uLjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CsKgLSBUaGVuIHRyeWluZyB0byBoYXZlIGludGVyYWN0
aXZlIGRpc2N1c3Npb25zIG9yIGV4cGxhbmF0aW9ucyBhYm91dCBob3cgTVBUQ1AgaXMgY3VycmVu
dGx5IGltcGxlbWVudGVkIG9yIHNob3VsZCBiZSBpbXBsZW1lbnRlZCBpZiBpdCBnb2VzIHVwc3Ry
ZWFtLCBlLmcuOiBmb3IgTVBUQ1AsIHdlIG5lZWQgdG8gaGF2ZSBleHRyYSBUQ1AgT3B0aW9ucywg
d2UgbmVlZCB0byBzdXBwb3J0IG1pZGRsZWJveGVzLCB3ZSBuZWVkIHRvIGxpbmsgc3ViZmxvd3Mg
b2YgdGhlIHNhbWUgY29ubmVjdGlvbiB0b2dldGhlciwgd2UgbmVlZCBhIHNjaGVkdWxlciwgYSBQ
TSwgZXRjLjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+Ckl0JiMzOTtzIGRpZmZpY3VsdCB0byBwcmVk
aWN0IGhvdyBpbnRlcmFjdGl2ZSBhbiBhdWRpZW5jZSB3aWxsIGJlLiBJJiMzOTt2ZSBvbmx5IGF0
dGVuZGVkIG9uZSBOZXRkZXYgQ29uZmVyZW5jZSwgYW5kIGl0IHNlZW1lZCBsaWtlIHRoZXJlIHdl
cmUgYSBsb3QgbW9yZSBwZW9wbGUgd2l0aCBleHBlcnRpc2UgYW5kIGludGVyZXN0IGluIGRyaXZl
cnMsIGxvd2VyIGxheWVycyAoWERQLCBCUEYsIFRDLCBuZXRmaWx0ZXIpLCBhbmQgbmV0d29yayB0
b3BvbG9neS9zaW11bGF0aW9uLiBEaXNjdXNzaW9uIGFyb3VuZCBtaWRkbGVib3ggc3VwcG9ydCBh
bmQgdGhlIHVzZXJzcGFjZSBBUEkgbWlnaHQgaGF2ZSBtb3JlIGF1ZGllbmNlIGludGVyYWN0aW9u
LiBJZiB3ZSB3YW50IHRvIGRyaXZlIGEgZGlzY3Vzc2lvbiwgd2UgY291bGQgdHJ5IHRvIHN0cmlr
ZSBhIGJhbGFuY2UgYmV0d2VlbiB0b3BpY3MgZm9yIHRoZSBicm9hZGVyIGF1ZGllbmNlIGFuZCB0
aG9zZSB3aXRoIG1vcmUga25vd2xlZGdlIG9mIFRDUCBpbnRlcm5hbHMuIChIb3BlZnVsbHkgc29t
ZSBUQ1AgaW50ZXJuYWxzIHBlb3BsZSBhcmUgc3RpbGwgcGxhbm5pbmcgdG8gYXR0ZW5kKTxicj4K
PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+CsKgLSBPZiBjb3Vyc2UsIHdlIHNob3VsZCBmb2N1cyBvdXIgZGlzY3Vzc2lv
bnMgb24gdGhlIHVwc3RyZWFtaW5nIGFzcGVjdCwgZS5nLiByZWR1Y2luZyB0aGUgZm9vdHByaW50
IG9mIE1QVENQIGluIHRoZSBjdXJyZW50IFRDUCBzdGFjazogd2hhdCBhcmUgd2UgYWxsb3cgdG8g
ZG8sIHdoYXQgbm90LiBJdCBpcyBsaW5rZWQgdG8gbWFueSBwcmV2aW91cyBkaXNjdXNzaW9ucyB3
ZSBoYWQgb24gdGhpcyBNTCwgZS5nLiB3aHkgd2UgbmVlZCBtb3JlIGluZGlyZWN0IGZ1bmN0aW9u
IGNhbGxzIGFuZCBob3cgdG8gcmVkdWNlIHRoZSBpbXBhY3QsIGV0Yy48YnI+CjwvYmxvY2txdW90
ZT4KPGJyPgpUaGUgcHJldmlvdXMgdGFsayAoWzJdKSBoYWQgYSBzZWN0aW9uIGxpa2UgdGhpcy4g
SSBoYXZlbiYjMzk7dCB3YXRjaGVkIGl0IHJlY2VudGx5LCBJIHNob3VsZCBsb29rIGF0IGl0IGFn
YWluIHRvIHNlZSB3aGF0IGtpbmQgb2YgcXVlc3Rpb25zIHRoZSBhdWRpZW5jZSB3YXMgYXNraW5n
LiBBcyB5b3UgbWVudGlvbmVkIGFib3ZlIHdlIHNob3VsZCBiZSBjYXJlZnVsIHRvIGhhdmUgbmV3
IGNvbnRlbnQgY29tcGFyZWQgdG8gdGhlIHByZXZpb3VzIHNlc3Npb24uPGJyPgo8YnI+CjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij4KwqAtIElmIHdlIGhhdmUgdGltZSwgd2UgY291bGQgZGlzY3VzcyBhYm91dCBob3cgdXNlcnMg
Y291bGQgaW50ZXJhY3Qgd2l0aCBNUFRDUDogZW5hYmxlIGl0IHBlciBjb25uZWN0aW9uLCBjb250
cm9sIHRoZSBwYXRoIG1hbmFnZXIsIG1heWJlIHRoZSBzY2hlZHVsZXIsIGV0Yy48YnI+Cjxicj4K
PGJyPgpXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGlzPyBGZWVsIGZyZWUgdG8gY29tbWVudCBh
bmQgZXZlbiBwcm9wb3NlIGNvbXBsZXRlbHkgZGlmZmVyZW50IGlkZWFzITxicj4KPC9ibG9ja3F1
b3RlPgo8YnI+ClRoYW5rIHlvdSBmb3Igb3V0bGluaW5nIHRoZXNlIGlkZWFzLiBJIHNlZSB0aGF0
IHRoaXMgdG9waWMgaXMgb24gb3VyIG1lZXRpbmcgYWdlbmRhIHNvIGl0IHdpbGwgYmUgZ29vZCB0
byBkaXNjdXNzIHRoZSB0dXRvcmlhbCB0aGVyZS48YnI+Cjxicj4KPGJyPgo8YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+ClsxXSA8
YSBocmVmPSJodHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWwvbXB0Y3AvMjAxOC1NYXJjaC8w
MDAzNzkuaHRtbCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0
cy4wMS5vcmcvcGlwZXJtYWlsPHdicj4vbXB0Y3AvMjAxOC1NYXJjaC8wMDAzNzkuaHRtbDwvYT48
YnI+ClsyXSA8YSBocmVmPSJodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PXdmdHoyY1U1
U1pzIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy55b3V0dWJl
LmNvbS93YXRjaD88d2JyPnY9d2Z0ejJjVTVTWnM8L2E+PGJyPgpbM10gPGEgaHJlZj0iaHR0cHM6
Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdi
cj4yL3N1Ym1pdC1wcm9wb3NhbC5odG1sPC9hPjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+CjwvYmxv
Y2txdW90ZT48L2Jsb2NrcXVvdGU+Cjxicj4KLS08YnI+Ck1hdCBNYXJ0aW5lYXU8YnI+CkludGVs
IE9UQzwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PGJyIGNsZWFyPSJhbGwiPjxi
cj4tLSA8YnI+PGRpdiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48ZGl2
PjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PHRhYmxlIHN0eWxlPSJmb250LWZh
bWlseTomcXVvdDtUaW1lcyBOZXcgUm9tYW4mcXVvdDs7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO3Rl
eHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3dvcmQtc3BhY2luZzowcHgiIHdpZHRo
PSIxMDAlIiBib3JkZXI9IjAiPjx0Ym9keT48dHI+PHRkIHJvd3NwYW49IjMiIHN0eWxlPSJwYWRk
aW5nLWxlZnQ6NXB4O3BhZGRpbmctcmlnaHQ6NXB4IiB3aWR0aD0iMTAiIHZhbGlnbj0idG9wIiBh
bGlnbj0ibGVmdCI+PGEgaHJlZj0iaHR0cDovL3d3dy50ZXNzYXJlcy5uZXQiIHRhcmdldD0iX2Js
YW5rIj48aW1nIHNyYz0iaHR0cDovL3d3dy50ZXNzYXJlcy5uZXQvc2lnbG9nby5wbmciIGFsdD0i
VGVzc2FyZXMgU0EiIHdpZHRoPSI4MCIgaGVpZ2h0PSI4MCIgYm9yZGVyPSIwIj48L2E+PC90ZD48
dGQgc3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNl
cmlmO2ZvbnQtc2l6ZToxMHB4IiBoZWlnaHQ9IjEyIiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5bGU9
ImZvbnQtd2VpZ2h0OmJvbGQ7Y29sb3I6cmdiKDM3LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUiPk1h
dHRoaWV1IEJhZXJ0cyB8IFImYW1wO0QgRW5naW5lZXI8L3NwYW4+PC90ZD48L3RyPjx0cj48dGQg
c3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlm
O2ZvbnQtc2l6ZToxMHB4IiBoZWlnaHQ9IjEyIiBhbGlnbj0ibGVmdCI+PGEgaHJlZj0ibWFpbHRv
Om1hdHRoaWV1LmJhZXJ0cyU0MHRlc3NhcmVzLm5ldCIgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7
dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0iX2JsYW5rIj5tYXR0
aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PGJyPjwvYT48L3RkPjwvdHI+PHRyPjx0ZCBzdHlsZT0i
cGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1z
aXplOjEwcHgiIGFsaWduPSJsZWZ0Ij48c3BhbiBzdHlsZT0iZm9udC13ZWlnaHQ6Ym9sZDtjb2xv
cjpyZ2IoMzcsODMsMTU1KTtkaXNwbGF5OmlubGluZSI+VGVzc2FyZXMgU0EgfCBIeWJyaWQgQWNj
ZXNzIFNvbHV0aW9uczxicj48L3NwYW4+PGEgaHJlZj0iaHR0cDovL3d3dy50ZXNzYXJlcy5uZXQi
IHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5s
aW5lIiB0YXJnZXQ9Il9ibGFuayI+d3d3LnRlc3NhcmVzLm5ldDwvYT48c3Bhbj7CoDwvc3Bhbj48
YnI+PGEgaHJlZj0iaHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS9tYXBzP3E9MStBdmVudWUrSmVhbitN
b25uZXQsKzEzNDgrT3R0aWduaWVzLUxvdXZhaW4tbGEtTmV1dmUsK0JlbGdpdW0iIHN0eWxlPSJj
b2xvcjpyZ2IoMCwwLDApO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJn
ZXQ9Il9ibGFuayI+MSBBdmVudWUgSmVhbiBNb25uZXQsIDEzNDggTG91dmFpbi1sYS1OZXV2ZSwg
QmVsZ2l1bTwvYT48L3RkPjwvdHI+PC90Ym9keT48L3RhYmxlPjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvZGl2Pgo8L2Rpdj48L2Rpdj48L2Rpdj4KCjxicj4KPGRpdj48YnI+PGhyPjwv
ZGl2Pjxmb250IHNpemU9IjEiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpWZXJkYW5hLHNhbnMt
c2VyaWY7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj5ESVNDTEFJTUVSLjwvc3Bh
bj48YnIgc3R5bGU9ImZvbnQtZmFtaWx5OlZlcmRhbmEsc2Fucy1zZXJpZjtiYWNrZ3JvdW5kLWNv
bG9yOnJnYigyNTUsMjU1LDI1NSkiPjxmb250IGNvbG9yPSIjMDAwMDAwIiBmYWNlPSJWZXJkYW5h
LCBzYW5zLXNlcmlmIiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj5U
aGlzIGVtYWlsIGFuZCBhbnkgZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBhcmUgY29uZmlkZW50
aWFsIGFuZCBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgb3Ig
ZW50aXR5IHRvIHdob20gdGhleSBhcmUgYWRkcmVzc2VkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0
aGlzIGVtYWlsIGluIGVycm9yIHBsZWFzZSBub3RpZnkgdGhlIHN5c3RlbSBtYW5hZ2VyLiBUaGlz
IG1lc3NhZ2UgY29udGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRl
ZCBvbmx5IGZvciB0aGUgaW5kaXZpZHVhbCBuYW1lZC4gSWYgeW91IGFyZSBub3QgdGhlIG5hbWVk
IGFkZHJlc3NlZSB5b3Ugc2hvdWxkIG5vdCBkaXNzZW1pbmF0ZSwgZGlzdHJpYnV0ZSBvciBjb3B5
IHRoaXMgZS1tYWlsLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgZS1t
YWlsIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGJ5IG1pc3Rha2UgYW5kIGRlbGV0
ZSB0aGlzIGUtbWFpbCBmcm9tIHlvdXIgc3lzdGVtLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50IHlvdSBhcmUgbm90aWZpZWQgdGhhdCBkaXNjbG9zaW5nLCBjb3B5aW5nLCBk
aXN0cmlidXRpbmcgb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRl
bnRzIG9mIHRoaXMgaW5mb3JtYXRpb24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC48L2ZvbnQ+PC9m
b250Pg==
--===============6022838450764481847==--
