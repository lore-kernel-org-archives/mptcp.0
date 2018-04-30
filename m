Content-Type: multipart/mixed; boundary="===============2296651469799019601=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 09:25:01 -0700
Message-ID: <20180430162501.GO19260@MacBook-Pro-6.local>
In-Reply-To: alpine.OSX.2.21.1804300809340.4562@seskerx-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 570

--===============2296651469799019601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30/04/18 - 08:37:01, Mat Martineau wrote:
> =

> On Sun, 29 Apr 2018, Matthieu Baerts wrote:
> =

> > Hi Mat,
> > =

> > Thank you for your review and input!
> > =

> > On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <mathew.j.martineau(a)li=
nux.intel.com> wrote:
> > =

> >       Hi Matthieu -
> > =

> >       On Fri, 27 Apr 2018, Matthieu Baerts wrote:
> > =

> >             Hello,
> > =

> >             Following yesterday's discussion about NetDev 0x12, here is=
 a proposition of mail to send to NetDev committee. I
> >             already put some comments. Note that I have followed the su=
bmission guidelines from:
> >             https://www.netdevconf.org/0x12/submit-proposal.html#propos=
als
> > =

> >             Please comment it before Monday morning. Sorry for the rush=
 but the deadline is the 1st of May :)
> > =

> >                   * Name(s) of the submitter(s): Christoph Paasch (Appl=
e), Mat Martineau
> > =

> >             (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and m=
yself, Matthieu Baerts (Tessares)
> > =

> >             I wrote down the names of people who participated in the di=
scussion in the ML and during the weekly meetings. I can
> >             add more people if more people would like to join the prepa=
ration and presentation of this tutorial.
> >             @Christoph, Mat, Peter, Ossama: can I write your names ther=
e?
> > =

> > =

> >       Ossama won't be able to attend. It looks like most sessions have =
1 or 2 presenters, so I don't know if 4 is too many. I'm sure
> >       they'll give us some feedback if they want to limit the number of=
 presenters.
> > =

> > =

> > OK thank you!
> > Yes indeed, I am sure they will say something if we are too many.
> > =

> >                   * Title of the submission: MPTCP: from the basic to a=
n upstreamable base
> > =

> > =

> >             We certainly need a better title, please comment!
> > =

> > =

> >       "Multipath TCP: Present Use Cases and an Upstream Future" ?
> > =

> > =

> > I was trying to find something that catch the attention but it is maybe=
 not needed for these kind of presentation.
> > =

> >             > * Label (one of moonshot, nuts'n bolts, hands-on): hands-=
on
> > =

> >             "hands-on" seems to be the correct one according to the Sub=
mission Types.
> >             https://www.netdevconf.org/0x12/submit-proposal.html#types
> > =

> > =

> >       It's a little bit of "nuts & bolts" too, but I agree that hands-o=
n is the better match.
> > =

> > =

> > Thank you!
> > =

> >                   * Submission type (one of talk, presentation, worksho=
p): tutorial,
> > =

> >             instructor-led sessions (minimum 1 hour long and not to exc=
eed 1.5 hours. The instructor will go over the technology
> >             either through code review or execution and interact with t=
he attendees.)
> > =

> >             I guess there is a typo here: presentation should be replac=
ed by tutorial in the guidelines.
> > =

> >                   Estimate of length of time for presentation: 1h
> > =

> > =

> >             That's what we agreed yesterday but I can change.
> > =

> >                   Affiliations of submitters (needed for conflict of in=
terest check): Apple,
> > =

> >             Intel, Tessares
> > =

> >                   Description of proposal:
> >                   =C2=A0 =C2=A0 A project to add an implementation of t=
he MultiPath TCP protocol to the
> > =

> >             Linux kernel is in progress by a small community. The goal =
of this tutorial is to discover what is this TCP extension
> >             (RFC 6824), what are the different use-cases already in pro=
duction by some companies and what are the challenges to
> >             upstream MPTCP. We hope having interactive discussions and =
getting feedback from experienced developers will help us
> >             in this task of easily bringing MPTCP to all Linux users, a=
 technology already used by millions of people.
> > =

> > =

> >                   =C2=A0 =C2=A0 In a bit more detail, we will start wit=
h a basic introduction of MPTCP.
> > =

> >             A few use-cases will be presented with a demo to explain ho=
w useful this protocol is in today's Internet and how it
> >             can be extended with API's like Netlink and BPF.
> > =

> > =

> >       I recognize how Netlink is associated with a userspace path manag=
er, but what's the BPF extensibility you're referring to?
> > =

> > =

> > It was only to mention that it would be possible to extend MPTCP with e=
BPF.
> > Even if it is not already available in the current Open-Source implemen=
tation, there is already the possibility to get a version with a
> > programmable scheduler: https://progmp.net
> =

> If we don't have something specific to our effort with BPF, I'm not sure =
it
> belongs in the summary. But I don't have a strong opinion about it.

I agree that we don't need BPF in the summary here. We can talk about its
potential during the presentation though. But, here in the summary it is a
bit more distracting IMO.

> =

> > =

> >             Then we will have some explanations about how MPTCP is curr=
ently implemented. This current implementation is quite
> >             intrusive and that is certainly not something we would like=
 to have upstream. We would like to express what we have
> >             in mind to change that, with some samples and initiate disc=
ussions.
> > =

> > =

> >       My edit of the above:
> > =

> >       """
> > =

> >       A community project is underway to add Multipath TCP to the upstr=
eam Linux kernel. This tutorial will introduce the audience to
> >       this TCP extension (RFC 6824), show some use cases already in pro=
duction, and discuss the challenges in converging on an upstream
> >       MPTCP implementation.
> > =

> > =

> > Should we insist on the "discussion" part? Like saying: "discuss with t=
he audience"? "have interactive discussions"?
> > It is maybe not needed but it was mainly to express the interactivity, =
it is a tutorial, not just a "simple" presentation.
> =

> I think it's ok to mention that - while I left the word "discuss" in there
> for that reason, maybe that's not obvious or clear enough.

I think that "discuss with the audience" or "have interactive discussions"
makes it more clear what we want to achieve.



Christoph

> >       We will use the current MPTCP implementation to demonstrate the u=
tility of the protocol on today's internet, and to show how this
> >       implementation can currently be extended with netlink and BPF. Th=
is not only has practical application for deploying MPTCP now,
> >       but also illustrates how the APIs and code will need to evolve in=
 order to properly coexist with the optimized Linux TCP core we
> >       all rely on. We will discuss our ideas for bringing MPTCP to the =
upstream kernel so the technology is available to all Linux
> >       users.
> > =

> > =

> > To "attract" people, should we mention that the current implementation =
is already used by millions of users?
> > I like how your improve the last bit :-)
> =

> Sure. I liked that in your text, but ran out of time figuring out how to =
fit
> it in to the last sentence :)
> =

> > =

> >       """
> > =

> >       Feel free to edit/merge/expand/discard as needed :)
> > =

> > =

> > Thank you for your edit, it is indeed cleaner!
> > =

> >                   =C2=A0 =C2=A0 For more information about this project:
> > =

> >             https://github.com/multipath-tcp/mptcp_net-next/wiki
> > =

> > =

> > I guess I can keep this, right?
> =

> Yes, that was my intent.
> =

> =

> Thanks,
> =

> Mat
> =

> =

> > =

> >             Please feel free to comment this as well. We are still far =
from the max 350 words limit we found last time. But on
> >             the other hand, I can no longer find this limit on their we=
bsite :)
> > =

