Content-Type: multipart/mixed; boundary="===============6038630258538169165=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 08:37:01 -0700
Message-ID: <alpine.OSX.2.21.1804300809340.4562@seskerx-mobl.amr.corp.intel.com>
In-Reply-To: CAKuKrBkv0Cd3n326c=zCoCc3isspfxY6MyP9yx7NADowH-KAnA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 565

--===============6038630258538169165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sun, 29 Apr 2018, Matthieu Baerts wrote:

> Hi Mat,
> =

> Thank you for your review and input!
> =

> On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <mathew.j.martineau(a)linu=
x.intel.com> wrote:
>
>       Hi Matthieu -
>
>       On Fri, 27 Apr 2018, Matthieu Baerts wrote:
>
>             Hello,
>
>             Following yesterday's discussion about NetDev 0x12, here is a=
 proposition of mail to send to NetDev committee. I
>             already put some comments. Note that I have followed the subm=
ission guidelines from:
>             https://www.netdevconf.org/0x12/submit-proposal.html#proposals
>
>             Please comment it before Monday morning. Sorry for the rush b=
ut the deadline is the 1st of May :)
>
>                   * Name(s) of the submitter(s): Christoph Paasch (Apple)=
, Mat Martineau
>
>             (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and mys=
elf, Matthieu Baerts (Tessares)
>
>             I wrote down the names of people who participated in the disc=
ussion in the ML and during the weekly meetings. I can
>             add more people if more people would like to join the prepara=
tion and presentation of this tutorial.
>             @Christoph, Mat, Peter, Ossama: can I write your names there?
> =

>
>       Ossama won't be able to attend. It looks like most sessions have 1 =
or 2 presenters, so I don't know if 4 is too many. I'm sure
>       they'll give us some feedback if they want to limit the number of p=
resenters.
> =

> =

> OK thank you!
> Yes indeed, I am sure they will say something if we are too many.
>
>                   * Title of the submission: MPTCP: from the basic to an =
upstreamable base
> =

>
>             We certainly need a better title, please comment!
> =

>
>       "Multipath TCP: Present Use Cases and an Upstream Future" ?
> =

> =

> I was trying to find something that catch the attention but it is maybe n=
ot needed for these kind of presentation.
>
>             > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
>
>             "hands-on" seems to be the correct one according to the Submi=
ssion Types.
>             https://www.netdevconf.org/0x12/submit-proposal.html#types
> =

>
>       It's a little bit of "nuts & bolts" too, but I agree that hands-on =
is the better match.
> =

> =

> Thank you!
>
>                   * Submission type (one of talk, presentation, workshop)=
: tutorial,
>
>             instructor-led sessions (minimum 1 hour long and not to excee=
d 1.5 hours. The instructor will go over the technology
>             either through code review or execution and interact with the=
 attendees.)
>
>             I guess there is a typo here: presentation should be replaced=
 by tutorial in the guidelines.
>
>                   Estimate of length of time for presentation: 1h
> =

>
>             That's what we agreed yesterday but I can change.
>
>                   Affiliations of submitters (needed for conflict of inte=
rest check): Apple,
>
>             Intel, Tessares
>
>                   Description of proposal:
>                   =C2=A0 =C2=A0 A project to add an implementation of the=
 MultiPath TCP protocol to the
>
>             Linux kernel is in progress by a small community. The goal of=
 this tutorial is to discover what is this TCP extension
>             (RFC 6824), what are the different use-cases already in produ=
ction by some companies and what are the challenges to
>             upstream MPTCP. We hope having interactive discussions and ge=
tting feedback from experienced developers will help us
>             in this task of easily bringing MPTCP to all Linux users, a t=
echnology already used by millions of people.
> =

>
>                   =C2=A0 =C2=A0 In a bit more detail, we will start with =
a basic introduction of MPTCP.
>
>             A few use-cases will be presented with a demo to explain how =
useful this protocol is in today's Internet and how it
>             can be extended with API's like Netlink and BPF.
> =

>
>       I recognize how Netlink is associated with a userspace path manager=
, but what's the BPF extensibility you're referring to?
> =

> =

> It was only to mention that it would be possible to extend MPTCP with eBP=
F.
> Even if it is not already available in the current Open-Source implementa=
tion, there is already the possibility to get a version with a
> programmable scheduler: https://progmp.net

If we don't have something specific to our effort with BPF, I'm not sure =

it belongs in the summary. But I don't have a strong opinion about it.

>
>             Then we will have some explanations about how MPTCP is curren=
tly implemented. This current implementation is quite
>             intrusive and that is certainly not something we would like t=
o have upstream. We would like to express what we have
>             in mind to change that, with some samples and initiate discus=
sions.
> =

>
>       My edit of the above:
>
>       """
>
>       A community project is underway to add Multipath TCP to the upstrea=
m Linux kernel. This tutorial will introduce the audience to
>       this TCP extension (RFC 6824), show some use cases already in produ=
ction, and discuss the challenges in converging on an upstream
>       MPTCP implementation.
> =

> =

> Should we insist on the "discussion" part? Like saying: "discuss with the=
 audience"? "have interactive discussions"?
> It is maybe not needed but it was mainly to express the interactivity, it=
 is a tutorial, not just a "simple" presentation.

I think it's ok to mention that - while I left the word "discuss" in there =

for that reason, maybe that's not obvious or clear enough.

>
>       We will use the current MPTCP implementation to demonstrate the uti=
lity of the protocol on today's internet, and to show how this
>       implementation can currently be extended with netlink and BPF. This=
 not only has practical application for deploying MPTCP now,
>       but also illustrates how the APIs and code will need to evolve in o=
rder to properly coexist with the optimized Linux TCP core we
>       all rely on. We will discuss our ideas for bringing MPTCP to the up=
stream kernel so the technology is available to all Linux
>       users.
> =

> =

> To "attract" people, should we mention that the current implementation is=
 already used by millions of users?
> I like how your improve the last bit :-)

Sure. I liked that in your text, but ran out of time figuring out how to =

fit it in to the last sentence :)

>
>       """
>
>       Feel free to edit/merge/expand/discard as needed :)
> =

