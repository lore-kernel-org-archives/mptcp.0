Content-Type: multipart/mixed; boundary="===============6735388615715814257=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 11:17:06 -0700
Message-ID: <20180430181705.GV19260@MacBook-Pro-6.local>
In-Reply-To: CAKuKrBnWVy5+g9wszeDxrxbT=Ea3c0a+QTKrJP6Lt5SyaxgcUw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 575

--===============6735388615715814257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30/04/18 - 19:34:10, Matthieu Baerts wrote:
> On Mon, Apr 30, 2018 at 6:18 PM, Christoph Paasch <cpaasch(a)apple.com> w=
rote:
> =

> > On 30/04/18 - 16:26:01, Matthieu Baerts wrote:
> > > Hi Mat, Christoph, Peter, Ossama,
> > >
> > > I will wait for ~10am your time before sending it to let you some tim=
es
> > to
> > > comment this if you want to do so.
> > >
> > > Best regards,
> > > Matthieu
> > >
> > > On Sun, Apr 29, 2018 at 4:08 PM, Matthieu Baerts <
> > > matthieu.baerts(a)tessares.net> wrote:
> > >
> > > > Hi Mat,
> > > >
> > > > Thank you for your review and input!
> > > >
> > > > On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau
> > <mathew.j.martineau(a)linux.
> > > > intel.com> wrote:
> > > >
> > > >>
> > > >> Hi Matthieu -
> > > >>
> > > >> On Fri, 27 Apr 2018, Matthieu Baerts wrote:
> > > >>
> > > >> Hello,
> > > >>>
> > > >>> Following yesterday's discussion about NetDev 0x12, here is a
> > > >>> proposition of mail to send to NetDev committee. I already put so=
me
> > > >>> comments. Note that I have followed the submission guidelines fro=
m:
> > > >>> https://www.netdevconf.org/0x12/submit-proposal.html#proposals
> > > >>>
> > > >>> Please comment it before Monday morning. Sorry for the rush but t=
he
> > > >>> deadline is the 1st of May :)
> > > >>>
> > > >>> * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat
> > Martineau
> > > >>>>
> > > >>> (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and myself,
> > > >>> Matthieu Baerts (Tessares)
> > > >>>
> > > >>> I wrote down the names of people who participated in the discussi=
on
> > in
> > > >>> the ML and during the weekly meetings. I can add more people if m=
ore
> > people
> > > >>> would like to join the preparation and presentation of this tutor=
ial.
> > > >>> @Christoph, Mat, Peter, Ossama: can I write your names there?
> > > >>>
> > > >>
> > > >> Ossama won't be able to attend. It looks like most sessions have 1=
 or
> > 2
> > > >> presenters, so I don't know if 4 is too many. I'm sure they'll give
> > us some
> > > >> feedback if they want to limit the number of presenters.
> > > >>
> > > >
> > > > OK thank you!
> > > > Yes indeed, I am sure they will say something if we are too many.
> > > >
> > > > * Title of the submission: MPTCP: from the basic to an upstreamable
> > base
> > > >>>>
> > > >>>
> > > >>> We certainly need a better title, please comment!
> > > >>>
> > > >>
> > > >> "Multipath TCP: Present Use Cases and an Upstream Future" ?
> > > >>
> > > >
> > > > I was trying to find something that catch the attention but it is m=
aybe
> > > > not needed for these kind of presentation.
> > > >
> > > > > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
> > > >>>
> > > >>> "hands-on" seems to be the correct one according to the Submission
> > Types.
> > > >>> https://www.netdevconf.org/0x12/submit-proposal.html#types
> > > >>>
> > > >>
> > > >> It's a little bit of "nuts & bolts" too, but I agree that hands-on=
 is
> > the
> > > >> better match.
> > > >>
> > > >
> > > > Thank you!
> > > >
> > > > * Submission type (one of talk, presentation, workshop): tutorial,
> > > >>>>
> > > >>> instructor-led sessions (minimum 1 hour long and not to exceed 1.5
> > > >>> hours. The instructor will go over the technology either through =
code
> > > >>> review or execution and interact with the attendees.)
> > > >>>
> > > >>> I guess there is a typo here: presentation should be replaced by
> > > >>> tutorial in the guidelines.
> > > >>>
> > > >>> Estimate of length of time for presentation: 1h
> > > >>>>
> > > >>>
> > > >>> That's what we agreed yesterday but I can change.
> > > >>>
> > > >>> Affiliations of submitters (needed for conflict of interest check=
):
> > > >>>> Apple,
> >
> > I will have to double-check on the affiliation part wrt to Apple.
> >
> > If I don't get a thumbs up, you can simply remove me from the list.
> >
> =

> Do you want me to wait or can I send it today and ask to remove you from
> the list later if needed?

Can you wait a little bit? I am trying to get a hold of the one who can tell
me "yes" or "no".


Christoph

> =

> Matthieu
> =

> =

> >
> > Christoph
> >
> >
> > > >>>>
> > > >>> Intel, Tessares
> > > >>>
> > > >>> Description of proposal:
> > > >>>>     A project to add an implementation of the MultiPath TCP
> > protocol to
> > > >>>> the
> > > >>>>
> > > >>> Linux kernel is in progress by a small community. The goal of this
> > > >>> tutorial is to discover what is this TCP extension (RFC 6824), wh=
at
> > are the
> > > >>> different use-cases already in production by some companies and w=
hat
> > are
> > > >>> the challenges to upstream MPTCP. We hope having interactive
> > discussions
> > > >>> and getting feedback from experienced developers will help us in
> > this task
> > > >>> of easily bringing MPTCP to all Linux users, a technology already
> > used by
> > > >>> millions of people.
> > > >>>
> > > >>
> > > >>     In a bit more detail, we will start with a basic introduction =
of
> > > >>>> MPTCP.
> > > >>>>
> > > >>> A few use-cases will be presented with a demo to explain how usef=
ul
> > this
> > > >>> protocol is in today's Internet and how it can be extended with
> > API's like
> > > >>> Netlink and BPF.
> > > >>>
> > > >>
> > > >> I recognize how Netlink is associated with a userspace path manage=
r,
> > but
> > > >> what's the BPF extensibility you're referring to?
> > > >>
> > > >
> > > > It was only to mention that it would be possible to extend MPTCP wi=
th
> > eBPF.
> > > > Even if it is not already available in the current Open-Source
> > > > implementation, there is already the possibility to get a version w=
ith
> > a
> > > > programmable scheduler: https://progmp.net
> > > >
> > > > Then we will have some explanations about how MPTCP is currently
> > > >>> implemented. This current implementation is quite intrusive and t=
hat
> > is
> > > >>> certainly not something we would like to have upstream. We would
> > like to
> > > >>> express what we have in mind to change that, with some samples and
> > initiate
> > > >>> discussions.
> > > >>>
> > > >>
> > > >> My edit of the above:
> > > >>
> > > >> """
> > > >>
> > > >> A community project is underway to add Multipath TCP to the upstre=
am
> > > >> Linux kernel. This tutorial will introduce the audience to this TCP
> > > >> extension (RFC 6824), show some use cases already in production, a=
nd
> > > >> discuss the challenges in converging on an upstream MPTCP
> > implementation.
> > > >>
> > > >
> > > > Should we insist on the "discussion" part? Like saying: "discuss wi=
th
> > the
> > > > audience"? "have interactive discussions"?
> > > > It is maybe not needed but it was mainly to express the interactivi=
ty,
> > it
> > > > is a tutorial, not just a "simple" presentation.
> > > >
> > > > We will use the current MPTCP implementation to demonstrate the
> > utility of
> > > >> the protocol on today's internet, and to show how this implementat=
ion
> > can
> > > >> currently be extended with netlink and BPF. This not only has
> > practical
> > > >> application for deploying MPTCP now, but also illustrates how the
> > APIs and
> > > >> code will need to evolve in order to properly coexist with the
> > optimized
> > > >> Linux TCP core we all rely on. We will discuss our ideas for bring=
ing
> > MPTCP
> > > >> to the upstream kernel so the technology is available to all Linux
> > users.
> > > >>
> > > >
> > > > To "attract" people, should we mention that the current implementat=
ion
> > is
> > > > already used by millions of users?
> > > > I like how your improve the last bit :-)
> > > >
> > > > """
> > > >>
> > > >> Feel free to edit/merge/expand/discard as needed :)
> > > >>
> > > >
> > > > Thank you for your edit, it is indeed cleaner!
> > > >
> > > >     For more information about this project:
> > > >>>>
> > > >>> https://github.com/multipath-tcp/mptcp_net-next/wiki
> > > >>
> > > >>
> > > > I guess I can keep this, right?
> > > >
> > > > Please feel free to comment this as well. We are still far from the=
 max