> > =

> >       Hope the above is helpful. Thanks again for your work on this pro=
posal.
> > =

> > =

> > Yes it is, thank you for your help!
> > =

> > Matthieu
> > =

> > =

> > =

> >       Mat
> > =

> > =

> > =

> >             Thank you for your help!
> > =

> >             Have a good day/evening,
> >             Matthieu
> > =

> >             On 25/04/2018 21:58, Mat Martineau wrote:
> > =

> >                   Hi Matthieu -
> > =

> >                   On Fri, 20 Apr 2018, Matthieu Baerts wrote:
> > =

> >                         Hello,
> > =

> > =

> >                         NetDev 0x12 is coming to Montr=C3=A9al this sum=
mer: July 11th to 13th, 2018.
> > =

> > =

> >                         We already talked about this event on this ML a=
nd at our weekly meetings but here is a
> >                         summary of the discussions we had:
> > =

> >                         =C2=A0- we would like to have a presentation th=
ere mainly to get feedback and advice from other
> >                         kernel developers
> >                         =C2=A0- a presentation would clearly indicate t=
hat this MPTCP Upstream project exists and we could
> >                         get help from more developers
> >                         =C2=A0- we would like to indicate that having M=
PTCP upstream is asked by different companies, some
> >                         are even ready to contribute ; it is then impor=
tant to have MPTCP upstream
> > =

> > =

> >                         Also note that:
> > =