> =

> Thank you for your edit, it is indeed cleaner!
>
>                   =C2=A0 =C2=A0 For more information about this project:
>
>             https://github.com/multipath-tcp/mptcp_net-next/wiki
> =

> =

> I guess I can keep this, right?

Yes, that was my intent.


Thanks,

Mat


>
>             Please feel free to comment this as well. We are still far fr=
om the max 350 words limit we found last time. But on
>             the other hand, I can no longer find this limit on their webs=
ite :)
> =

>
>       Hope the above is helpful. Thanks again for your work on this propo=
sal.
> =

> =

> Yes it is, thank you for your help!
> =

> Matthieu
> =

> =

>
>       Mat
> =

> =

>
>             Thank you for your help!
>
>             Have a good day/evening,
>             Matthieu
>
>             On 25/04/2018 21:58, Mat Martineau wrote:
>
>                   Hi Matthieu -
>
>                   On Fri, 20 Apr 2018, Matthieu Baerts wrote:
>
>                         Hello,
> =

>
>                         NetDev 0x12 is coming to Montr=C3=A9al this summe=
r: July 11th to 13th, 2018.
> =

>
>                         We already talked about this event on this ML and=
 at our weekly meetings but here is a
>                         summary of the discussions we had:
>
>                         =C2=A0- we would like to have a presentation ther=
e mainly to get feedback and advice from other
>                         kernel developers
>                         =C2=A0- a presentation would clearly indicate tha=
t this MPTCP Upstream project exists and we could
>                         get help from more developers
>                         =C2=A0- we would like to indicate that having MPT=
CP upstream is asked by different companies, some
>                         are even ready to contribute ; it is then importa=
nt to have MPTCP upstream
> =

