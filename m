Content-Type: multipart/mixed; boundary="===============3985438349715501431=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 16:26:01 +0200
Message-ID: <CAKuKrB=5BFLGfBAnznUEH9Jn_KU4waX7xEtoJEEzESCrNAR2zw@mail.gmail.com>
In-Reply-To: CAKuKrBkv0Cd3n326c=zCoCc3isspfxY6MyP9yx7NADowH-KAnA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 564

--===============3985438349715501431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Christoph, Peter, Ossama,

I will wait for ~10am your time before sending it to let you some times to
comment this if you want to do so.

Best regards,
Matthieu

On Sun, Apr 29, 2018 at 4:08 PM, Matthieu Baerts <
matthieu.baerts(a)tessares.net> wrote:

> Hi Mat,
>
> Thank you for your review and input!
>
> On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <mathew.j.martineau(a)linu=
x.
> intel.com> wrote:
>
>>
>> Hi Matthieu -
>>
>> On Fri, 27 Apr 2018, Matthieu Baerts wrote:
>>
>> Hello,
>>>
>>> Following yesterday's discussion about NetDev 0x12, here is a
>>> proposition of mail to send to NetDev committee. I already put some
>>> comments. Note that I have followed the submission guidelines from:
>>> https://www.netdevconf.org/0x12/submit-proposal.html#proposals
>>>
>>> Please comment it before Monday morning. Sorry for the rush but the
>>> deadline is the 1st of May :)
>>>
>>> * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat Martineau
>>>>
>>> (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and myself,
>>> Matthieu Baerts (Tessares)
>>>
>>> I wrote down the names of people who participated in the discussion in
>>> the ML and during the weekly meetings. I can add more people if more pe=
ople
>>> would like to join the preparation and presentation of this tutorial.
>>> @Christoph, Mat, Peter, Ossama: can I write your names there?
>>>
>>
>> Ossama won't be able to attend. It looks like most sessions have 1 or 2
>> presenters, so I don't know if 4 is too many. I'm sure they'll give us s=
ome
>> feedback if they want to limit the number of presenters.
>>
>
> OK thank you!
> Yes indeed, I am sure they will say something if we are too many.
>
> * Title of the submission: MPTCP: from the basic to an upstreamable base
>>>>
>>>
>>> We certainly need a better title, please comment!
>>>
>>
>> "Multipath TCP: Present Use Cases and an Upstream Future" ?
>>
>
> I was trying to find something that catch the attention but it is maybe
> not needed for these kind of presentation.
>
> > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
>>>
>>> "hands-on" seems to be the correct one according to the Submission Type=
s.
>>> https://www.netdevconf.org/0x12/submit-proposal.html#types
>>>
>>
>> It's a little bit of "nuts & bolts" too, but I agree that hands-on is the
>> better match.
>>
>
> Thank you!
>
> * Submission type (one of talk, presentation, workshop): tutorial,
>>>>
>>> instructor-led sessions (minimum 1 hour long and not to exceed 1.5
>>> hours. The instructor will go over the technology either through code
>>> review or execution and interact with the attendees.)
>>>
>>> I guess there is a typo here: presentation should be replaced by
>>> tutorial in the guidelines.
>>>
>>> Estimate of length of time for presentation: 1h
>>>>
>>>
>>> That's what we agreed yesterday but I can change.
>>>
>>> Affiliations of submitters (needed for conflict of interest check):
>>>> Apple,
>>>>
>>> Intel, Tessares
>>>
>>> Description of proposal:
>>>>     A project to add an implementation of the MultiPath TCP protocol to
>>>> the
>>>>
>>> Linux kernel is in progress by a small community. The goal of this
>>> tutorial is to discover what is this TCP extension (RFC 6824), what are=
 the
>>> different use-cases already in production by some companies and what are
>>> the challenges to upstream MPTCP. We hope having interactive discussions
>>> and getting feedback from experienced developers will help us in this t=
ask
>>> of easily bringing MPTCP to all Linux users, a technology already used =
by
>>> millions of people.
>>>
>>
>>     In a bit more detail, we will start with a basic introduction of
>>>> MPTCP.
>>>>
>>> A few use-cases will be presented with a demo to explain how useful this
>>> protocol is in today's Internet and how it can be extended with API's l=
ike
>>> Netlink and BPF.
>>>
>>
>> I recognize how Netlink is associated with a userspace path manager, but
>> what's the BPF extensibility you're referring to?
>>
>
> It was only to mention that it would be possible to extend MPTCP with eBP=
F.
> Even if it is not already available in the current Open-Source
> implementation, there is already the possibility to get a version with a
> programmable scheduler: https://progmp.net
>
> Then we will have some explanations about how MPTCP is currently
>>> implemented. This current implementation is quite intrusive and that is
>>> certainly not something we would like to have upstream. We would like to
>>> express what we have in mind to change that, with some samples and init=
iate
>>> discussions.
>>>
>>
>> My edit of the above:
>>
>> """
>>
>> A community project is underway to add Multipath TCP to the upstream
>> Linux kernel. This tutorial will introduce the audience to this TCP
>> extension (RFC 6824), show some use cases already in production, and
>> discuss the challenges in converging on an upstream MPTCP implementation.
>>
>
> Should we insist on the "discussion" part? Like saying: "discuss with the
> audience"? "have interactive discussions"?
> It is maybe not needed but it was mainly to express the interactivity, it
> is a tutorial, not just a "simple" presentation.
>
> We will use the current MPTCP implementation to demonstrate the utility of
>> the protocol on today's internet, and to show how this implementation can
>> currently be extended with netlink and BPF. This not only has practical
>> application for deploying MPTCP now, but also illustrates how the APIs a=
nd
>> code will need to evolve in order to properly coexist with the optimized
>> Linux TCP core we all rely on. We will discuss our ideas for bringing MP=
TCP
>> to the upstream kernel so the technology is available to all Linux users.
>>
>
> To "attract" people, should we mention that the current implementation is
> already used by millions of users?
> I like how your improve the last bit :-)
>
> """
>>
>> Feel free to edit/merge/expand/discard as needed :)
>>
>
> Thank you for your edit, it is indeed cleaner!
>
>     For more information about this project:
>>>>
>>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>>
>>
> I guess I can keep this, right?
>
> Please feel free to comment this as well. We are still far from the max
>>> 350 words limit we found last time. But on the other hand, I can no lon=
ger
>>> find this limit on their website :)
>>>
>>
>> Hope the above is helpful. Thanks again for your work on this proposal.
>>
>
> Yes it is, thank you for your help!
>
> Matthieu
>
>
>>
>> Mat
>>
>>
>>
>>
>>> Thank you for your help!
>>>
>>> Have a good day/evening,
>>> Matthieu
>>>
>>> On 25/04/2018 21:58, Mat Martineau wrote:
>>>
>>>>
>>>> Hi Matthieu -
>>>>
>>>> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
>>>>
>>>> Hello,
>>>>>
>>>>>
>>>>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to 13th=
, 2018.
>>>>>
>>>>>
>>>>> We already talked about this event on this ML and at our weekly
>>>>> meetings but here is a summary of the discussions we had:
>>>>>
>>>>>  - we would like to have a presentation there mainly to get feedback
>>>>> and advice from other kernel developers
>>>>>  - a presentation would clearly indicate that this MPTCP Upstream
>>>>> project exists and we could get help from more developers
>>>>>  - we would like to indicate that having MPTCP upstream is asked by
>>>>> different companies, some are even ready to contribute ; it is then
>>>>> important to have MPTCP upstream
>>>>>
>>>>>
>>>>> Also note that:
>>>>>
>>>>>  - David Miller will not be present in Montr=C3=A9al [1] but other ma=
in
>>>>> contributors should be there (we don't have a list)
>>>>>
>>>>
>>>> Side note, in the past day David reiterated his statement about not
>>>> attending or supporting the conference:
>>>>
>>>> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2
>>>>
>>>>  - A presentation by Octavian Purdila about "MPTCP Upstreaming" has
>>>>> already been given in 2015 (NetDev 0.1) [2]
>>>>>  - 3 types of presentation are available: talks, tutorials and
>>>>> workshops [3]
>>>>>  - Call for Presentation Proposals closes on May 1st, 2018.
>>>>>
>>>>>
>>>>> The current idea we briefly discussed during our weekly meetings is to
>>>>> give a tutorial:
>>>>>
>>>>>  - It is not useful to give almost the same presentation as the one of
>>>>> Octavian
>>>>>  - It will allow us more flexibility somehow to explain what is MPTCP,
>>>>> the different use-cases, why it is important to have it upstream and =
what
>>>>> problems we are currently facing.
>>>>>  - David Miller and many other kernel developers will go to LPC in
>>>>> November: a good place to give a talk this time.
>>>>>
>>>>>
>>>>> Do you have any ideas on what we could show in this tutorial?
>>>>>
>>>>>
>>>>> I recently discussed with my colleague Olivier Bonaventure who has a
>>>>> lot of experiences in giving different introductions and more about M=
PTCP
>>>>> and here is what he suggests:
>>>>>
>>>>>  - A first part about a basic introduction of MPTCP
>>>>>  - Indicate different use-cases -- if possible with a "closed demo" to
>>>>> be sure it is working -- asking people to setup something is not easy=
 in
>>>>> 1h, max 1h30.
>>>>>
>>>>
>>>>  From the description at [3], either "instructor-led" 60-90 minute
>>>> tutorials or "student-participation" 2-3 hour sessions are possible. T=
he
>>>> closed demo maps well to their "instructor-led" category. Looking at t=
he
>>>> schedule, the past two Netdev Conferences have had one tutorial each, =
of
>>>> 60-70 minutes. I think it helps to be closer to an hour in length to h=
old
>>>> the audience's attention.
>>>>
>>>>  - Then trying to have interactive discussions or explanations about
>>>>> how MPTCP is currently implemented or should be implemented if it goes
>>>>> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we need=
 to
>>>>> support middleboxes, we need to link subflows of the same connection
>>>>> together, we need a scheduler, a PM, etc.
>>>>>
>>>>
>>>> It's difficult to predict how interactive an audience will be. I've
>>>> only attended one Netdev Conference, and it seemed like there were a l=
ot
>>>> more people with expertise and interest in drivers, lower layers (XDP,=
 BPF,
>>>> TC, netfilter), and network topology/simulation. Discussion around
>>>> middlebox support and the userspace API might have more audience
>>>> interaction. If we want to drive a discussion, we could try to strike a
>>>> balance between topics for the broader audience and those with more
>>>> knowledge of TCP internals. (Hopefully some TCP internals people are s=
till
>>>> planning to attend)
>>>>
>>>>  - Of course, we should focus our discussions on the upstreaming
>>>>> aspect, e.g. reducing the footprint of MPTCP in the current TCP stack=
: what
>>>>> are we allow to do, what not. It is linked to many previous discussio=
ns we
>>>>> had on this ML, e.g. why we need more indirect function calls and how=
 to
>>>>> reduce the impact, etc.
>>>>>
>>>>
>>>> The previous talk ([2]) had a section like this. I haven't watched it
>>>> recently, I should look at it again to see what kind of questions the
>>>> audience was asking. As you mentioned above we should be careful to ha=
ve
>>>> new content compared to the previous session.
>>>>
>>>>  - If we have time, we could discuss about how users could interact
>>>>> with MPTCP: enable it per connection, control the path manager, maybe=
 the
>>>>> scheduler, etc.
>>>>>
>>>>>
>>>>> What do you think about this? Feel free to comment and even propose
>>>>> completely different ideas!
>>>>>
>>>>
>>>> Thank you for outlining these ideas. I see that this topic is on our
>>>> meeting agenda so it will be good to discuss the tutorial there.
>>>>
>>>>
>>>> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
>>>>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>>>>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
>>>>>
>>>>
>>>>
>> --
>> Mat Martineau
>> Intel OTC
>>
>
>
>
> --
> [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Lou=
vain-la-Neuve,+Belgium>
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

--===============3985438349715501431==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBNYXQsIENocmlzdG9waCwgUGV0ZXIsIE9zc2FtYSw8YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHdpbGwgd2FpdCBmb3IgfjEwYW0geW91ciB0aW1l
IGJlZm9yZSBzZW5kaW5nIGl0IHRvIGxldCB5b3Ugc29tZSB0aW1lcyB0byBjb21tZW50IHRoaXMg
aWYgeW91IHdhbnQgdG8gZG8gc28uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5CZXN0IHJlZ2Fy
ZHMsPC9kaXY+PGRpdj5NYXR0aGlldTxicj48L2Rpdj48ZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2V4
dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFN1biwgQXByIDI5LCAyMDE4IGF0
IDQ6MDggUE0sIE1hdHRoaWV1IEJhZXJ0cyA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1h
aWx0bzptYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhp
ZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDwvYT4mZ3Q7PC9zcGFuPiB3cm90ZTo8YnI+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxl
ZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj5I
aSBNYXQsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3
IGFuZCBpbnB1dCE8YnI+PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48c3BhbiBjbGFzcz0iIj5PbiBTYXQsIEFwciAyOCwgMjAx
OCBhdCAyOjQ0IEFNLCBNYXQgTWFydGluZWF1IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0i
bWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5tYXRoZXcuai5tYXJ0aW5lYXVAbGludXguPHdicj5pbnRlbC5jb208L2E+Jmd0Ozwvc3Bhbj4g
d3JvdGU6PGJyPjwvc3Bhbj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGJyPgpIaSBNYXR0aGlldSAtPHNwYW4gY2xhc3M9Im1f
LTEzNTA3NzU3MTkzMjA3MTAyNDVnbWFpbC0iPjxicj4KPGJyPjxzcGFuIGNsYXNzPSIiPgpPbiBG
cmksIDI3IEFwciAyMDE4LCBNYXR0aGlldSBCYWVydHMgd3JvdGU6PGJyPgo8YnI+Cjwvc3Bhbj48
L3NwYW4+PHNwYW4gY2xhc3M9IiI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0
LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgpIZWxsbyw8YnI+Cjxicj48c3BhbiBjbGFzcz0i
bV8tMTM1MDc3NTcxOTMyMDcxMDI0NWdtYWlsLSI+CkZvbGxvd2luZyB5ZXN0ZXJkYXkmIzM5O3Mg
ZGlzY3Vzc2lvbiBhYm91dCBOZXREZXYgMHgxMiwgaGVyZSBpcyBhIHByb3Bvc2l0aW9uIG9mIG1h
aWwgdG8gc2VuZCB0byBOZXREZXYgY29tbWl0dGVlLiBJIGFscmVhZHkgcHV0IHNvbWUgY29tbWVu
dHMuIE5vdGUgdGhhdCBJIGhhdmUgZm9sbG93ZWQgdGhlIHN1Ym1pc3Npb24gZ3VpZGVsaW5lcyBm
cm9tOiA8YSBocmVmPSJodHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy8weDEyL3N1Ym1pdC1wcm9w
b3NhbC5odG1sI3Byb3Bvc2FscyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0
cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdicj4yL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3By
b3Bvc2E8d2JyPmxzPC9hPjxicj4KPGJyPgpQbGVhc2UgY29tbWVudCBpdCBiZWZvcmUgTW9uZGF5
IG1vcm5pbmcuIFNvcnJ5IGZvciB0aGUgcnVzaCBidXQgdGhlIGRlYWRsaW5lIGlzIHRoZSAxc3Qg
b2YgTWF5IDopPGJyPgo8YnI+CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KKiBOYW1lKHMpIG9mIHRoZSBzdWJtaXR0ZXIocyk6
IENocmlzdG9waCBQYWFzY2ggKEFwcGxlKSwgTWF0IE1hcnRpbmVhdSA8YnI+CjwvYmxvY2txdW90
ZT4KKEludGVsKSwgUGV0ZXIgS3J5c3RhZCAoSW50ZWwpLCBPc3NhbWEgT3RobWFuIChJbnRlbCkg
YW5kIG15c2VsZiwgTWF0dGhpZXUgQmFlcnRzIChUZXNzYXJlcyk8YnI+Cjxicj4KSSB3cm90ZSBk
b3duIHRoZSBuYW1lcyBvZiBwZW9wbGUgd2hvIHBhcnRpY2lwYXRlZCBpbiB0aGUgZGlzY3Vzc2lv
biBpbiB0aGUgTUwgYW5kIGR1cmluZyB0aGUgd2Vla2x5IG1lZXRpbmdzLiBJIGNhbiBhZGQgbW9y
ZSBwZW9wbGUgaWYgbW9yZSBwZW9wbGUgd291bGQgbGlrZSB0byBqb2luIHRoZSBwcmVwYXJhdGlv
biBhbmQgcHJlc2VudGF0aW9uIG9mIHRoaXMgdHV0b3JpYWwuPGJyPgpAQ2hyaXN0b3BoLCBNYXQs
IFBldGVyLCBPc3NhbWE6IGNhbiBJIHdyaXRlIHlvdXIgbmFtZXMgdGhlcmU/PGJyPgo8L3NwYW4+
PC9ibG9ja3F1b3RlPgo8YnI+Ck9zc2FtYSB3b24mIzM5O3QgYmUgYWJsZSB0byBhdHRlbmQuIEl0
IGxvb2tzIGxpa2UgbW9zdCBzZXNzaW9ucyBoYXZlIDEgb3IgMiBwcmVzZW50ZXJzLCBzbyBJIGRv
biYjMzk7dCBrbm93IGlmIDQgaXMgdG9vIG1hbnkuIEkmIzM5O20gc3VyZSB0aGV5JiMzOTtsbCBn
aXZlIHVzIHNvbWUgZmVlZGJhY2sgaWYgdGhleSB3YW50IHRvIGxpbWl0IHRoZSBudW1iZXIgb2Yg
cHJlc2VudGVycy48c3BhbiBjbGFzcz0ibV8tMTM1MDc3NTcxOTMyMDcxMDI0NWdtYWlsLSI+PGJy
Pjwvc3Bhbj48L3NwYW4+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+T0sgdGhhbmsg
eW91ITwvZGl2PjxkaXY+WWVzIGluZGVlZCwgSSBhbSBzdXJlIHRoZXkgd2lsbCBzYXkgc29tZXRo
aW5nIGlmIHdlIGFyZSB0b28gbWFueS48YnI+PC9kaXY+PHNwYW4gY2xhc3M9IiI+PGRpdj48YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPjxzcGFuIGNsYXNzPSJtXy0xMzUwNzc1NzE5MzIwNzEwMjQ1Z21haWwtIj4K
CjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KCjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij4KKiBUaXRsZSBvZiB0aGUgc3VibWlzc2lvbjogTVBUQ1A6IGZyb20g
dGhlIGJhc2ljIHRvIGFuIHVwc3RyZWFtYWJsZSBiYXNlPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj4K
V2UgY2VydGFpbmx5IG5lZWQgYSBiZXR0ZXIgdGl0bGUsIHBsZWFzZSBjb21tZW50ITxicj4KPC9i
bG9ja3F1b3RlPgo8YnI+PC9zcGFuPgomcXVvdDtNdWx0aXBhdGggVENQOiBQcmVzZW50IFVzZSBD
YXNlcyBhbmQgYW4gVXBzdHJlYW0gRnV0dXJlJnF1b3Q7ID88c3BhbiBjbGFzcz0ibV8tMTM1MDc3
NTcxOTMyMDcxMDI0NWdtYWlsLSI+PGJyPjwvc3Bhbj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PC9zcGFuPjxkaXY+SSB3YXMgdHJ5aW5nIHRvIGZpbmQgc29tZXRoaW5nIHRoYXQgY2F0Y2gg
dGhlIGF0dGVudGlvbiBidXQgaXQgaXMgbWF5YmUgbm90IG5lZWRlZCBmb3IgdGhlc2Uga2luZCBv
ZiBwcmVzZW50YXRpb24uPC9kaXY+PHNwYW4gY2xhc3M9IiI+PGRpdj4gPGJyPjwvZGl2PjxibG9j
a3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4
Ij48c3BhbiBjbGFzcz0ibV8tMTM1MDc3NTcxOTMyMDcxMDI0NWdtYWlsLSI+Cgo8YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cgom
Z3Q7ICogTGFiZWwgKG9uZSBvZiBtb29uc2hvdCwgbnV0cyYjMzk7biBib2x0cywgaGFuZHMtb24p
OiBoYW5kcy1vbjxicj4KPGJyPgomcXVvdDtoYW5kcy1vbiZxdW90OyBzZWVtcyB0byBiZSB0aGUg
Y29ycmVjdCBvbmUgYWNjb3JkaW5nIHRvIHRoZSBTdWJtaXNzaW9uIFR5cGVzLjxicj4KPGEgaHJl
Zj0iaHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCN0
eXBlcyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2
Y29uZi5vcmcvMHgxPHdicj4yL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3R5cGVzPC9hPjxicj4KPC9i
bG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpJdCYjMzk7cyBhIGxpdHRsZSBiaXQgb2YgJnF1b3Q7bnV0
cyAmYW1wOyBib2x0cyZxdW90OyB0b28sIGJ1dCBJIGFncmVlIHRoYXQgaGFuZHMtb24gaXMgdGhl
IGJldHRlciBtYXRjaC48c3BhbiBjbGFzcz0ibV8tMTM1MDc3NTcxOTMyMDcxMDI0NWdtYWlsLSI+
PGJyPjwvc3Bhbj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PC9zcGFuPjxkaXY+VGhhbmsg
eW91ITxicj48L2Rpdj48c3BhbiBjbGFzcz0iIj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4g
Y2xhc3M9Im1fLTEzNTA3NzU3MTkzMjA3MTAyNDVnbWFpbC0iPgo8YmxvY2txdW90ZSBjbGFzcz0i
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
ZyB0bz88c3BhbiBjbGFzcz0ibV8tMTM1MDc3NTcxOTMyMDcxMDI0NWdtYWlsLSI+PGJyPjwvc3Bh
bj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PC9zcGFuPjxkaXY+SXQgd2FzIG9ubHkgdG8g
bWVudGlvbiB0aGF0IGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIGV4dGVuZCBNUFRDUCB3aXRoIGVC
UEYuPC9kaXY+PGRpdj5FdmVuIGlmIGl0IGlzIG5vdCBhbHJlYWR5IGF2YWlsYWJsZSBpbiB0aGUg
Y3VycmVudCBPcGVuLVNvdXJjZSBpbXBsZW1lbnRhdGlvbiwgdGhlcmUgaXMgYWxyZWFkeSB0aGUg
cG9zc2liaWxpdHkgdG8gZ2V0IGEgdmVyc2lvbiB3aXRoIGEgIHByb2dyYW1tYWJsZSBzY2hlZHVs
ZXI6IDxhIGhyZWY9Imh0dHBzOi8vcHJvZ21wLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8v
cHJvZ21wLm5ldDwvYT48YnI+PC9kaXY+PHNwYW4gY2xhc3M9IiI+PGRpdj48YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPjxzcGFuIGNsYXNzPSJtXy0xMzUwNzc1NzE5MzIwNzEwMjQ1Z21haWwtIj4KCjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4K
VGhlbiB3ZSB3aWxsIGhhdmUgc29tZSBleHBsYW5hdGlvbnMgYWJvdXQgaG93IE1QVENQIGlzIGN1
cnJlbnRseSBpbXBsZW1lbnRlZC4gVGhpcyBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIHF1aXRl
IGludHJ1c2l2ZSBhbmQgdGhhdCBpcyBjZXJ0YWlubHkgbm90IHNvbWV0aGluZyB3ZSB3b3VsZCBs
aWtlIHRvIGhhdmUgdXBzdHJlYW0uIFdlIHdvdWxkIGxpa2UgdG8gZXhwcmVzcyB3aGF0IHdlIGhh
dmUgaW4gbWluZCB0byBjaGFuZ2UgdGhhdCwgd2l0aCBzb21lIHNhbXBsZXMgYW5kIGluaXRpYXRl
IGRpc2N1c3Npb25zLjxicj4KPC9ibG9ja3F1b3RlPgo8YnI+PC9zcGFuPgpNeSBlZGl0IG9mIHRo
ZSBhYm92ZTo8YnI+Cjxicj4KJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPgo8YnI+CkEgY29tbXVuaXR5
IHByb2plY3QgaXMgdW5kZXJ3YXkgdG8gYWRkIE11bHRpcGF0aCBUQ1AgdG8gdGhlIHVwc3RyZWFt
IExpbnV4IGtlcm5lbC4gVGhpcyB0dXRvcmlhbCB3aWxsIGludHJvZHVjZSB0aGUgYXVkaWVuY2Ug
dG8gdGhpcyBUQ1AgZXh0ZW5zaW9uIChSRkMgNjgyNCksIHNob3cgc29tZSB1c2UgY2FzZXMgYWxy
ZWFkeSBpbiBwcm9kdWN0aW9uLCBhbmQgZGlzY3VzcyB0aGUgY2hhbGxlbmdlcyBpbiBjb252ZXJn
aW5nIG9uIGFuIHVwc3RyZWFtIE1QVENQIGltcGxlbWVudGF0aW9uLjxicj48L2Jsb2NrcXVvdGU+
PGRpdj48YnI+PC9kaXY+PC9zcGFuPjxkaXY+U2hvdWxkIHdlIGluc2lzdCBvbiB0aGUgJnF1b3Q7
ZGlzY3Vzc2lvbiZxdW90OyBwYXJ0PyBMaWtlIHNheWluZzogJnF1b3Q7ZGlzY3VzcyB3aXRoIHRo
ZSBhdWRpZW5jZSZxdW90Oz8gJnF1b3Q7aGF2ZSBpbnRlcmFjdGl2ZSBkaXNjdXNzaW9ucyZxdW90
Oz88L2Rpdj48ZGl2Pkl0IGlzIG1heWJlIG5vdCBuZWVkZWQgYnV0IGl0IHdhcyBtYWlubHkgdG8g
ZXhwcmVzcyB0aGUgaW50ZXJhY3Rpdml0eSwgaXQgaXMgYSB0dXRvcmlhbCwgbm90IGp1c3QgYSAm
cXVvdDtzaW1wbGUmcXVvdDsgcHJlc2VudGF0aW9uLjxicj48L2Rpdj48c3BhbiBjbGFzcz0iIj48
ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+CgpXZSB3aWxsIHVzZSB0aGUgY3VycmVudCBNUFRDUCBpbXBs
ZW1lbnRhdGlvbiB0byBkZW1vbnN0cmF0ZSB0aGUgdXRpbGl0eSBvZiB0aGUgcHJvdG9jb2wgb24g
dG9kYXkmIzM5O3MgaW50ZXJuZXQsIGFuZCB0byBzaG93IGhvdyB0aGlzIGltcGxlbWVudGF0aW9u
IGNhbiBjdXJyZW50bHkgYmUgZXh0ZW5kZWQgd2l0aCBuZXRsaW5rIGFuZCBCUEYuIFRoaXMgbm90
IG9ubHkgaGFzIHByYWN0aWNhbCBhcHBsaWNhdGlvbiBmb3IgZGVwbG95aW5nIE1QVENQIG5vdywg
YnV0IGFsc28gaWxsdXN0cmF0ZXMgaG93IHRoZSBBUElzIGFuZCBjb2RlIHdpbGwgbmVlZCB0byBl
dm9sdmUgaW4gb3JkZXIgdG8gcHJvcGVybHkgY29leGlzdCB3aXRoIHRoZSBvcHRpbWl6ZWQgTGlu
dXggVENQIGNvcmUgd2UgYWxsIHJlbHkgb24uIFdlIHdpbGwgZGlzY3VzcyBvdXIgaWRlYXMgZm9y
IGJyaW5naW5nIE1QVENQIHRvIHRoZSB1cHN0cmVhbSBrZXJuZWwgc28gdGhlIHRlY2hub2xvZ3kg
aXMgYXZhaWxhYmxlIHRvIGFsbCBMaW51eCB1c2Vycy48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJy
PjwvZGl2Pjwvc3Bhbj48ZGl2PlRvICZxdW90O2F0dHJhY3QmcXVvdDsgcGVvcGxlLCBzaG91bGQg
d2UgbWVudGlvbiB0aGF0IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIGFscmVhZHkgdXNl
ZCBieSBtaWxsaW9ucyBvZiB1c2Vycz88L2Rpdj48ZGl2PkkgbGlrZSBob3cgeW91ciBpbXByb3Zl
IHRoZSBsYXN0IGJpdCA6LSk8YnI+PC9kaXY+PHNwYW4gY2xhc3M9IiI+PGRpdj4gPGJyPjwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBw
eCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxl
ZnQ6MWV4Ij4KCiZxdW90OyZxdW90OyZxdW90Ozxicj4KPGJyPgpGZWVsIGZyZWUgdG8gZWRpdC9t
ZXJnZS9leHBhbmQvZGlzY2FyZCBhcyBuZWVkZWQgOik8c3BhbiBjbGFzcz0ibV8tMTM1MDc3NTcx
OTMyMDcxMDI0NWdtYWlsLSI+PGJyPjwvc3Bhbj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+
PC9zcGFuPjxkaXY+VGhhbmsgeW91IGZvciB5b3VyIGVkaXQsIGl0IGlzIGluZGVlZCBjbGVhbmVy
ITwvZGl2PjxzcGFuIGNsYXNzPSIiPjxkaXY+IDxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PHNwYW4gY2xhc3M9
Im1fLTEzNTA3NzU3MTkzMjA3MTAyNDVnbWFpbC0iPgoKPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVm
dDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4KwqAgwqAgRm9y
IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhpcyBwcm9qZWN0OiA8YnI+CjwvYmxvY2txdW90ZT4K
PGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL211bHRpcGF0aC10Y3AvbXB0Y3BfbmV0LW5leHQv
d2lraSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29t
L211bHRpcGF0aC10PHdicj5jcC9tcHRjcF9uZXQtbmV4dC93aWtpPC9hPjwvYmxvY2txdW90ZT48
L3NwYW4+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2Pjwvc3Bhbj48ZGl2PkkgZ3Vlc3MgSSBj
YW4ga2VlcCB0aGlzLCByaWdodD88L2Rpdj48c3BhbiBjbGFzcz0iIj48ZGl2PiA8YnI+PC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPjxzcGFuIGNsYXNzPSJtXy0xMzUwNzc1NzE5MzIwNzEwMjQ1Z21haWwtIj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
ClBsZWFzZSBmZWVsIGZyZWUgdG8gY29tbWVudCB0aGlzIGFzIHdlbGwuIFdlIGFyZSBzdGlsbCBm
YXIgZnJvbSB0aGUgbWF4IDM1MCB3b3JkcyBsaW1pdCB3ZSBmb3VuZCBsYXN0IHRpbWUuIEJ1dCBv
biB0aGUgb3RoZXIgaGFuZCwgSSBjYW4gbm8gbG9uZ2VyIGZpbmQgdGhpcyBsaW1pdCBvbiB0aGVp
ciB3ZWJzaXRlIDopPGJyPgo8L2Jsb2NrcXVvdGU+Cjxicj48L3NwYW4+CkhvcGUgdGhlIGFib3Zl
IGlzIGhlbHBmdWwuIFRoYW5rcyBhZ2FpbiBmb3IgeW91ciB3b3JrIG9uIHRoaXMgcHJvcG9zYWwu
PHNwYW4gY2xhc3M9Im1fLTEzNTA3NzU3MTkzMjA3MTAyNDVnbWFpbC1IT0VuWmIiPjxmb250IGNv
bG9yPSIjODg4ODg4Ij48YnI+PC9mb250Pjwvc3Bhbj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9k
aXY+PC9zcGFuPjxkaXY+WWVzIGl0IGlzLCB0aGFuayB5b3UgZm9yIHlvdXIgaGVscCE8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pk1hdHRoaWV1PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJoNSI+PGRp
dj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQp
O3BhZGRpbmctbGVmdDoxZXgiPjxzcGFuIGNsYXNzPSJtXy0xMzUwNzc1NzE5MzIwNzEwMjQ1Z21h
aWwtSE9FblpiIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+Cjxicj4KPGJyPgpNYXQ8L2ZvbnQ+PC9z
cGFuPjxkaXYgY2xhc3M9Im1fLTEzNTA3NzU3MTkzMjA3MTAyNDVnbWFpbC1IT0VuWmIiPjxkaXYg
Y2xhc3M9Im1fLTEzNTA3NzU3MTkzMjA3MTAyNDVnbWFpbC1oNSI+PGJyPgo8YnI+Cjxicj4KPGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPgo8YnI+ClRoYW5rIHlvdSBmb3IgeW91ciBoZWxwITxicj4KPGJyPgpIYXZlIGEgZ29vZCBk
YXkvZXZlbmluZyw8YnI+Ck1hdHRoaWV1PGJyPgo8YnI+Ck9uIDI1LzA0LzIwMTggMjE6NTgsIE1h
dCBNYXJ0aW5lYXUgd3JvdGU6PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4KSGkgTWF0dGhpZXUgLTxicj4KPGJy
PgpPbiBGcmksIDIwIEFwciAyMDE4LCBNYXR0aGlldSBCYWVydHMgd3JvdGU6PGJyPgo8YnI+Cjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij4KSGVsbG8sPGJyPgo8YnI+Cjxicj4KTmV0RGV2IDB4MTIgaXMgY29taW5nIHRvIE1vbnRy
w6lhbCB0aGlzIHN1bW1lcjogSnVseSAxMXRoIHRvIDEzdGgsIDIwMTguPGJyPgo8YnI+Cjxicj4K
V2UgYWxyZWFkeSB0YWxrZWQgYWJvdXQgdGhpcyBldmVudCBvbiB0aGlzIE1MIGFuZCBhdCBvdXIg
d2Vla2x5IG1lZXRpbmdzIGJ1dCBoZXJlIGlzIGEgc3VtbWFyeSBvZiB0aGUgZGlzY3Vzc2lvbnMg
d2UgaGFkOjxicj4KPGJyPgrCoC0gd2Ugd291bGQgbGlrZSB0byBoYXZlIGEgcHJlc2VudGF0aW9u
IHRoZXJlIG1haW5seSB0byBnZXQgZmVlZGJhY2sgYW5kIGFkdmljZSBmcm9tIG90aGVyIGtlcm5l
bCBkZXZlbG9wZXJzPGJyPgrCoC0gYSBwcmVzZW50YXRpb24gd291bGQgY2xlYXJseSBpbmRpY2F0
ZSB0aGF0IHRoaXMgTVBUQ1AgVXBzdHJlYW0gcHJvamVjdCBleGlzdHMgYW5kIHdlIGNvdWxkIGdl
dCBoZWxwIGZyb20gbW9yZSBkZXZlbG9wZXJzPGJyPgrCoC0gd2Ugd291bGQgbGlrZSB0byBpbmRp
Y2F0ZSB0aGF0IGhhdmluZyBNUFRDUCB1cHN0cmVhbSBpcyBhc2tlZCBieSBkaWZmZXJlbnQgY29t
cGFuaWVzLCBzb21lIGFyZSBldmVuIHJlYWR5IHRvIGNvbnRyaWJ1dGUgOyBpdCBpcyB0aGVuIGlt
cG9ydGFudCB0byBoYXZlIE1QVENQIHVwc3RyZWFtPGJyPgo8YnI+Cjxicj4KQWxzbyBub3RlIHRo
YXQ6PGJyPgo8YnI+CsKgLSBEYXZpZCBNaWxsZXIgd2lsbCBub3QgYmUgcHJlc2VudCBpbiBNb250
csOpYWwgWzFdIGJ1dCBvdGhlciBtYWluIGNvbnRyaWJ1dG9ycyBzaG91bGQgYmUgdGhlcmUgKHdl
IGRvbiYjMzk7dCBoYXZlIGEgbGlzdCk8YnI+CjwvYmxvY2txdW90ZT4KPGJyPgpTaWRlIG5vdGUs
IGluIHRoZSBwYXN0IGRheSBEYXZpZCByZWl0ZXJhdGVkIGhpcyBzdGF0ZW1lbnQgYWJvdXQgbm90
IGF0dGVuZGluZyBvciBzdXBwb3J0aW5nIHRoZSBjb25mZXJlbmNlOjxicj4KPGJyPgo8YSBocmVm
PSJodHRwczovL21hcmMuaW5mby8/bD1saW51eC1uZXRkZXYmYW1wO209MTUyNDY2ODI3MjAzMzAx
JmFtcDt3PTIiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vbWFyYy5p
bmZvLz9sPWxpbnV4LW5ldDx3YnI+ZGV2JmFtcDttPTE1MjQ2NjgyNzIwMzMwMSZhbXA7dz0yPC9h
Pjxicj4KPGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+CsKgLSBBIHByZXNlbnRhdGlvbiBieSBPY3RhdmlhbiBQdXJkaWxh
IGFib3V0ICZxdW90O01QVENQIFVwc3RyZWFtaW5nJnF1b3Q7IGhhcyBhbHJlYWR5IGJlZW4gZ2l2
ZW4gaW4gMjAxNSAoTmV0RGV2IDAuMSkgWzJdPGJyPgrCoC0gMyB0eXBlcyBvZiBwcmVzZW50YXRp
b24gYXJlIGF2YWlsYWJsZTogdGFsa3MsIHR1dG9yaWFscyBhbmQgd29ya3Nob3BzIFszXTxicj4K
wqAtIENhbGwgZm9yIFByZXNlbnRhdGlvbiBQcm9wb3NhbHMgY2xvc2VzIG9uIE1heSAxc3QsIDIw
MTguPGJyPgo8YnI+Cjxicj4KVGhlIGN1cnJlbnQgaWRlYSB3ZSBicmllZmx5IGRpc2N1c3NlZCBk
dXJpbmcgb3VyIHdlZWtseSBtZWV0aW5ncyBpcyB0byBnaXZlIGEgdHV0b3JpYWw6PGJyPgo8YnI+
CsKgLSBJdCBpcyBub3QgdXNlZnVsIHRvIGdpdmUgYWxtb3N0IHRoZSBzYW1lIHByZXNlbnRhdGlv
biBhcyB0aGUgb25lIG9mIE9jdGF2aWFuPGJyPgrCoC0gSXQgd2lsbCBhbGxvdyB1cyBtb3JlIGZs
ZXhpYmlsaXR5IHNvbWVob3cgdG8gZXhwbGFpbiB3aGF0IGlzIE1QVENQLCB0aGUgZGlmZmVyZW50
IHVzZS1jYXNlcywgd2h5IGl0IGlzIGltcG9ydGFudCB0byBoYXZlIGl0IHVwc3RyZWFtIGFuZCB3
aGF0IHByb2JsZW1zIHdlIGFyZSBjdXJyZW50bHkgZmFjaW5nLjxicj4KwqAtIERhdmlkIE1pbGxl
ciBhbmQgbWFueSBvdGhlciBrZXJuZWwgZGV2ZWxvcGVycyB3aWxsIGdvIHRvIExQQyBpbiBOb3Zl
bWJlcjogYSBnb29kIHBsYWNlIHRvIGdpdmUgYSB0YWxrIHRoaXMgdGltZS48YnI+Cjxicj4KPGJy
PgpEbyB5b3UgaGF2ZSBhbnkgaWRlYXMgb24gd2hhdCB3ZSBjb3VsZCBzaG93IGluIHRoaXMgdHV0
b3JpYWw/PGJyPgo8YnI+Cjxicj4KSSByZWNlbnRseSBkaXNjdXNzZWQgd2l0aCBteSBjb2xsZWFn
dWUgT2xpdmllciBCb25hdmVudHVyZSB3aG8gaGFzIGEgbG90IG9mIGV4cGVyaWVuY2VzIGluIGdp
dmluZyBkaWZmZXJlbnQgaW50cm9kdWN0aW9ucyBhbmQgbW9yZSBhYm91dCBNUFRDUCBhbmQgaGVy
ZSBpcyB3aGF0IGhlIHN1Z2dlc3RzOjxicj4KPGJyPgrCoC0gQSBmaXJzdCBwYXJ0IGFib3V0IGEg
YmFzaWMgaW50cm9kdWN0aW9uIG9mIE1QVENQPGJyPgrCoC0gSW5kaWNhdGUgZGlmZmVyZW50IHVz
ZS1jYXNlcyAtLSBpZiBwb3NzaWJsZSB3aXRoIGEgJnF1b3Q7Y2xvc2VkIGRlbW8mcXVvdDsgdG8g
YmUgc3VyZSBpdCBpcyB3b3JraW5nIC0tIGFza2luZyBwZW9wbGUgdG8gc2V0dXAgc29tZXRoaW5n
IGlzIG5vdCBlYXN5IGluIDFoLCBtYXggMWgzMC48YnI+CjwvYmxvY2txdW90ZT4KPGJyPgrCoEZy
b20gdGhlIGRlc2NyaXB0aW9uIGF0IFszXSwgZWl0aGVyICZxdW90O2luc3RydWN0b3ItbGVkJnF1
b3Q7IDYwLTkwIG1pbnV0ZSB0dXRvcmlhbHMgb3IgJnF1b3Q7c3R1ZGVudC1wYXJ0aWNpcGF0aW9u
JnF1b3Q7IDItMyBob3VyIHNlc3Npb25zIGFyZSBwb3NzaWJsZS4gVGhlIGNsb3NlZCBkZW1vIG1h
cHMgd2VsbCB0byB0aGVpciAmcXVvdDtpbnN0cnVjdG9yLWxlZCZxdW90OyBjYXRlZ29yeS4gTG9v
a2luZyBhdCB0aGUgc2NoZWR1bGUsIHRoZSBwYXN0IHR3byBOZXRkZXYgQ29uZmVyZW5jZXMgaGF2
ZSBoYWQgb25lIHR1dG9yaWFsIGVhY2gsIG9mIDYwLTcwIG1pbnV0ZXMuIEkgdGhpbmsgaXQgaGVs
cHMgdG8gYmUgY2xvc2VyIHRvIGFuIGhvdXIgaW4gbGVuZ3RoIHRvIGhvbGQgdGhlIGF1ZGllbmNl
JiMzOTtzIGF0dGVudGlvbi48YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgrCoC0gVGhlbiB0cnlpbmcgdG8gaGF2
ZSBpbnRlcmFjdGl2ZSBkaXNjdXNzaW9ucyBvciBleHBsYW5hdGlvbnMgYWJvdXQgaG93IE1QVENQ
IGlzIGN1cnJlbnRseSBpbXBsZW1lbnRlZCBvciBzaG91bGQgYmUgaW1wbGVtZW50ZWQgaWYgaXQg
Z29lcyB1cHN0cmVhbSwgZS5nLjogZm9yIE1QVENQLCB3ZSBuZWVkIHRvIGhhdmUgZXh0cmEgVENQ
IE9wdGlvbnMsIHdlIG5lZWQgdG8gc3VwcG9ydCBtaWRkbGVib3hlcywgd2UgbmVlZCB0byBsaW5r
IHN1YmZsb3dzIG9mIHRoZSBzYW1lIGNvbm5lY3Rpb24gdG9nZXRoZXIsIHdlIG5lZWQgYSBzY2hl
ZHVsZXIsIGEgUE0sIGV0Yy48YnI+CjwvYmxvY2txdW90ZT4KPGJyPgpJdCYjMzk7cyBkaWZmaWN1
bHQgdG8gcHJlZGljdCBob3cgaW50ZXJhY3RpdmUgYW4gYXVkaWVuY2Ugd2lsbCBiZS4gSSYjMzk7
dmUgb25seSBhdHRlbmRlZCBvbmUgTmV0ZGV2IENvbmZlcmVuY2UsIGFuZCBpdCBzZWVtZWQgbGlr
ZSB0aGVyZSB3ZXJlIGEgbG90IG1vcmUgcGVvcGxlIHdpdGggZXhwZXJ0aXNlIGFuZCBpbnRlcmVz
dCBpbiBkcml2ZXJzLCBsb3dlciBsYXllcnMgKFhEUCwgQlBGLCBUQywgbmV0ZmlsdGVyKSwgYW5k
IG5ldHdvcmsgdG9wb2xvZ3kvc2ltdWxhdGlvbi4gRGlzY3Vzc2lvbiBhcm91bmQgbWlkZGxlYm94
IHN1cHBvcnQgYW5kIHRoZSB1c2Vyc3BhY2UgQVBJIG1pZ2h0IGhhdmUgbW9yZSBhdWRpZW5jZSBp
bnRlcmFjdGlvbi4gSWYgd2Ugd2FudCB0byBkcml2ZSBhIGRpc2N1c3Npb24sIHdlIGNvdWxkIHRy
eSB0byBzdHJpa2UgYSBiYWxhbmNlIGJldHdlZW4gdG9waWNzIGZvciB0aGUgYnJvYWRlciBhdWRp
ZW5jZSBhbmQgdGhvc2Ugd2l0aCBtb3JlIGtub3dsZWRnZSBvZiBUQ1AgaW50ZXJuYWxzLiAoSG9w
ZWZ1bGx5IHNvbWUgVENQIGludGVybmFscyBwZW9wbGUgYXJlIHN0aWxsIHBsYW5uaW5nIHRvIGF0
dGVuZCk8YnI+Cjxicj4KPGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPgrCoC0gT2YgY291cnNlLCB3ZSBzaG91bGQgZm9jdXMgb3Vy
IGRpc2N1c3Npb25zIG9uIHRoZSB1cHN0cmVhbWluZyBhc3BlY3QsIGUuZy4gcmVkdWNpbmcgdGhl
IGZvb3RwcmludCBvZiBNUFRDUCBpbiB0aGUgY3VycmVudCBUQ1Agc3RhY2s6IHdoYXQgYXJlIHdl
IGFsbG93IHRvIGRvLCB3aGF0IG5vdC4gSXQgaXMgbGlua2VkIHRvIG1hbnkgcHJldmlvdXMgZGlz
Y3Vzc2lvbnMgd2UgaGFkIG9uIHRoaXMgTUwsIGUuZy4gd2h5IHdlIG5lZWQgbW9yZSBpbmRpcmVj
dCBmdW5jdGlvbiBjYWxscyBhbmQgaG93IHRvIHJlZHVjZSB0aGUgaW1wYWN0LCBldGMuPGJyPgo8
L2Jsb2NrcXVvdGU+Cjxicj4KVGhlIHByZXZpb3VzIHRhbGsgKFsyXSkgaGFkIGEgc2VjdGlvbiBs
aWtlIHRoaXMuIEkgaGF2ZW4mIzM5O3Qgd2F0Y2hlZCBpdCByZWNlbnRseSwgSSBzaG91bGQgbG9v
ayBhdCBpdCBhZ2FpbiB0byBzZWUgd2hhdCBraW5kIG9mIHF1ZXN0aW9ucyB0aGUgYXVkaWVuY2Ug
d2FzIGFza2luZy4gQXMgeW91IG1lbnRpb25lZCBhYm92ZSB3ZSBzaG91bGQgYmUgY2FyZWZ1bCB0
byBoYXZlIG5ldyBjb250ZW50IGNvbXBhcmVkIHRvIHRoZSBwcmV2aW91cyBzZXNzaW9uLjxicj4K
PGJyPgo8YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBw
eCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGlu
Zy1sZWZ0OjFleCI+CsKgLSBJZiB3ZSBoYXZlIHRpbWUsIHdlIGNvdWxkIGRpc2N1c3MgYWJvdXQg
aG93IHVzZXJzIGNvdWxkIGludGVyYWN0IHdpdGggTVBUQ1A6IGVuYWJsZSBpdCBwZXIgY29ubmVj
dGlvbiwgY29udHJvbCB0aGUgcGF0aCBtYW5hZ2VyLCBtYXliZSB0aGUgc2NoZWR1bGVyLCBldGMu
PGJyPgo8YnI+Cjxicj4KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcz8gRmVlbCBmcmVlIHRv
IGNvbW1lbnQgYW5kIGV2ZW4gcHJvcG9zZSBjb21wbGV0ZWx5IGRpZmZlcmVudCBpZGVhcyE8YnI+
CjwvYmxvY2txdW90ZT4KPGJyPgpUaGFuayB5b3UgZm9yIG91dGxpbmluZyB0aGVzZSBpZGVhcy4g
SSBzZWUgdGhhdCB0aGlzIHRvcGljIGlzIG9uIG91ciBtZWV0aW5nIGFnZW5kYSBzbyBpdCB3aWxs
IGJlIGdvb2QgdG8gZGlzY3VzcyB0aGUgdHV0b3JpYWwgdGhlcmUuPGJyPgo8YnI+Cjxicj4KPGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPgpbMV0gPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy4wMS5vcmcvcGlwZXJtYWlsL21wdGNwLzIw
MTgtTWFyY2gvMDAwMzc5Lmh0bWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0
dHBzOi8vbGlzdHMuMDEub3JnL3BpcGVybWFpbDx3YnI+L21wdGNwLzIwMTgtTWFyY2gvMDAwMzc5
Lmh0bWw8L2E+PGJyPgpbMl0gPGEgaHJlZj0iaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/
dj13ZnR6MmNVNVNacyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93
d3cueW91dHViZS5jb20vd2F0Y2g/PHdicj52PXdmdHoyY1U1U1pzPC9hPjxicj4KWzNdIDxhIGhy
ZWY9Imh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzB4MTIvc3VibWl0LXByb3Bvc2FsLmh0bWwi
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3Lm5ldGRldmNvbmYu
b3JnLzB4MTx3YnI+Mi9zdWJtaXQtcHJvcG9zYWwuaHRtbDwvYT48YnI+CjwvYmxvY2txdW90ZT4K
PGJyPgo8L2Jsb2NrcXVvdGU+PC9ibG9ja3F1b3RlPgo8YnI+Ci0tPGJyPgpNYXQgTWFydGluZWF1
PGJyPgpJbnRlbCBPVEM8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+
PHNwYW4gY2xhc3M9IkhPRW5aYiI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxicj48YnIgY2xlYXI9
ImFsbCI+PGJyPi0tIDxicj48L2ZvbnQ+PC9zcGFuPjxkaXYgY2xhc3M9Im1fLTEzNTA3NzU3MTkz
MjA3MTAyNDVnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0
ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48dGFibGUgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O1Rp
bWVzIE5ldyBSb21hbiZxdW90OztsZXR0ZXItc3BhY2luZzpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4
O3RleHQtdHJhbnNmb3JtOm5vbmU7d29yZC1zcGFjaW5nOjBweCIgd2lkdGg9IjEwMCUiIGJvcmRl
cj0iMCI+PHRib2R5Pjx0cj48dGQgcm93c3Bhbj0iMyIgc3R5bGU9InBhZGRpbmctbGVmdDo1cHg7
cGFkZGluZy1yaWdodDo1cHgiIHdpZHRoPSIxMCIgdmFsaWduPSJ0b3AiIGFsaWduPSJsZWZ0Ij48
YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPjxpbWcgc3Jj
PSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldC9zaWdsb2dvLnBuZyIgYWx0PSJUZXNzYXJlcyBTQSIg
d2lkdGg9IjgwIiBoZWlnaHQ9IjgwIiBib3JkZXI9IjAiPjwvYT48L3RkPjx0ZCBzdHlsZT0icGFk
ZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXpl
OjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48c3BhbiBzdHlsZT0iZm9udC13ZWlnaHQ6
Ym9sZDtjb2xvcjpyZ2IoMzcsODMsMTU1KTtkaXNwbGF5OmlubGluZSI+TWF0dGhpZXUgQmFlcnRz
IHwgUiZhbXA7RCBFbmdpbmVlcjwvc3Bhbj48L3RkPjwvdHI+PHRyPjx0ZCBzdHlsZT0icGFkZGlu
ZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEw
cHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFl
cnRzJTQwdGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRp
b246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRoaWV1LmJhZXJ0c0B0
ZXNzYXJlcy5uZXQ8YnI+PC9hPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtm
b250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgYWxp
Z249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4Mywx
NTUpO2Rpc3BsYXk6aW5saW5lIj5UZXNzYXJlcyBTQSB8IEh5YnJpZCBBY2Nlc3MgU29sdXRpb25z
PGJyPjwvc3Bhbj48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgc3R5bGU9ImNvbG9y
OnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0i
X2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxzcGFuPsKgPC9zcGFuPjxicj48YSBocmVmPSJo
dHRwczovL3d3dy5nb29nbGUuY29tL21hcHM/cT0xK0F2ZW51ZStKZWFuK01vbm5ldCwrMTM0OCtP
dHRpZ25pZXMtTG91dmFpbi1sYS1OZXV2ZSwrQmVsZ2l1bSIgc3R5bGU9ImNvbG9yOnJnYigwLDAs
MCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdldD0iX2JsYW5rIj4x
IEF2ZW51ZSBKZWFuIE1vbm5ldCwgMTM0OCBMb3V2YWluLWxhLU5ldXZlLCBCZWxnaXVtPC9hPjwv
dGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9k
aXY+CjwvZGl2PjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBjbGVhcj0i
YWxsIj48YnI+LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0YS1zbWFydG1h
aWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48
ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7VGltZXMg
TmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFjaW5nOm5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4
dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNpbmc6MHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIw
Ij48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIzIiBzdHlsZT0icGFkZGluZy1sZWZ0OjVweDtwYWRk
aW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2YWxpZ249InRvcCIgYWxpZ249ImxlZnQiPjxhIGhy
ZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+PGltZyBzcmM9Imh0
dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xvZ28ucG5nIiBhbHQ9IlRlc3NhcmVzIFNBIiB3aWR0
aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0iMCI+PC9hPjwvdGQ+PHRkIHN0eWxlPSJwYWRkaW5n
OjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBw
eCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xk
O2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5NYXR0aGlldSBCYWVydHMgfCBS
JmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBw
eDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIg
aGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHMl
NDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO3RleHQtZGVjb3JhdGlvbjpu
b25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRzQHRlc3Nh
cmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQt
ZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMHB4IiBhbGlnbj0i
bGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQ7Y29sb3I6cmdiKDM3LDgzLDE1NSk7
ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+
PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdi
KDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxh
bmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNwYW4+wqA8L3NwYW4+PGJyPjxhIGhyZWY9Imh0dHBz
Oi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4K090dGln
bmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxnaXVtIiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0
ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPjEgQXZl
bnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEtTmV1dmUsIEJlbGdpdW08L2E+PC90ZD48
L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4K
PC9kaXY+PC9kaXY+PC9kaXY+Cgo8YnI+CjxkaXY+PGJyPjxocj48L2Rpdj48Zm9udCBzaXplPSIx
Ij48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tncm91bmQt
Y29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+RElTQ0xBSU1FUi48L3NwYW4+PGJyIHN0eWxlPSJmb250
LWZhbWlseTpWZXJkYW5hLHNhbnMtc2VyaWY7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwy
NTUpIj48Zm9udCBjb2xvcj0iIzAwMDAwMCIgZmFjZT0iVmVyZGFuYSwgc2Fucy1zZXJpZiIgc3R5
bGU9ImJhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+VGhpcyBlbWFpbCBhbmQgYW55
IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5kZWQg
c29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aG9tIHRo
ZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJv
ciBwbGVhc2Ugbm90aWZ5IHRoZSBzeXN0ZW0gbWFuYWdlci4gVGhpcyBtZXNzYWdlIGNvbnRhaW5z
IGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIGlu
ZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgeW91IHNo
b3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUgb3IgY29weSB0aGlzIGUtbWFpbC4gUGxl
YXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGUtbWFpbCBpZiB5b3UgaGF2ZSBy
ZWNlaXZlZCB0aGlzIGUtbWFpbCBieSBtaXN0YWtlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwgZnJv
bSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCB5b3Ug
YXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29weWluZywgZGlzdHJpYnV0aW5nIG9yIHRh
a2luZyBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlzIGluZm9y
bWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPC9mb250PjwvZm9udD4=
--===============3985438349715501431==--