> >                         =C2=A0- David Miller will not be present in Mon=
tr=C3=A9al [1] but other main contributors should be
> >                         there (we don't have a list)
> > =

> > =

> >                   Side note, in the past day David reiterated his state=
ment about not attending or supporting the
> >                   conference:
> > =

> >                   https://marc.info/?l=3Dlinux-netdev&m=3D1524668272033=
01&w=3D2
> > =

> >                         =C2=A0- A presentation by Octavian Purdila abou=
t "MPTCP Upstreaming" has already been given in
> >                         2015 (NetDev 0.1) [2]
> >                         =C2=A0- 3 types of presentation are available: =
talks, tutorials and workshops [3]
> >                         =C2=A0- Call for Presentation Proposals closes =
on May 1st, 2018.
> > =

> > =

> >                         The current idea we briefly discussed during ou=
r weekly meetings is to give a tutorial:
> > =

> >                         =C2=A0- It is not useful to give almost the sam=
e presentation as the one of Octavian
> >                         =C2=A0- It will allow us more flexibility someh=
ow to explain what is MPTCP, the different
> >                         use-cases, why it is important to have it upstr=
eam and what problems we are currently facing.
> >                         =C2=A0- David Miller and many other kernel deve=
lopers will go to LPC in November: a good place to
> >                         give a talk this time.
> > =

> > =

> >                         Do you have any ideas on what we could show in =
this tutorial?
> > =

> > =

> >                         I recently discussed with my colleague Olivier =
Bonaventure who has a lot of experiences in
> >                         giving different introductions and more about M=
PTCP and here is what he suggests:
> > =

> >                         =C2=A0- A first part about a basic introduction=
 of MPTCP
> >                         =C2=A0- Indicate different use-cases -- if poss=
ible with a "closed demo" to be sure it is working
> >                         -- asking people to setup something is not easy=
 in 1h, max 1h30.
> > =

> > =

> >                   =C2=A0From the description at [3], either "instructor=
-led" 60-90 minute tutorials or "student-participation"
> >                   2-3 hour sessions are possible. The closed demo maps =
well to their "instructor-led" category. Looking at
> >                   the schedule, the past two Netdev Conferences have ha=
d one tutorial each, of 60-70 minutes. I think it
> >                   helps to be closer to an hour in length to hold the a=
udience's attention.
> > =

> >                         =C2=A0- Then trying to have interactive discuss=
ions or explanations about how MPTCP is currently
> >                         implemented or should be implemented if it goes=
 upstream, e.g.: for MPTCP, we need to have
> >                         extra TCP Options, we need to support middlebox=
es, we need to link subflows of the same
> >                         connection together, we need a scheduler, a PM,=
 etc.
> > =

> > =

> >                   It's difficult to predict how interactive an audience=
 will be. I've only attended one Netdev Conference,
> >                   and it seemed like there were a lot more people with =
expertise and interest in drivers, lower layers
> >                   (XDP, BPF, TC, netfilter), and network topology/simul=
ation. Discussion around middlebox support and the
> >                   userspace API might have more audience interaction. I=
f we want to drive a discussion, we could try to
> >                   strike a balance between topics for the broader audie=
nce and those with more knowledge of TCP internals.
> >                   (Hopefully some TCP internals people are still planni=
ng to attend)
> > =

> >                         =C2=A0- Of course, we should focus our discussi=
ons on the upstreaming aspect, e.g. reducing the
> >                         footprint of MPTCP in the current TCP stack: wh=
at are we allow to do, what not. It is linked
> >                         to many previous discussions we had on this ML,=
 e.g. why we need more indirect function calls
> >                         and how to reduce the impact, etc.
> > =

> > =

> >                   The previous talk ([2]) had a section like this. I ha=
ven't watched it recently, I should look at it again
> >                   to see what kind of questions the audience was asking=
. As you mentioned above we should be careful to
> >                   have new content compared to the previous session.
> > =

> >                         =C2=A0- If we have time, we could discuss about=
 how users could interact with MPTCP: enable it per
> >                         connection, control the path manager, maybe the=
 scheduler, etc.
> > =

> > =

> >                         What do you think about this? Feel free to comm=
ent and even propose completely different
> >                         ideas!
> > =

> > =

> >                   Thank you for outlining these ideas. I see that this =
topic is on our meeting agenda so it will be good to
> >                   discuss the tutorial there.
> > =

> > =

> >                         [1] https://lists.01.org/pipermail/mptcp/2018-M=
arch/000379.html
> >                         [2] https://www.youtube.com/watch?v=3Dwftz2cU5S=
Zs
> >                         [3] https://www.netdevconf.org/0x12/submit-prop=
osal.html
> =

> --
> Mat Martineau
> Intel OTC


--===============2296651469799019601==--
