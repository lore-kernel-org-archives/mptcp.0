Content-Type: multipart/mixed; boundary="===============2918896159317767345=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Fri, 27 Apr 2018 19:16:34 +0200
Message-ID: <28477775-17f7-e35c-20b4-c11b2f1aebcb@tessares.net>
In-Reply-To: alpine.OSX.2.21.1804251131080.2926@jateran-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 561

--===============2918896159317767345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Following yesterday's discussion about NetDev 0x12, here is a =

proposition of mail to send to NetDev committee. I already put some =

comments. Note that I have followed the submission guidelines from: =

https://www.netdevconf.org/0x12/submit-proposal.html#proposals

Please comment it before Monday morning. Sorry for the rush but the =

deadline is the 1st of May :)

 > * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat =

Martineau (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and =

myself, Matthieu Baerts (Tessares)

I wrote down the names of people who participated in the discussion in =

the ML and during the weekly meetings. I can add more people if more =

people would like to join the preparation and presentation of this tutorial.
@Christoph, Mat, Peter, Ossama: can I write your names there?

 > * Title of the submission: MPTCP: from the basic to an upstreamable base

We certainly need a better title, please comment!

  > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on

"hands-on" seems to be the correct one according to the Submission Types.
https://www.netdevconf.org/0x12/submit-proposal.html#types

 > * Submission type (one of talk, presentation, workshop): tutorial, =

instructor-led sessions (minimum 1 hour long and not to exceed 1.5 =

hours. The instructor will go over the technology either through code =

review or execution and interact with the attendees.)

I guess there is a typo here: presentation should be replaced by =

tutorial in the guidelines.

 > Estimate of length of time for presentation: 1h

That's what we agreed yesterday but I can change.

 > Affiliations of submitters (needed for conflict of interest check): =

Apple, Intel, Tessares

 > Description of proposal:
 >     A project to add an implementation of the MultiPath TCP protocol =

to the Linux kernel is in progress by a small community. The goal of =

this tutorial is to discover what is this TCP extension (RFC 6824), what =

are the different use-cases already in production by some companies and =

what are the challenges to upstream MPTCP. We hope having interactive =

discussions and getting feedback from experienced developers will help =

us in this task of easily bringing MPTCP to all Linux users, a =

technology already used by millions of people.
 >     In a bit more detail, we will start with a basic introduction of =

MPTCP. A few use-cases will be presented with a demo to explain how =

useful this protocol is in today's Internet and how it can be extended =

with API's like Netlink and BPF. Then we will have some explanations =

about how MPTCP is currently implemented. This current implementation is =

quite intrusive and that is certainly not something we would like to =

have upstream. We would like to express what we have in mind to change =

that, with some samples and initiate discussions.
 >     For more information about this project: =

https://github.com/multipath-tcp/mptcp_net-next/wiki

Please feel free to comment this as well. We are still far from the max =

350 words limit we found last time. But on the other hand, I can no =

longer find this limit on their website :)

Thank you for your help!

Have a good day/evening,
Matthieu

On 25/04/2018 21:58, Mat Martineau wrote:
> =

> Hi Matthieu -
> =

> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
> =

>> Hello,
>>
>>
>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to 13th, 2=
018.
>>
>>
>> We already talked about this event on this ML and at our weekly =

>> meetings but here is a summary of the discussions we had:
>>
>> =C2=A0- we would like to have a presentation there mainly to get feedbac=
k =

>> and advice from other kernel developers
>> =C2=A0- a presentation would clearly indicate that this MPTCP Upstream =

>> project exists and we could get help from more developers
>> =C2=A0- we would like to indicate that having MPTCP upstream is asked by =

>> different companies, some are even ready to contribute ; it is then =

>> important to have MPTCP upstream
>>
>>
>> Also note that:
>>
>> =C2=A0- David Miller will not be present in Montr=C3=A9al [1] but other =
main =

>> contributors should be there (we don't have a list)
> =

> Side note, in the past day David reiterated his statement about not =

> attending or supporting the conference:
> =

> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2
> =

>> =C2=A0- A presentation by Octavian Purdila about "MPTCP Upstreaming" has =

>> already been given in 2015 (NetDev 0.1) [2]
>> =C2=A0- 3 types of presentation are available: talks, tutorials and =

>> workshops [3]
>> =C2=A0- Call for Presentation Proposals closes on May 1st, 2018.
>>
>>
>> The current idea we briefly discussed during our weekly meetings is to =

>> give a tutorial:
>>
>> =C2=A0- It is not useful to give almost the same presentation as the one=
 of =

>> Octavian
>> =C2=A0- It will allow us more flexibility somehow to explain what is MPT=
CP, =

>> the different use-cases, why it is important to have it upstream and =

>> what problems we are currently facing.
>> =C2=A0- David Miller and many other kernel developers will go to LPC in =

>> November: a good place to give a talk this time.
>>
>>
>> Do you have any ideas on what we could show in this tutorial?
>>
>>
>> I recently discussed with my colleague Olivier Bonaventure who has a =

>> lot of experiences in giving different introductions and more about =

>> MPTCP and here is what he suggests:
>>
>> =C2=A0- A first part about a basic introduction of MPTCP
>> =C2=A0- Indicate different use-cases -- if possible with a "closed demo"=
 to =

>> be sure it is working -- asking people to setup something is not easy =

>> in 1h, max 1h30.
> =

>  From the description at [3], either "instructor-led" 60-90 minute =

> tutorials or "student-participation" 2-3 hour sessions are possible. The =

> closed demo maps well to their "instructor-led" category. Looking at the =

> schedule, the past two Netdev Conferences have had one tutorial each, of =

> 60-70 minutes. I think it helps to be closer to an hour in length to =

> hold the audience's attention.
> =

>> =C2=A0- Then trying to have interactive discussions or explanations abou=
t =

>> how MPTCP is currently implemented or should be implemented if it goes =

>> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we need =

>> to support middleboxes, we need to link subflows of the same =

>> connection together, we need a scheduler, a PM, etc.
> =

> It's difficult to predict how interactive an audience will be. I've only =

> attended one Netdev Conference, and it seemed like there were a lot more =

> people with expertise and interest in drivers, lower layers (XDP, BPF, =

> TC, netfilter), and network topology/simulation. Discussion around =

> middlebox support and the userspace API might have more audience =

> interaction. If we want to drive a discussion, we could try to strike a =

> balance between topics for the broader audience and those with more =

> knowledge of TCP internals. (Hopefully some TCP internals people are =

> still planning to attend)
> =

>> =C2=A0- Of course, we should focus our discussions on the upstreaming =

>> aspect, e.g. reducing the footprint of MPTCP in the current TCP stack: =

>> what are we allow to do, what not. It is linked to many previous =

>> discussions we had on this ML, e.g. why we need more indirect function =

>> calls and how to reduce the impact, etc.
> =

> The previous talk ([2]) had a section like this. I haven't watched it =

> recently, I should look at it again to see what kind of questions the =

> audience was asking. As you mentioned above we should be careful to have =

> new content compared to the previous session.
> =

>> =C2=A0- If we have time, we could discuss about how users could interact =

>> with MPTCP: enable it per connection, control the path manager, maybe =

>> the scheduler, etc.
>>
>>
>> What do you think about this? Feel free to comment and even propose =

>> completely different ideas!
> =

> Thank you for outlining these ideas. I see that this topic is on our =

> meeting agenda so it will be good to discuss the tutorial there.
> =

> =

>> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
> =

> -- =

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

--===============2918896159317767345==--
