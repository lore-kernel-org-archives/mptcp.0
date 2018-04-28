Content-Type: multipart/mixed; boundary="===============2651997900318049132=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Fri, 27 Apr 2018 17:44:10 -0700
Message-ID: <alpine.OSX.2.21.1804271605590.34300@rabrown-mobl8.amr.corp.intel.com>
In-Reply-To: 28477775-17f7-e35c-20b4-c11b2f1aebcb@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 562

--===============2651997900318049132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Matthieu -

On Fri, 27 Apr 2018, Matthieu Baerts wrote:

> Hello,
>
> Following yesterday's discussion about NetDev 0x12, here is a proposition=
 of =

> mail to send to NetDev committee. I already put some comments. Note that =
I =

> have followed the submission guidelines from: =

> https://www.netdevconf.org/0x12/submit-proposal.html#proposals
>
> Please comment it before Monday morning. Sorry for the rush but the deadl=
ine =

> is the 1st of May :)
>
>> * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat Martineau =

> (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and myself, Matthie=
u =

> Baerts (Tessares)
>
> I wrote down the names of people who participated in the discussion in th=
e ML =

> and during the weekly meetings. I can add more people if more people woul=
d =

> like to join the preparation and presentation of this tutorial.
> @Christoph, Mat, Peter, Ossama: can I write your names there?

Ossama won't be able to attend. It looks like most sessions have 1 or 2 =

presenters, so I don't know if 4 is too many. I'm sure they'll give us =

some feedback if they want to limit the number of presenters.

>
>> * Title of the submission: MPTCP: from the basic to an upstreamable base
>
> We certainly need a better title, please comment!

"Multipath TCP: Present Use Cases and an Upstream Future" ?

>
> > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
>
> "hands-on" seems to be the correct one according to the Submission Types.
> https://www.netdevconf.org/0x12/submit-proposal.html#types

It's a little bit of "nuts & bolts" too, but I agree that hands-on is the =

better match.

>
>> * Submission type (one of talk, presentation, workshop): tutorial, =

> instructor-led sessions (minimum 1 hour long and not to exceed 1.5 hours.=
 The =

> instructor will go over the technology either through code review or =

> execution and interact with the attendees.)
>
> I guess there is a typo here: presentation should be replaced by tutorial=
 in =

> the guidelines.
>
>> Estimate of length of time for presentation: 1h
>
> That's what we agreed yesterday but I can change.
>
>> Affiliations of submitters (needed for conflict of interest check): Appl=
e, =

> Intel, Tessares
>
>> Description of proposal:
>>     A project to add an implementation of the MultiPath TCP protocol to =
the =

> Linux kernel is in progress by a small community. The goal of this tutori=
al =

> is to discover what is this TCP extension (RFC 6824), what are the differ=
ent =

> use-cases already in production by some companies and what are the challe=
nges =

> to upstream MPTCP. We hope having interactive discussions and getting =

> feedback from experienced developers will help us in this task of easily =

> bringing MPTCP to all Linux users, a technology already used by millions =
of =

> people.

>>     In a bit more detail, we will start with a basic introduction of MPT=
CP. =

> A few use-cases will be presented with a demo to explain how useful this =

> protocol is in today's Internet and how it can be extended with API's lik=
e =

> Netlink and BPF.

I recognize how Netlink is associated with a userspace path manager, but =

what's the BPF extensibility you're referring to?

> Then we will have some explanations about how MPTCP is =

> currently implemented. This current implementation is quite intrusive and =

> that is certainly not something we would like to have upstream. We would =
like =

> to express what we have in mind to change that, with some samples and =

> initiate discussions.

My edit of the above:

"""

A community project is underway to add Multipath TCP to the upstream Linux =

kernel. This tutorial will introduce the audience to this TCP extension =

(RFC 6824), show some use cases already in production, and discuss the =

challenges in converging on an upstream MPTCP implementation.

We will use the current MPTCP implementation to demonstrate the utility of =

the protocol on today's internet, and to show how this implementation can =

currently be extended with netlink and BPF. This not only has practical =

application for deploying MPTCP now, but also illustrates how the APIs and =

code will need to evolve in order to properly coexist with the optimized =

Linux TCP core we all rely on. We will discuss our ideas for bringing =

MPTCP to the upstream kernel so the technology is available to all Linux =

users.

"""

Feel free to edit/merge/expand/discard as needed :)

>>     For more information about this project: =

> https://github.com/multipath-tcp/mptcp_net-next/wiki
>
> Please feel free to comment this as well. We are still far from the max 3=
50 =

> words limit we found last time. But on the other hand, I can no longer fi=
nd =

> this limit on their website :)

Hope the above is helpful. Thanks again for your work on this proposal.


Mat


>
> Thank you for your help!
>
> Have a good day/evening,
> Matthieu
>
> On 25/04/2018 21:58, Mat Martineau wrote:
>> =

>> Hi Matthieu -
>> =

>> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
>> =

>>> Hello,
>>> =

>>> =

>>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to 13th, =
2018.
>>> =

>>> =

>>> We already talked about this event on this ML and at our weekly meeting=
s =

>>> but here is a summary of the discussions we had:
>>>
>>> =C2=A0- we would like to have a presentation there mainly to get feedba=
ck and =

>>> advice from other kernel developers
>>> =C2=A0- a presentation would clearly indicate that this MPTCP Upstream =
project =

>>> exists and we could get help from more developers
>>> =C2=A0- we would like to indicate that having MPTCP upstream is asked b=
y =

>>> different companies, some are even ready to contribute ; it is then =

>>> important to have MPTCP upstream
>>> =

>>> =

>>> Also note that:
>>>
>>> =C2=A0- David Miller will not be present in Montr=C3=A9al [1] but other=
 main =

>>> contributors should be there (we don't have a list)
>> =

>> Side note, in the past day David reiterated his statement about not =

>> attending or supporting the conference:
>> =

>> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2
>>
>>> =C2=A0- A presentation by Octavian Purdila about "MPTCP Upstreaming" ha=
s =

>>> already been given in 2015 (NetDev 0.1) [2]
>>> =C2=A0- 3 types of presentation are available: talks, tutorials and wor=
kshops =

>>> [3]
>>> =C2=A0- Call for Presentation Proposals closes on May 1st, 2018.
>>> =

>>> =

>>> The current idea we briefly discussed during our weekly meetings is to =

>>> give a tutorial:
>>>
>>> =C2=A0- It is not useful to give almost the same presentation as the on=
e of =

>>> Octavian
>>> =C2=A0- It will allow us more flexibility somehow to explain what is MP=
TCP, the =

>>> different use-cases, why it is important to have it upstream and what =

>>> problems we are currently facing.
>>> =C2=A0- David Miller and many other kernel developers will go to LPC in =

>>> November: a good place to give a talk this time.
>>> =

>>> =

>>> Do you have any ideas on what we could show in this tutorial?
>>> =

>>> =

>>> I recently discussed with my colleague Olivier Bonaventure who has a lo=
t =

>>> of experiences in giving different introductions and more about MPTCP a=
nd =

>>> here is what he suggests:
>>>
>>> =C2=A0- A first part about a basic introduction of MPTCP
>>> =C2=A0- Indicate different use-cases -- if possible with a "closed demo=
" to be =

>>> sure it is working -- asking people to setup something is not easy in 1=
h, =

>>> max 1h30.
>>
>>  From the description at [3], either "instructor-led" 60-90 minute =

>> tutorials or "student-participation" 2-3 hour sessions are possible. The =

>> closed demo maps well to their "instructor-led" category. Looking at the =

>> schedule, the past two Netdev Conferences have had one tutorial each, of =

>> 60-70 minutes. I think it helps to be closer to an hour in length to hol=
d =

>> the audience's attention.
>>
>>> =C2=A0- Then trying to have interactive discussions or explanations abo=
ut how =

>>> MPTCP is currently implemented or should be implemented if it goes =

>>> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we need t=
o =

>>> support middleboxes, we need to link subflows of the same connection =

>>> together, we need a scheduler, a PM, etc.
>> =

>> It's difficult to predict how interactive an audience will be. I've only =

>> attended one Netdev Conference, and it seemed like there were a lot more =

>> people with expertise and interest in drivers, lower layers (XDP, BPF, T=
C, =

>> netfilter), and network topology/simulation. Discussion around middlebox =

>> support and the userspace API might have more audience interaction. If w=
e =

>> want to drive a discussion, we could try to strike a balance between top=
ics =

>> for the broader audience and those with more knowledge of TCP internals. =

>> (Hopefully some TCP internals people are still planning to attend)
>>
>>> =C2=A0- Of course, we should focus our discussions on the upstreaming a=
spect, =

>>> e.g. reducing the footprint of MPTCP in the current TCP stack: what are=
 we =

>>> allow to do, what not. It is linked to many previous discussions we had=
 on =

>>> this ML, e.g. why we need more indirect function calls and how to reduc=
e =

>>> the impact, etc.
>> =

>> The previous talk ([2]) had a section like this. I haven't watched it =

>> recently, I should look at it again to see what kind of questions the =

>> audience was asking. As you mentioned above we should be careful to have =

>> new content compared to the previous session.
>>
>>> =C2=A0- If we have time, we could discuss about how users could interac=
t with =

>>> MPTCP: enable it per connection, control the path manager, maybe the =

>>> scheduler, etc.
>>> =

>>> =

>>> What do you think about this? Feel free to comment and even propose =

>>> completely different ideas!
>> =

>> Thank you for outlining these ideas. I see that this topic is on our =

>> meeting agenda so it will be good to discuss the tutorial there.
>> =

>> =

>>> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
>>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
>>

--
Mat Martineau
Intel OTC

--===============2651997900318049132==--