> > > >>> 350 words limit we found last time. But on the other hand, I can =
no
> > longer
> > > >>> find this limit on their website :)
> > > >>>
> > > >>
> > > >> Hope the above is helpful. Thanks again for your work on this
> > proposal.
> > > >>
> > > >
> > > > Yes it is, thank you for your help!
> > > >
> > > > Matthieu
> > > >
> > > >
> > > >>
> > > >> Mat
> > > >>
> > > >>
> > > >>
> > > >>
> > > >>> Thank you for your help!
> > > >>>
> > > >>> Have a good day/evening,
> > > >>> Matthieu
> > > >>>
> > > >>> On 25/04/2018 21:58, Mat Martineau wrote:
> > > >>>
> > > >>>>
> > > >>>> Hi Matthieu -
> > > >>>>
> > > >>>> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
> > > >>>>
> > > >>>> Hello,
> > > >>>>>
> > > >>>>>
> > > >>>>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th t=
o 13th,
> > 2018.
> > > >>>>>
> > > >>>>>
> > > >>>>> We already talked about this event on this ML and at our weekly
> > > >>>>> meetings but here is a summary of the discussions we had:
> > > >>>>>
> > > >>>>>  - we would like to have a presentation there mainly to get
> > feedback
> > > >>>>> and advice from other kernel developers
> > > >>>>>  - a presentation would clearly indicate that this MPTCP Upstre=
am
> > > >>>>> project exists and we could get help from more developers
> > > >>>>>  - we would like to indicate that having MPTCP upstream is aske=
d by
> > > >>>>> different companies, some are even ready to contribute ; it is =
then
> > > >>>>> important to have MPTCP upstream
> > > >>>>>
> > > >>>>>
> > > >>>>> Also note that:
> > > >>>>>
> > > >>>>>  - David Miller will not be present in Montr=C3=A9al [1] but ot=
her main
> > > >>>>> contributors should be there (we don't have a list)
> > > >>>>>
> > > >>>>
> > > >>>> Side note, in the past day David reiterated his statement about =
not
> > > >>>> attending or supporting the conference:
> > > >>>>
> > > >>>> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2
> > > >>>>
> > > >>>>  - A presentation by Octavian Purdila about "MPTCP Upstreaming" =
has
> > > >>>>> already been given in 2015 (NetDev 0.1) [2]
> > > >>>>>  - 3 types of presentation are available: talks, tutorials and
> > > >>>>> workshops [3]
> > > >>>>>  - Call for Presentation Proposals closes on May 1st, 2018.
> > > >>>>>
> > > >>>>>
> > > >>>>> The current idea we briefly discussed during our weekly meetings
> > is to
> > > >>>>> give a tutorial:
> > > >>>>>
> > > >>>>>  - It is not useful to give almost the same presentation as the
> > one of
> > > >>>>> Octavian
> > > >>>>>  - It will allow us more flexibility somehow to explain what is
> > MPTCP,
> > > >>>>> the different use-cases, why it is important to have it upstream
> > and what
> > > >>>>> problems we are currently facing.
> > > >>>>>  - David Miller and many other kernel developers will go to LPC=
 in
> > > >>>>> November: a good place to give a talk this time.
> > > >>>>>
> > > >>>>>
> > > >>>>> Do you have any ideas on what we could show in this tutorial?
> > > >>>>>
> > > >>>>>
> > > >>>>> I recently discussed with my colleague Olivier Bonaventure who =
has
> > a
> > > >>>>> lot of experiences in giving different introductions and more
> > about MPTCP
> > > >>>>> and here is what he suggests:
> > > >>>>>
> > > >>>>>  - A first part about a basic introduction of MPTCP
> > > >>>>>  - Indicate different use-cases -- if possible with a "closed
> > demo" to
> > > >>>>> be sure it is working -- asking people to setup something is not
> > easy in
> > > >>>>> 1h, max 1h30.
> > > >>>>>
> > > >>>>
> > > >>>>  From the description at [3], either "instructor-led" 60-90 minu=
te
> > > >>>> tutorials or "student-participation" 2-3 hour sessions are
> > possible. The
> > > >>>> closed demo maps well to their "instructor-led" category. Looking
> > at the
> > > >>>> schedule, the past two Netdev Conferences have had one tutorial
> > each, of
> > > >>>> 60-70 minutes. I think it helps to be closer to an hour in length
> > to hold
> > > >>>> the audience's attention.
> > > >>>>
> > > >>>>  - Then trying to have interactive discussions or explanations a=
bout
> > > >>>>> how MPTCP is currently implemented or should be implemented if =
it
> > goes
> > > >>>>> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we
> > need to
> > > >>>>> support middleboxes, we need to link subflows of the same
> > connection
> > > >>>>> together, we need a scheduler, a PM, etc.
> > > >>>>>
> > > >>>>
> > > >>>> It's difficult to predict how interactive an audience will be. I=
've
> > > >>>> only attended one Netdev Conference, and it seemed like there we=
re
> > a lot
> > > >>>> more people with expertise and interest in drivers, lower layers
> > (XDP, BPF,
> > > >>>> TC, netfilter), and network topology/simulation. Discussion arou=
nd
> > > >>>> middlebox support and the userspace API might have more audience
> > > >>>> interaction. If we want to drive a discussion, we could try to
> > strike a
> > > >>>> balance between topics for the broader audience and those with m=
ore
> > > >>>> knowledge of TCP internals. (Hopefully some TCP internals people
> > are still
> > > >>>> planning to attend)
> > > >>>>
> > > >>>>  - Of course, we should focus our discussions on the upstreaming
> > > >>>>> aspect, e.g. reducing the footprint of MPTCP in the current TCP
> > stack: what
> > > >>>>> are we allow to do, what not. It is linked to many previous
> > discussions we
> > > >>>>> had on this ML, e.g. why we need more indirect function calls a=
nd
> > how to
> > > >>>>> reduce the impact, etc.
> > > >>>>>
> > > >>>>
> > > >>>> The previous talk ([2]) had a section like this. I haven't watch=
ed
> > it
> > > >>>> recently, I should look at it again to see what kind of questions
> > the
> > > >>>> audience was asking. As you mentioned above we should be careful=
 to
> > have
> > > >>>> new content compared to the previous session.
> > > >>>>
> > > >>>>  - If we have time, we could discuss about how users could inter=
act
> > > >>>>> with MPTCP: enable it per connection, control the path manager,
> > maybe the
> > > >>>>> scheduler, etc.
> > > >>>>>
> > > >>>>>
> > > >>>>> What do you think about this? Feel free to comment and even pro=
pose
> > > >>>>> completely different ideas!
> > > >>>>>
> > > >>>>
> > > >>>> Thank you for outlining these ideas. I see that this topic is on=
 our
> > > >>>> meeting agenda so it will be good to discuss the tutorial there.
> > > >>>>
> > > >>>>
> > > >>>> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
> > > >>>>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
> > > >>>>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
> > > >>>>>
> > > >>>>
> > > >>>>
> > > >> --
> > > >> Mat Martineau
> > > >> Intel OTC
> > > >>
> > > >
> > > >
> > > >
> > > > --
> > > > [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> > > > Engineer
> > > > matthieu.baerts(a)tessares.net
> > > > Tessares SA | Hybrid Access Solutions
> > > > www.tessares.net
> > > > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> > > > <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+
> > Ottignies-Louvain-la-Neuve,+Belgium>
> > > >
> > >
> > >
> > >
> > > --
> > > [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> > > Engineer
> > > matthieu.baerts(a)tessares.net
> > > Tessares SA | Hybrid Access Solutions
> > > www.tessares.net
> > > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> > > <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+
> > Ottignies-Louvain-la-Neuve,+Belgium>
> > >
> > > --
> > >
> > >
> > > DISCLAIMER.
> > > This email and any files transmitted with it are confidential
> > > and intended solely for the use of the individual or entity to whom t=
hey
> > > are addressed. If you have received this email in error please notify
> > the
> > > system manager. This message contains confidential information and is
> > > intended only for the individual named. If you are not the named
> > addressee
> > > you should not disseminate, distribute or copy this e-mail. Please
> > notify
> > > the sender immediately by e-mail if you have received this e-mail by
> > > mistake and delete this e-mail from your system. If you are not the
> > > intended recipient you are notified that disclosing, copying,
> > distributing
> > > or taking any action in reliance on the contents of this information =
is
> > > strictly prohibited.
> >
> =

> =

> =

> -- =

> [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> Engineer
> matthieu.baerts(a)tessares.net
> Tessares SA | Hybrid Access Solutions
> www.tessares.net
> 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ottignies-Lou=
vain-la-Neuve,+Belgium>
> =

> -- =

> =

> =

> DISCLAIMER.
> This email and any files transmitted with it are confidential =

> and intended solely for the use of the individual or entity to whom they =

> are addressed. If you have received this email in error please notify the =

> system manager. This message contains confidential information and is =

> intended only for the individual named. If you are not the named addresse=
e =

> you should not disseminate, distribute or copy this e-mail. Please notify =

> the sender immediately by e-mail if you have received this e-mail by =

> mistake and delete this e-mail from your system. If you are not the =

> intended recipient you are notified that disclosing, copying, distributin=
g =

> or taking any action in reliance on the contents of this information is =

> strictly prohibited.

--===============6735388615715814257==--