>
>                         Also note that:
>
>                         =C2=A0- David Miller will not be present in Montr=
=C3=A9al [1] but other main contributors should be
>                         there (we don't have a list)
> =

>
>                   Side note, in the past day David reiterated his stateme=
nt about not attending or supporting the
>                   conference:
>
>                   https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301=
&w=3D2
>
>                         =C2=A0- A presentation by Octavian Purdila about =
"MPTCP Upstreaming" has already been given in
>                         2015 (NetDev 0.1) [2]
>                         =C2=A0- 3 types of presentation are available: ta=
lks, tutorials and workshops [3]
>                         =C2=A0- Call for Presentation Proposals closes on=
 May 1st, 2018.
> =

>
>                         The current idea we briefly discussed during our =
weekly meetings is to give a tutorial:
>
>                         =C2=A0- It is not useful to give almost the same =
presentation as the one of Octavian
>                         =C2=A0- It will allow us more flexibility somehow=
 to explain what is MPTCP, the different
>                         use-cases, why it is important to have it upstrea=
m and what problems we are currently facing.
>                         =C2=A0- David Miller and many other kernel develo=
pers will go to LPC in November: a good place to
>                         give a talk this time.
> =

>
>                         Do you have any ideas on what we could show in th=
is tutorial?
> =

>
>                         I recently discussed with my colleague Olivier Bo=
naventure who has a lot of experiences in
>                         giving different introductions and more about MPT=
CP and here is what he suggests:
>
>                         =C2=A0- A first part about a basic introduction o=
f MPTCP
>                         =C2=A0- Indicate different use-cases -- if possib=
le with a "closed demo" to be sure it is working
>                         -- asking people to setup something is not easy i=
n 1h, max 1h30.
> =

>
>                   =C2=A0From the description at [3], either "instructor-l=
ed" 60-90 minute tutorials or "student-participation"
>                   2-3 hour sessions are possible. The closed demo maps we=
ll to their "instructor-led" category. Looking at
>                   the schedule, the past two Netdev Conferences have had =
one tutorial each, of 60-70 minutes. I think it
>                   helps to be closer to an hour in length to hold the aud=
ience's attention.
>
>                         =C2=A0- Then trying to have interactive discussio=
ns or explanations about how MPTCP is currently
>                         implemented or should be implemented if it goes u=
pstream, e.g.: for MPTCP, we need to have
>                         extra TCP Options, we need to support middleboxes=
, we need to link subflows of the same
>                         connection together, we need a scheduler, a PM, e=
tc.
> =

>
>                   It's difficult to predict how interactive an audience w=
ill be. I've only attended one Netdev Conference,
>                   and it seemed like there were a lot more people with ex=
pertise and interest in drivers, lower layers
>                   (XDP, BPF, TC, netfilter), and network topology/simulat=
ion. Discussion around middlebox support and the
>                   userspace API might have more audience interaction. If =
we want to drive a discussion, we could try to
>                   strike a balance between topics for the broader audienc=
e and those with more knowledge of TCP internals.
>                   (Hopefully some TCP internals people are still planning=
 to attend)
>
>                         =C2=A0- Of course, we should focus our discussion=
s on the upstreaming aspect, e.g. reducing the
>                         footprint of MPTCP in the current TCP stack: what=
 are we allow to do, what not. It is linked
>                         to many previous discussions we had on this ML, e=
.g. why we need more indirect function calls
>                         and how to reduce the impact, etc.
> =

>
>                   The previous talk ([2]) had a section like this. I have=
n't watched it recently, I should look at it again
>                   to see what kind of questions the audience was asking. =
As you mentioned above we should be careful to
>                   have new content compared to the previous session.
>
>                         =C2=A0- If we have time, we could discuss about h=
ow users could interact with MPTCP: enable it per
>                         connection, control the path manager, maybe the s=
cheduler, etc.
> =

>
>                         What do you think about this? Feel free to commen=
t and even propose completely different
>                         ideas!
> =

>
>                   Thank you for outlining these ideas. I see that this to=
pic is on our meeting agenda so it will be good to
>                   discuss the tutorial there.
> =

>
>                         [1] https://lists.01.org/pipermail/mptcp/2018-Mar=
ch/000379.html
>                         [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>                         [3] https://www.netdevconf.org/0x12/submit-propos=
al.html

--
Mat Martineau
Intel OTC

--===============6038630258538169165==--
