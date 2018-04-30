Content-Type: multipart/mixed; boundary="===============5708680749589809769=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 21:03:31 +0200
Message-ID: <CAKuKrBmEFA4wwODpSeO_PAqLuzDv-2jZN5LaKHSrwvTqVO1Ecw@mail.gmail.com>
In-Reply-To: CAKuKrBnSDRTgx5vDnFrOOd1s=TPcvsObcy76C+=wcv0qNXSW5A@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 579

--===============5708680749589809769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 8:44 PM, Matthieu Baerts <
matthieu.baerts(a)tessares.net> wrote:

>
>
> On Mon, Apr 30, 2018 at 8:40 PM, Christoph Paasch <cpaasch(a)apple.com>
> wrote:
>
>> On 30/04/18 - 11:17:06, Christoph Paasch wrote:
>> > On 30/04/18 - 19:34:10, Matthieu Baerts wrote:
>> > > On Mon, Apr 30, 2018 at 6:18 PM, Christoph Paasch <cpaasch(a)apple.c=
om>
>> wrote:
>> > >
>> > > > On 30/04/18 - 16:26:01, Matthieu Baerts wrote:
>> > > > > Hi Mat, Christoph, Peter, Ossama,
>> > > > >
>> > > > > I will wait for ~10am your time before sending it to let you some
>> times
>> > > > to
>> > > > > comment this if you want to do so.
>> > > > >
>> > > > > Best regards,
>> > > > > Matthieu
>> > > > >
>> > > > > On Sun, Apr 29, 2018 at 4:08 PM, Matthieu Baerts <
>> > > > > matthieu.baerts(a)tessares.net> wrote:
>> > > > >
>> > > > > > Hi Mat,
>> > > > > >
>> > > > > > Thank you for your review and input!
>> > > > > >
>> > > > > > On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau
>> > > > <mathew.j.martineau(a)linux.
>> > > > > > intel.com> wrote:
>> > > > > >
>> > > > > >>
>> > > > > >> Hi Matthieu -
>> > > > > >>
>> > > > > >> On Fri, 27 Apr 2018, Matthieu Baerts wrote:
>> > > > > >>
>> > > > > >> Hello,
>> > > > > >>>
>> > > > > >>> Following yesterday's discussion about NetDev 0x12, here is a
>> > > > > >>> proposition of mail to send to NetDev committee. I already
>> put some
>> > > > > >>> comments. Note that I have followed the submission guidelines
>> from:
>> > > > > >>> https://www.netdevconf.org/0x12/submit-proposal.html#proposa
>> ls
>> > > > > >>>
>> > > > > >>> Please comment it before Monday morning. Sorry for the rush
>> but the
>> > > > > >>> deadline is the 1st of May :)
>> > > > > >>>
>> > > > > >>> * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat
>> > > > Martineau
>> > > > > >>>>
>> > > > > >>> (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and
>> myself,
>> > > > > >>> Matthieu Baerts (Tessares)
>> > > > > >>>
>> > > > > >>> I wrote down the names of people who participated in the
>> discussion
>> > > > in
>> > > > > >>> the ML and during the weekly meetings. I can add more people
>> if more
>> > > > people
>> > > > > >>> would like to join the preparation and presentation of this
>> tutorial.
>> > > > > >>> @Christoph, Mat, Peter, Ossama: can I write your names there?
>> > > > > >>>
>> > > > > >>
>> > > > > >> Ossama won't be able to attend. It looks like most sessions
>> have 1 or
>> > > > 2
>> > > > > >> presenters, so I don't know if 4 is too many. I'm sure they'll
>> give
>> > > > us some
>> > > > > >> feedback if they want to limit the number of presenters.
>> > > > > >>
>> > > > > >
>> > > > > > OK thank you!
>> > > > > > Yes indeed, I am sure they will say something if we are too
>> many.
>> > > > > >
>> > > > > > * Title of the submission: MPTCP: from the basic to an
>> upstreamable
>> > > > base
>> > > > > >>>>
>> > > > > >>>
>> > > > > >>> We certainly need a better title, please comment!
>> > > > > >>>
>> > > > > >>
>> > > > > >> "Multipath TCP: Present Use Cases and an Upstream Future" ?
>> > > > > >>
>> > > > > >
>> > > > > > I was trying to find something that catch the attention but it
>> is maybe
>> > > > > > not needed for these kind of presentation.
>> > > > > >
>> > > > > > > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
>> > > > > >>>
>> > > > > >>> "hands-on" seems to be the correct one according to the
>> Submission
>> > > > Types.
>> > > > > >>> https://www.netdevconf.org/0x12/submit-proposal.html#types
>> > > > > >>>
>> > > > > >>
>> > > > > >> It's a little bit of "nuts & bolts" too, but I agree that
>> hands-on is
>> > > > the
>> > > > > >> better match.
>> > > > > >>
>> > > > > >
>> > > > > > Thank you!
>> > > > > >
>> > > > > > * Submission type (one of talk, presentation, workshop):
>> tutorial,
>> > > > > >>>>
>> > > > > >>> instructor-led sessions (minimum 1 hour long and not to
>> exceed 1.5
>> > > > > >>> hours. The instructor will go over the technology either
>> through code
>> > > > > >>> review or execution and interact with the attendees.)
>> > > > > >>>
>> > > > > >>> I guess there is a typo here: presentation should be replaced
>> by
>> > > > > >>> tutorial in the guidelines.
>> > > > > >>>
>> > > > > >>> Estimate of length of time for presentation: 1h
>> > > > > >>>>
>> > > > > >>>
>> > > > > >>> That's what we agreed yesterday but I can change.
>> > > > > >>>
>> > > > > >>> Affiliations of submitters (needed for conflict of interest
>> check):
>> > > > > >>>> Apple,
>> > > >
>> > > > I will have to double-check on the affiliation part wrt to Apple.
>> > > >
>> > > > If I don't get a thumbs up, you can simply remove me from the list.
>> > > >
>> > >
>> > > Do you want me to wait or can I send it today and ask to remove you
>> from
>> > > the list later if needed?
>> >
>> > Can you wait a little bit? I am trying to get a hold of the one who can
>> tell
>> > me "yes" or "no".
>>
>> Matthieu, you can leave the Apple-affiliation in for now.
>>
>> At worst, we can always remove me from the list.
>>
>>
>> Sorry for the delay on this here.
>>
>
> All good, I can wait more if you prefer!
>
> From my point-of-view, you can go ahead and submit the proposal.
>>
>
> Great!
> Let me recompile all bits!
>

Here is what I am going to send:

Names of the submitters: Christoph Paasch (Apple), Mat Martineau (Intel),
> Peter Krystad (Intel) and myself, Matthieu Baerts (Tessares)
> Title of the submission: Multipath TCP: Present Use Cases and an Upstream
> Future
> Label: hands-on
> Submission type: tutorial
> Estimate of length of time for presentation: 1h
> Affiliations of submitters (needed for conflict of interest check): Apple,
> Intel, Tessares
> Description of proposal:
>     A community project is underway to add Multipath TCP to the upstream
> Linux kernel. This tutorial will introduce the audience to this TCP
> extension (RFC 6824), show some use-cases already in production and have
> interactive discussions of the challenges in converging on an upstream
> MPTCP implementation.
>
>     We will use the current MPTCP implementation, already used by millions
> of devices, to demonstrate the utility of the protocol on today's Internet
> and to show how this implementation can currently be extended with APIs
> like Netlink. This not only has practical application for deploying
> Multipath TCP now, but also illustrates how the APIs and code will need to
> evolve in order to properly coexist with the optimized Linux TCP core we
> all rely on. We will discuss our ideas for bringing MPTCP to the upstream
> kernel so the technology is available to all Linux users.
>
>     For more information about this project:
> https://github.com/multipath-tcp/mptcp_net-next/wiki
>

I don't want to bother you for a new review. I hope and I guess it is fine
for everybody :)

Matthieu


> Matthieu
>
>
>>
>> Christoph
>>
>>
>>
>> >
>> >
>> > Christoph
>> >
>> > >
>> > > Matthieu
>> > >
>> > >
>> > > >
>> > > > Christoph
>> > > >
>> > > >
>> > > > > >>>>
>> > > > > >>> Intel, Tessares
>> > > > > >>>
>> > > > > >>> Description of proposal:
>> > > > > >>>>     A project to add an implementation of the MultiPath TCP
>> > > > protocol to
>> > > > > >>>> the
>> > > > > >>>>
>> > > > > >>> Linux kernel is in progress by a small community. The goal of
>> this
>> > > > > >>> tutorial is to discover what is this TCP extension (RFC
>> 6824), what
>> > > > are the
>> > > > > >>> different use-cases already in production by some companies
>> and what
>> > > > are
>> > > > > >>> the challenges to upstream MPTCP. We hope having interactive
>> > > > discussions
>> > > > > >>> and getting feedback from experienced developers will help us
>> in
>> > > > this task
>> > > > > >>> of easily bringing MPTCP to all Linux users, a technology
>> already
>> > > > used by
>> > > > > >>> millions of people.
>> > > > > >>>
>> > > > > >>
>> > > > > >>     In a bit more detail, we will start with a basic
>> introduction of
>> > > > > >>>> MPTCP.
>> > > > > >>>>
>> > > > > >>> A few use-cases will be presented with a demo to explain how
>> useful
>> > > > this
>> > > > > >>> protocol is in today's Internet and how it can be extended
>> with
>> > > > API's like
>> > > > > >>> Netlink and BPF.
>> > > > > >>>
>> > > > > >>
>> > > > > >> I recognize how Netlink is associated with a userspace path
>> manager,
>> > > > but
>> > > > > >> what's the BPF extensibility you're referring to?
>> > > > > >>
>> > > > > >
>> > > > > > It was only to mention that it would be possible to extend
>> MPTCP with
>> > > > eBPF.
>> > > > > > Even if it is not already available in the current Open-Source
>> > > > > > implementation, there is already the possibility to get a
>> version with
>> > > > a
>> > > > > > programmable scheduler: https://progmp.net
>> > > > > >
>> > > > > > Then we will have some explanations about how MPTCP is current=
ly
>> > > > > >>> implemented. This current implementation is quite intrusive
>> and that
>> > > > is
>> > > > > >>> certainly not something we would like to have upstream. We
>> would
>> > > > like to
>> > > > > >>> express what we have in mind to change that, with some
>> samples and
>> > > > initiate
>> > > > > >>> discussions.
>> > > > > >>>
>> > > > > >>
>> > > > > >> My edit of the above:
>> > > > > >>
>> > > > > >> """
>> > > > > >>
>> > > > > >> A community project is underway to add Multipath TCP to the
>> upstream
>> > > > > >> Linux kernel. This tutorial will introduce the audience to
>> this TCP
>> > > > > >> extension (RFC 6824), show some use cases already in
>> production, and
>> > > > > >> discuss the challenges in converging on an upstream MPTCP
>> > > > implementation.
>> > > > > >>
>> > > > > >
>> > > > > > Should we insist on the "discussion" part? Like saying:
>> "discuss with
>> > > > the
>> > > > > > audience"? "have interactive discussions"?
>> > > > > > It is maybe not needed but it was mainly to express the
>> interactivity,
>> > > > it
>> > > > > > is a tutorial, not just a "simple" presentation.
>> > > > > >
>> > > > > > We will use the current MPTCP implementation to demonstrate the
>> > > > utility of
>> > > > > >> the protocol on today's internet, and to show how this
>> implementation
>> > > > can
>> > > > > >> currently be extended with netlink and BPF. This not only has
>> > > > practical
>> > > > > >> application for deploying MPTCP now, but also illustrates how
>> the
>> > > > APIs and
>> > > > > >> code will need to evolve in order to properly coexist with the
>> > > > optimized
>> > > > > >> Linux TCP core we all rely on. We will discuss our ideas for
>> bringing
>> > > > MPTCP
>> > > > > >> to the upstream kernel so the technology is available to all
>> Linux
>> > > > users.
>> > > > > >>
>> > > > > >
>> > > > > > To "attract" people, should we mention that the current
>> implementation
>> > > > is
>> > > > > > already used by millions of users?
>> > > > > > I like how your improve the last bit :-)
>> > > > > >
>> > > > > > """
>> > > > > >>
>> > > > > >> Feel free to edit/merge/expand/discard as needed :)
>> > > > > >>
>> > > > > >
>> > > > > > Thank you for your edit, it is indeed cleaner!
>> > > > > >
>> > > > > >     For more information about this project:
>> > > > > >>>>
>> > > > > >>> https://github.com/multipath-tcp/mptcp_net-next/wiki
>> > > > > >>
>> > > > > >>
>> > > > > > I guess I can keep this, right?
>> > > > > >
>> > > > > > Please feel free to comment this as well. We are still far from
>> the max
>> > > > > >>> 350 words limit we found last time. But on the other hand, I
>> can no
>> > > > longer
>> > > > > >>> find this limit on their website :)
>> > > > > >>>
>> > > > > >>
>> > > > > >> Hope the above is helpful. Thanks again for your work on this
>> > > > proposal.
>> > > > > >>
>> > > > > >
>> > > > > > Yes it is, thank you for your help!
>> > > > > >
>> > > > > > Matthieu
>> > > > > >
>> > > > > >
>> > > > > >>
>> > > > > >> Mat
>> > > > > >>
>> > > > > >>
>> > > > > >>
>> > > > > >>
>> > > > > >>> Thank you for your help!
>> > > > > >>>
>> > > > > >>> Have a good day/evening,
>> > > > > >>> Matthieu
>> > > > > >>>
>> > > > > >>> On 25/04/2018 21:58, Mat Martineau wrote:
>> > > > > >>>
>> > > > > >>>>
>> > > > > >>>> Hi Matthieu -
>> > > > > >>>>
>> > > > > >>>> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
>> > > > > >>>>
>> > > > > >>>> Hello,
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 1=
1th to
>> 13th,
>> > > > 2018.
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> We already talked about this event on this ML and at our
>> weekly
>> > > > > >>>>> meetings but here is a summary of the discussions we had:
>> > > > > >>>>>
>> > > > > >>>>>  - we would like to have a presentation there mainly to get
>> > > > feedback
>> > > > > >>>>> and advice from other kernel developers
>> > > > > >>>>>  - a presentation would clearly indicate that this MPTCP
>> Upstream
>> > > > > >>>>> project exists and we could get help from more developers
>> > > > > >>>>>  - we would like to indicate that having MPTCP upstream is
>> asked by
>> > > > > >>>>> different companies, some are even ready to contribute ; it
>> is then
>> > > > > >>>>> important to have MPTCP upstream
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> Also note that:
>> > > > > >>>>>
>> > > > > >>>>>  - David Miller will not be present in Montr=C3=A9al [1] b=
ut
>> other main
>> > > > > >>>>> contributors should be there (we don't have a list)
>> > > > > >>>>>
>> > > > > >>>>
>> > > > > >>>> Side note, in the past day David reiterated his statement
>> about not
>> > > > > >>>> attending or supporting the conference:
>> > > > > >>>>
>> > > > > >>>> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=
=3D2
>> > > > > >>>>
>> > > > > >>>>  - A presentation by Octavian Purdila about "MPTCP
>> Upstreaming" has
>> > > > > >>>>> already been given in 2015 (NetDev 0.1) [2]
>> > > > > >>>>>  - 3 types of presentation are available: talks, tutorials
>> and
>> > > > > >>>>> workshops [3]
>> > > > > >>>>>  - Call for Presentation Proposals closes on May 1st, 2018.
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> The current idea we briefly discussed during our weekly
>> meetings
>> > > > is to
>> > > > > >>>>> give a tutorial:
>> > > > > >>>>>
>> > > > > >>>>>  - It is not useful to give almost the same presentation as
>> the
>> > > > one of
>> > > > > >>>>> Octavian
>> > > > > >>>>>  - It will allow us more flexibility somehow to explain
>> what is
>> > > > MPTCP,
>> > > > > >>>>> the different use-cases, why it is important to have it
>> upstream
>> > > > and what
>> > > > > >>>>> problems we are currently facing.
>> > > > > >>>>>  - David Miller and many other kernel developers will go to
>> LPC in
>> > > > > >>>>> November: a good place to give a talk this time.
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> Do you have any ideas on what we could show in this
>> tutorial?
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> I recently discussed with my colleague Olivier Bonaventure
>> who has
>> > > > a
>> > > > > >>>>> lot of experiences in giving different introductions and
>> more
>> > > > about MPTCP
>> > > > > >>>>> and here is what he suggests:
>> > > > > >>>>>
>> > > > > >>>>>  - A first part about a basic introduction of MPTCP
>> > > > > >>>>>  - Indicate different use-cases -- if possible with a
>> "closed
>> > > > demo" to
>> > > > > >>>>> be sure it is working -- asking people to setup something
>> is not
>> > > > easy in
>> > > > > >>>>> 1h, max 1h30.
>> > > > > >>>>>
>> > > > > >>>>
>> > > > > >>>>  From the description at [3], either "instructor-led" 60-90
>> minute
>> > > > > >>>> tutorials or "student-participation" 2-3 hour sessions are
>> > > > possible. The
>> > > > > >>>> closed demo maps well to their "instructor-led" category.
>> Looking
>> > > > at the
>> > > > > >>>> schedule, the past two Netdev Conferences have had one
>> tutorial
>> > > > each, of
>> > > > > >>>> 60-70 minutes. I think it helps to be closer to an hour in
>> length
>> > > > to hold
>> > > > > >>>> the audience's attention.
>> > > > > >>>>
>> > > > > >>>>  - Then trying to have interactive discussions or
>> explanations about
>> > > > > >>>>> how MPTCP is currently implemented or should be implemented
>> if it
>> > > > goes
>> > > > > >>>>> upstream, e.g.: for MPTCP, we need to have extra TCP
>> Options, we
>> > > > need to
>> > > > > >>>>> support middleboxes, we need to link subflows of the same
>> > > > connection
>> > > > > >>>>> together, we need a scheduler, a PM, etc.
>> > > > > >>>>>
>> > > > > >>>>
>> > > > > >>>> It's difficult to predict how interactive an audience will
>> be. I've
>> > > > > >>>> only attended one Netdev Conference, and it seemed like
>> there were
>> > > > a lot
>> > > > > >>>> more people with expertise and interest in drivers, lower
>> layers
>> > > > (XDP, BPF,
>> > > > > >>>> TC, netfilter), and network topology/simulation. Discussion
>> around
>> > > > > >>>> middlebox support and the userspace API might have more
>> audience
>> > > > > >>>> interaction. If we want to drive a discussion, we could try
>> to
>> > > > strike a
>> > > > > >>>> balance between topics for the broader audience and those
>> with more
>> > > > > >>>> knowledge of TCP internals. (Hopefully some TCP internals
>> people
>> > > > are still
>> > > > > >>>> planning to attend)
>> > > > > >>>>
>> > > > > >>>>  - Of course, we should focus our discussions on the
>> upstreaming
>> > > > > >>>>> aspect, e.g. reducing the footprint of MPTCP in the current
>> TCP
>> > > > stack: what
>> > > > > >>>>> are we allow to do, what not. It is linked to many previous
>> > > > discussions we
>> > > > > >>>>> had on this ML, e.g. why we need more indirect function
>> calls and
>> > > > how to
>> > > > > >>>>> reduce the impact, etc.
>> > > > > >>>>>
>> > > > > >>>>
>> > > > > >>>> The previous talk ([2]) had a section like this. I haven't
>> watched
>> > > > it
>> > > > > >>>> recently, I should look at it again to see what kind of
>> questions
>> > > > the
>> > > > > >>>> audience was asking. As you mentioned above we should be
>> careful to
>> > > > have
>> > > > > >>>> new content compared to the previous session.
>> > > > > >>>>
>> > > > > >>>>  - If we have time, we could discuss about how users could
>> interact
>> > > > > >>>>> with MPTCP: enable it per connection, control the path
>> manager,
>> > > > maybe the
>> > > > > >>>>> scheduler, etc.
>> > > > > >>>>>
>> > > > > >>>>>
>> > > > > >>>>> What do you think about this? Feel free to comment and even
>> propose
>> > > > > >>>>> completely different ideas!
>> > > > > >>>>>
>> > > > > >>>>
>> > > > > >>>> Thank you for outlining these ideas. I see that this topic
>> is on our
>> > > > > >>>> meeting agenda so it will be good to discuss the tutorial
>> there.
>> > > > > >>>>
>> > > > > >>>>
>> > > > > >>>> [1] https://lists.01.org/pipermail
>> /mptcp/2018-March/000379.html
>> > > > > >>>>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
>> > > > > >>>>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
>> > > > > >>>>>
>> > > > > >>>>
>> > > > > >>>>
>> > > > > >> --
>> > > > > >> Mat Martineau
>> > > > > >> Intel OTC
>> > > > > >>
>> > > > > >
>> > > > > >
>> > > > > >
>> > > > > > --
>> > > > > > [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts
>> | R&D
>> > > > > > Engineer
>> > > > > > matthieu.baerts(a)tessares.net
>> > > > > > Tessares SA | Hybrid Access Solutions
>> > > > > > www.tessares.net
>> > > > > > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>> > > > > > <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+
>> > > > Ottignies-Louvain-la-Neuve,+Belgium>
>> > > > > >
>> > > > >
>> > > > >
>> > > > >
>> > > > > --
>> > > > > [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts |
>> R&D
>> > > > > Engineer
>> > > > > matthieu.baerts(a)tessares.net
>> > > > > Tessares SA | Hybrid Access Solutions
>> > > > > www.tessares.net
>> > > > > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>> > > > > <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+
>> > > > Ottignies-Louvain-la-Neuve,+Belgium>
>> > > > >
>> > > > > --
>> > > > >
>> > > > >
>> > > > > DISCLAIMER.
>> > > > > This email and any files transmitted with it are confidential
>> > > > > and intended solely for the use of the individual or entity to
>> whom they
>> > > > > are addressed. If you have received this email in error please
>> notify
>> > > > the
>> > > > > system manager. This message contains confidential information
>> and is
>> > > > > intended only for the individual named. If you are not the named
>> > > > addressee
>> > > > > you should not disseminate, distribute or copy this e-mail. Plea=
se
>> > > > notify
>> > > > > the sender immediately by e-mail if you have received this e-mail
>> by
>> > > > > mistake and delete this e-mail from your system. If you are not
>> the
>> > > > > intended recipient you are notified that disclosing, copying,
>> > > > distributing
>> > > > > or taking any action in reliance on the contents of this
>> information is
>> > > > > strictly prohibited.
>> > > >
>> > >
>> > >
>> > >
>> > > --
>> > > [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
>> > > Engineer
>> > > matthieu.baerts(a)tessares.net
>> > > Tessares SA | Hybrid Access Solutions
>> > > www.tessares.net
>> > > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
>> > > <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+Ot
>> tignies-Louvain-la-Neuve,+Belgium>
>> > >
>> > > --
>> > >
>> > >
>> > > DISCLAIMER.
>> > > This email and any files transmitted with it are confidential
>> > > and intended solely for the use of the individual or entity to whom
>> they
>> > > are addressed. If you have received this email in error please notify
>> the
>> > > system manager. This message contains confidential information and is
>> > > intended only for the individual named. If you are not the named
>> addressee
>> > > you should not disseminate, distribute or copy this e-mail. Please
>> notify
>> > > the sender immediately by e-mail if you have received this e-mail by
>> > > mistake and delete this e-mail from your system. If you are not the
>> > > intended recipient you are notified that disclosing, copying,
>> distributing
>> > > or taking any action in reliance on the contents of this information
>> is
>> > > strictly prohibited.
>> > _______________________________________________
>> > mptcp mailing list
>> > mptcp(a)lists.01.org
>> > https://lists.01.org/mailman/listinfo/mptcp
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

--===============5708680749589809769==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiBNb24sIEFwciAzMCwgMjAxOCBhdCA4OjQ0IFBNLCBNYXR0aGlldSBCYWVydHMg
PHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzQHRlc3Nh
cmVzLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ8L2E+
Jmd0Ozwvc3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5
bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIw
NCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfZXh0cmEiPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdj48ZGl2IGNs
YXNzPSJnbWFpbC1oNSI+T24gTW9uLCBBcHIgMzAsIDIwMTggYXQgODo0MCBQTSwgQ2hyaXN0b3Bo
IFBhYXNjaCA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxl
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDs8L3NwYW4+IHdy
b3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+PGRpdiBjbGFzcz0iZ21haWwtbV8zMzUwOTU3NzA4MzI5MjI1NTM2SE9F
blpiIj48ZGl2IGNsYXNzPSJnbWFpbC1tXzMzNTA5NTc3MDgzMjkyMjU1MzZoNSI+T24gMzAvMDQv
MTggLSAxMToxNzowNiwgQ2hyaXN0b3BoIFBhYXNjaCB3cm90ZTo8YnI+CiZndDsgT24gMzAvMDQv
MTggLSAxOTozNDoxMCwgTWF0dGhpZXUgQmFlcnRzIHdyb3RlOjxicj4KJmd0OyAmZ3Q7IE9uIE1v
biwgQXByIDMwLCAyMDE4IGF0IDY6MTggUE0sIENocmlzdG9waCBQYWFzY2ggJmx0OzxhIGhyZWY9
Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmNwYWFzY2hAYXBwbGUu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgJmd0OyBPbiAz
MC8wNC8xOCAtIDE2OjI2OjAxLCBNYXR0aGlldSBCYWVydHMgd3JvdGU6PGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IEhpIE1hdCwgQ2hyaXN0b3BoLCBQZXRlciwgT3NzYW1hLDxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBJIHdpbGwgd2FpdCBmb3IgfjEwYW0g
eW91ciB0aW1lIGJlZm9yZSBzZW5kaW5nIGl0IHRvIGxldCB5b3Ugc29tZSB0aW1lczxicj4KJmd0
OyAmZ3Q7ICZndDsgdG88YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgY29tbWVudCB0aGlzIGlmIHlv
dSB3YW50IHRvIGRvIHNvLjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyBCZXN0IHJlZ2FyZHMsPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IE1hdHRoaWV1PGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IE9uIFN1biwgQXBy
IDI5LCAyMDE4IGF0IDQ6MDggUE0sIE1hdHRoaWV1IEJhZXJ0cyAmbHQ7PGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IDxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0IiB0
YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDwvYT4mZ3Q7IHdyb3Rl
Ojxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEhp
IE1hdCw8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7IFRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcgYW5kIGlucHV0ITxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgT24gU2F0LCBBcHIg
MjgsIDIwMTggYXQgMjo0NCBBTSwgTWF0IE1hcnRpbmVhdTxicj4KJmd0OyAmZ3Q7ICZndDsgJmx0
O21hdGhldy5qLm1hcnRpbmVhdUBsaW51eC48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8
YSBocmVmPSJodHRwOi8vaW50ZWwuY29tIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5pbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0Ozxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7Jmd0OyBIaSBNYXR0aGlldSAtPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IE9uIEZyaSwgMjcgQXByIDIwMTgsIE1hdHRo
aWV1IEJhZXJ0cyB3cm90ZTo8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsgSGVsbG8sPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgRm9sbG93
aW5nIHllc3RlcmRheSYjMzk7cyBkaXNjdXNzaW9uIGFib3V0IE5ldERldiAweDEyLCBoZXJlIGlz
IGE8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7IHByb3Bvc2l0aW9uIG9mIG1h
aWwgdG8gc2VuZCB0byBOZXREZXYgY29tbWl0dGVlLiBJIGFscmVhZHkgcHV0IHNvbWU8YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7IGNvbW1lbnRzLiBOb3RlIHRoYXQgSSBoYXZl
IGZvbGxvd2VkIHRoZSBzdWJtaXNzaW9uIGd1aWRlbGluZXMgZnJvbTo8YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyZndDsmZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3Jn
LzB4MTIvc3VibWl0LXByb3Bvc2FsLmh0bWwjcHJvcG9zYWxzIiByZWw9Im5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy8weDE8d2JyPjIvc3VibWl0
LXByb3Bvc2FsLmh0bWwjcHJvcG9zYTx3YnI+bHM8L2E+PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgUGxlYXNl
IGNvbW1lbnQgaXQgYmVmb3JlIE1vbmRheSBtb3JuaW5nLiBTb3JyeSBmb3IgdGhlIHJ1c2ggYnV0
IHRoZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgZGVhZGxpbmUgaXMgdGhl
IDFzdCBvZiBNYXkgOik8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7PGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyAqIE5hbWUocykgb2YgdGhlIHN1Ym1pdHRl
cihzKTogQ2hyaXN0b3BoIFBhYXNjaCAoQXBwbGUpLCBNYXQ8YnI+CiZndDsgJmd0OyAmZ3Q7IE1h
cnRpbmVhdTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyAoSW50ZWwpLCBQZXRlciBLcnlzdGFkIChJbnRl
bCksIE9zc2FtYSBPdGhtYW4gKEludGVsKSBhbmQgbXlzZWxmLDxicj4KJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7Jmd0OyZndDsgTWF0dGhpZXUgQmFlcnRzIChUZXNzYXJlcyk8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7
Jmd0OyBJIHdyb3RlIGRvd24gdGhlIG5hbWVzIG9mIHBlb3BsZSB3aG8gcGFydGljaXBhdGVkIGlu
IHRoZSBkaXNjdXNzaW9uPGJyPgomZ3Q7ICZndDsgJmd0OyBpbjxicj4KJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7Jmd0OyZndDsgdGhlIE1MIGFuZCBkdXJpbmcgdGhlIHdlZWtseSBtZWV0aW5ncy4g
SSBjYW4gYWRkIG1vcmUgcGVvcGxlIGlmIG1vcmU8YnI+CiZndDsgJmd0OyAmZ3Q7IHBlb3BsZTxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgd291bGQgbGlrZSB0byBqb2luIHRo
ZSBwcmVwYXJhdGlvbiBhbmQgcHJlc2VudGF0aW9uIG9mIHRoaXMgdHV0b3JpYWwuPGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyBAQ2hyaXN0b3BoLCBNYXQsIFBldGVyLCBPc3Nh
bWE6IGNhbiBJIHdyaXRlIHlvdXIgbmFtZXMgdGhlcmU/PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyBPc3NhbWEgd29uJiMzOTt0IGJlIGFibGUgdG8gYXR0ZW5k
LiBJdCBsb29rcyBsaWtlIG1vc3Qgc2Vzc2lvbnMgaGF2ZSAxIG9yPGJyPgomZ3Q7ICZndDsgJmd0
OyAyPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IHByZXNlbnRlcnMsIHNvIEkgZG9u
JiMzOTt0IGtub3cgaWYgNCBpcyB0b28gbWFueS4gSSYjMzk7bSBzdXJlIHRoZXkmIzM5O2xsIGdp
dmU8YnI+CiZndDsgJmd0OyAmZ3Q7IHVzIHNvbWU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsgZmVlZGJhY2sgaWYgdGhleSB3YW50IHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgcHJlc2Vu
dGVycy48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IE9LIHRoYW5rIHlvdSE8YnI+
CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBZZXMgaW5kZWVkLCBJIGFtIHN1cmUgdGhleSB3aWxs
IHNheSBzb21ldGhpbmcgaWYgd2UgYXJlIHRvbyBtYW55Ljxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgKiBUaXRsZSBvZiB0aGUgc3VibWlz
c2lvbjogTVBUQ1A6IGZyb20gdGhlIGJhc2ljIHRvIGFuIHVwc3RyZWFtYWJsZTxicj4KJmd0OyAm
Z3Q7ICZndDsgYmFzZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7Jmd0OyZndDsgV2UgY2VydGFpbmx5IG5lZWQgYSBiZXR0ZXIgdGl0bGUsIHBsZWFzZSBj
b21tZW50ITxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsgJnF1
b3Q7TXVsdGlwYXRoIFRDUDogUHJlc2VudCBVc2UgQ2FzZXMgYW5kIGFuIFVwc3RyZWFtIEZ1dHVy
ZSZxdW90OyA/PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBJIHdhcyB0cnlpbmcg
dG8gZmluZCBzb21ldGhpbmcgdGhhdCBjYXRjaCB0aGUgYXR0ZW50aW9uIGJ1dCBpdCBpcyBtYXli
ZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IG5vdCBuZWVkZWQgZm9yIHRoZXNlIGtpbmQg
b2YgcHJlc2VudGF0aW9uLjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAqIExhYmVsIChvbmUgb2YgbW9vbnNob3QsIG51dHMmIzM5
O24gYm9sdHMsIGhhbmRzLW9uKTogaGFuZHMtb248YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyAmcXVvdDtoYW5k
cy1vbiZxdW90OyBzZWVtcyB0byBiZSB0aGUgY29ycmVjdCBvbmUgYWNjb3JkaW5nIHRvIHRoZSBT
dWJtaXNzaW9uPGJyPgomZ3Q7ICZndDsgJmd0OyBUeXBlcy48YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDsmZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzB4MTIv
c3VibWl0LXByb3Bvc2FsLmh0bWwjdHlwZXMiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzB4MTx3YnI+Mi9zdWJtaXQtcHJvcG9zYWwu
aHRtbCN0eXBlczwvYT48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7PGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsm
Z3Q7IEl0JiMzOTtzIGEgbGl0dGxlIGJpdCBvZiAmcXVvdDtudXRzICZhbXA7IGJvbHRzJnF1b3Q7
IHRvbywgYnV0IEkgYWdyZWUgdGhhdCBoYW5kcy1vbiBpczxicj4KJmd0OyAmZ3Q7ICZndDsgdGhl
PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IGJldHRlciBtYXRjaC48YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRoYW5rIHlvdSE8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICogU3VibWlzc2lvbiB0eXBlIChv
bmUgb2YgdGFsaywgcHJlc2VudGF0aW9uLCB3b3Jrc2hvcCk6IHR1dG9yaWFsLDxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7Jmd0OyBpbnN0cnVjdG9yLWxlZCBzZXNzaW9ucyAobWluaW11bSAxIGhvdXIgbG9uZyBh
bmQgbm90IHRvIGV4Y2VlZCAxLjU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7
IGhvdXJzLiBUaGUgaW5zdHJ1Y3RvciB3aWxsIGdvIG92ZXIgdGhlIHRlY2hub2xvZ3kgZWl0aGVy
IHRocm91Z2ggY29kZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgcmV2aWV3
IG9yIGV4ZWN1dGlvbiBhbmQgaW50ZXJhY3Qgd2l0aCB0aGUgYXR0ZW5kZWVzLik8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsm
Z3Q7Jmd0OyBJIGd1ZXNzIHRoZXJlIGlzIGEgdHlwbyBoZXJlOiBwcmVzZW50YXRpb24gc2hvdWxk
IGJlIHJlcGxhY2VkIGJ5PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyB0dXRv
cmlhbCBpbiB0aGUgZ3VpZGVsaW5lcy48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsm
Z3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyBFc3RpbWF0ZSBvZiBsZW5n
dGggb2YgdGltZSBmb3IgcHJlc2VudGF0aW9uOiAxaDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgVGhhdCYjMzk7cyB3aGF0IHdlIGFncmVl
ZCB5ZXN0ZXJkYXkgYnV0IEkgY2FuIGNoYW5nZS48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyBBZmZpbGlhdGlv
bnMgb2Ygc3VibWl0dGVycyAobmVlZGVkIGZvciBjb25mbGljdCBvZiBpbnRlcmVzdCBjaGVjayk6
PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgQXBwbGUsPGJyPgomZ3Q7
ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgSSB3aWxsIGhhdmUgdG8gZG91YmxlLWNoZWNr
IG9uIHRoZSBhZmZpbGlhdGlvbiBwYXJ0IHdydCB0byBBcHBsZS48YnI+CiZndDsgJmd0OyAmZ3Q7
PGJyPgomZ3Q7ICZndDsgJmd0OyBJZiBJIGRvbiYjMzk7dCBnZXQgYSB0aHVtYnMgdXAsIHlvdSBj
YW4gc2ltcGx5IHJlbW92ZSBtZSBmcm9tIHRoZSBsaXN0Ljxicj4KJmd0OyAmZ3Q7ICZndDs8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBEbyB5b3Ugd2FudCBtZSB0byB3YWl0IG9yIGNhbiBJ
IHNlbmQgaXQgdG9kYXkgYW5kIGFzayB0byByZW1vdmUgeW91IGZyb208YnI+CiZndDsgJmd0OyB0
aGUgbGlzdCBsYXRlciBpZiBuZWVkZWQ/PGJyPgomZ3Q7IDxicj4KJmd0OyBDYW4geW91IHdhaXQg
YSBsaXR0bGUgYml0PyBJIGFtIHRyeWluZyB0byBnZXQgYSBob2xkIG9mIHRoZSBvbmUgd2hvIGNh
biB0ZWxsPGJyPgomZ3Q7IG1lICZxdW90O3llcyZxdW90OyBvciAmcXVvdDtubyZxdW90Oy48YnI+
Cjxicj4KPC9kaXY+PC9kaXY+TWF0dGhpZXUsIHlvdSBjYW4gbGVhdmUgdGhlIEFwcGxlLWFmZmls
aWF0aW9uIGluIGZvciBub3cuPGJyPgo8YnI+CkF0IHdvcnN0LCB3ZSBjYW4gYWx3YXlzIHJlbW92
ZSBtZSBmcm9tIHRoZSBsaXN0Ljxicj4KPGJyPgo8YnI+ClNvcnJ5IGZvciB0aGUgZGVsYXkgb24g
dGhpcyBoZXJlLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+PGRp
dj5BbGwgZ29vZCwgSSBjYW4gd2FpdCBtb3JlIGlmIHlvdSBwcmVmZXIhPC9kaXY+PHNwYW4gY2xh
c3M9ImdtYWlsLSI+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3Rl
IiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCBy
Z2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPgoKPkZyb20gbXkgcG9pbnQtb2Ytdmll
dywgeW91IGNhbiBnbyBhaGVhZCBhbmQgc3VibWl0IHRoZSBwcm9wb3NhbC48YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2Pjwvc3Bhbj48ZGl2PkdyZWF0ITxicj48L2Rpdj48ZGl2PkxldCBt
ZSByZWNvbXBpbGUgYWxsIGJpdHMhPC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3Rl
PjxkaXY+PGJyPjwvZGl2PjxkaXY+SGVyZSBpcyB3aGF0IEkgYW0gZ29pbmcgdG8gc2VuZDo8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48L2Rpdj48ZGl2Pk5hbWVzIG9mIHRoZSBzdWJt
aXR0ZXJzOiBDaHJpc3RvcGggUGFhc2NoIChBcHBsZSksIE1hdCBNYXJ0aW5lYXUgKEludGVsKSwg
UGV0ZXIgS3J5c3RhZCAoSW50ZWwpIGFuZCBteXNlbGYsIE1hdHRoaWV1IEJhZXJ0cyAoVGVzc2Fy
ZXMpPGJyPlRpdGxlIG9mIHRoZSBzdWJtaXNzaW9uOiBNdWx0aXBhdGggVENQOiBQcmVzZW50IFVz
ZSBDYXNlcyBhbmQgYW4gVXBzdHJlYW0gRnV0dXJlPGJyPkxhYmVsOiBoYW5kcy1vbjxicj5TdWJt
aXNzaW9uIHR5cGU6IHR1dG9yaWFsPGJyPkVzdGltYXRlIG9mIGxlbmd0aCBvZiB0aW1lIGZvciBw
cmVzZW50YXRpb246IDFoPGJyPkFmZmlsaWF0aW9ucyBvZiBzdWJtaXR0ZXJzIChuZWVkZWQgZm9y
IGNvbmZsaWN0IG9mIGludGVyZXN0IGNoZWNrKTogQXBwbGUsIEludGVsLCBUZXNzYXJlczxicj5E
ZXNjcmlwdGlvbiBvZiBwcm9wb3NhbDo8YnI+wqDCoMKgIEEgY29tbXVuaXR5IHByb2plY3QgaXMg
dW5kZXJ3YXkgdG8gYWRkIE11bHRpcGF0aCBUQ1AgdG8gdGhlIHVwc3RyZWFtIExpbnV4IGtlcm5l
bC4gVGhpcyB0dXRvcmlhbCB3aWxsIGludHJvZHVjZSB0aGUgYXVkaWVuY2UgdG8gdGhpcyBUQ1Ag
ZXh0ZW5zaW9uIChSRkMgNjgyNCksIHNob3cgc29tZSB1c2UtY2FzZXMgYWxyZWFkeSBpbiBwcm9k
dWN0aW9uIGFuZCBoYXZlIGludGVyYWN0aXZlIGRpc2N1c3Npb25zIG9mIHRoZSBjaGFsbGVuZ2Vz
IGluIGNvbnZlcmdpbmcgb24gYW4gdXBzdHJlYW0gTVBUQ1AgaW1wbGVtZW50YXRpb24uPGJyPjxi
cj7CoMKgwqAgV2Ugd2lsbCB1c2UgdGhlIGN1cnJlbnQgTVBUQ1AgaW1wbGVtZW50YXRpb24sIGFs
cmVhZHkgdXNlZCBieSBtaWxsaW9ucyBvZiBkZXZpY2VzLCB0byBkZW1vbnN0cmF0ZSB0aGUgdXRp
bGl0eSBvZiB0aGUgcHJvdG9jb2wgb24gdG9kYXkmIzM5O3MgSW50ZXJuZXQgYW5kIHRvIHNob3cg
aG93IHRoaXMgaW1wbGVtZW50YXRpb24gY2FuIGN1cnJlbnRseSBiZSBleHRlbmRlZCB3aXRoIEFQ
SXMgbGlrZSBOZXRsaW5rLiBUaGlzIG5vdCBvbmx5IGhhcyBwcmFjdGljYWwgYXBwbGljYXRpb24g
Zm9yIGRlcGxveWluZyBNdWx0aXBhdGggVENQIG5vdywgYnV0IGFsc28gaWxsdXN0cmF0ZXMgaG93
IHRoZSBBUElzIGFuZCBjb2RlIHdpbGwgbmVlZCB0byBldm9sdmUgaW4gb3JkZXIgdG8gcHJvcGVy
bHkgY29leGlzdCB3aXRoIHRoZSBvcHRpbWl6ZWQgTGludXggVENQIGNvcmUgd2UgYWxsIHJlbHkg
b24uIFdlIHdpbGwgZGlzY3VzcyBvdXIgaWRlYXMgZm9yIGJyaW5naW5nIE1QVENQIHRvIHRoZSB1
cHN0cmVhbSBrZXJuZWwgc28gdGhlIHRlY2hub2xvZ3kgaXMgYXZhaWxhYmxlIHRvIGFsbCBMaW51
eCB1c2Vycy48YnI+PGJyPsKgwqDCoCBGb3IgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGlzIHBy
b2plY3Q6IDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwX25l
dC1uZXh0L3dpa2kiPmh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1u
ZXh0L3dpa2k8L2E+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBkb24m
IzM5O3Qgd2FudCB0byBib3RoZXIgeW91IGZvciBhIG5ldyByZXZpZXcuIEkgaG9wZSBhbmQgSSBn
dWVzcyBpdCBpcyBmaW5lIGZvciBldmVyeWJvZHkgOik8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5NYXR0aGlldTxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0
ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
Pjxicj48L2Rpdj48ZGl2Pk1hdHRoaWV1PC9kaXY+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbC1oNSI+
PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPgo8YnI+Cjxicj4KQ2hyaXN0b3BoPGJyPgo8ZGl2PjxkaXYg
Y2xhc3M9ImdtYWlsLW1fMzM1MDk1NzcwODMyOTIyNTUzNmg1Ij48YnI+Cjxicj4KPGJyPgomZ3Q7
IDxicj4KJmd0OyA8YnI+CiZndDsgQ2hyaXN0b3BoPGJyPgomZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxi
cj4KJmd0OyAmZ3Q7IE1hdHRoaWV1PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgom
Z3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgQ2hyaXN0b3BoPGJyPgomZ3Q7ICZndDsg
Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsm
Z3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgSW50ZWwsIFRlc3Nh
cmVzPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7Jmd0OyZndDsgRGVzY3JpcHRpb24gb2YgcHJvcG9zYWw6PGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDvCoCDCoCDCoEEgcHJvamVjdCB0byBhZGQgYW4g
aW1wbGVtZW50YXRpb24gb2YgdGhlIE11bHRpUGF0aCBUQ1A8YnI+CiZndDsgJmd0OyAmZ3Q7IHBy
b3RvY29sIHRvPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgdGhlPGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyZndDsmZ3Q7IExpbnV4IGtlcm5lbCBpcyBpbiBwcm9ncmVzcyBieSBhIHNtYWxs
IGNvbW11bml0eS4gVGhlIGdvYWwgb2YgdGhpczxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jmd0OyZndDsgdHV0b3JpYWwgaXMgdG8gZGlzY292ZXIgd2hhdCBpcyB0aGlzIFRDUCBleHRlbnNp
b24gKFJGQyA2ODI0KSwgd2hhdDxicj4KJmd0OyAmZ3Q7ICZndDsgYXJlIHRoZTxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgZGlmZmVyZW50IHVzZS1jYXNlcyBhbHJlYWR5IGlu
IHByb2R1Y3Rpb24gYnkgc29tZSBjb21wYW5pZXMgYW5kIHdoYXQ8YnI+CiZndDsgJmd0OyAmZ3Q7
IGFyZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgdGhlIGNoYWxsZW5nZXMg
dG8gdXBzdHJlYW0gTVBUQ1AuIFdlIGhvcGUgaGF2aW5nIGludGVyYWN0aXZlPGJyPgomZ3Q7ICZn
dDsgJmd0OyBkaXNjdXNzaW9uczxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsg
YW5kIGdldHRpbmcgZmVlZGJhY2sgZnJvbSBleHBlcmllbmNlZCBkZXZlbG9wZXJzIHdpbGwgaGVs
cCB1cyBpbjxicj4KJmd0OyAmZ3Q7ICZndDsgdGhpcyB0YXNrPGJyPgomZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsmZ3Q7Jmd0OyBvZiBlYXNpbHkgYnJpbmdpbmcgTVBUQ1AgdG8gYWxsIExpbnV4IHVz
ZXJzLCBhIHRlY2hub2xvZ3kgYWxyZWFkeTxicj4KJmd0OyAmZ3Q7ICZndDsgdXNlZCBieTxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgbWlsbGlvbnMgb2YgcGVvcGxlLjxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDvCoCDCoCDCoEluIGEgYml0
IG1vcmUgZGV0YWlsLCB3ZSB3aWxsIHN0YXJ0IHdpdGggYSBiYXNpYyBpbnRyb2R1Y3Rpb24gb2Y8
YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBNUFRDUC48YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7Jmd0OyZndDsgQSBmZXcgdXNlLWNhc2VzIHdpbGwgYmUgcHJlc2VudGVkIHdpdGggYSBkZW1v
IHRvIGV4cGxhaW4gaG93IHVzZWZ1bDxicj4KJmd0OyAmZ3Q7ICZndDsgdGhpczxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgcHJvdG9jb2wgaXMgaW4gdG9kYXkmIzM5O3MgSW50
ZXJuZXQgYW5kIGhvdyBpdCBjYW4gYmUgZXh0ZW5kZWQgd2l0aDxicj4KJmd0OyAmZ3Q7ICZndDsg
QVBJJiMzOTtzIGxpa2U8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7IE5ldGxp
bmsgYW5kIEJQRi48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7
IEkgcmVjb2duaXplIGhvdyBOZXRsaW5rIGlzIGFzc29jaWF0ZWQgd2l0aCBhIHVzZXJzcGFjZSBw
YXRoIG1hbmFnZXIsPGJyPgomZ3Q7ICZndDsgJmd0OyBidXQ8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDsgd2hhdCYjMzk7cyB0aGUgQlBGIGV4dGVuc2liaWxpdHkgeW91JiMzOTtyZSBy
ZWZlcnJpbmcgdG8/PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBJdCB3YXMgb25s
eSB0byBtZW50aW9uIHRoYXQgaXQgd291bGQgYmUgcG9zc2libGUgdG8gZXh0ZW5kIE1QVENQIHdp
dGg8YnI+CiZndDsgJmd0OyAmZ3Q7IGVCUEYuPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
RXZlbiBpZiBpdCBpcyBub3QgYWxyZWFkeSBhdmFpbGFibGUgaW4gdGhlIGN1cnJlbnQgT3Blbi1T
b3VyY2U8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBpbXBsZW1lbnRhdGlvbiwgdGhlcmUg
aXMgYWxyZWFkeSB0aGUgcG9zc2liaWxpdHkgdG8gZ2V0IGEgdmVyc2lvbiB3aXRoPGJyPgomZ3Q7
ICZndDsgJmd0OyBhPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgcHJvZ3JhbW1hYmxlIHNj
aGVkdWxlcjogPGEgaHJlZj0iaHR0cHM6Ly9wcm9nbXAubmV0IiByZWw9Im5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIj5odHRwczovL3Byb2dtcC5uZXQ8L2E+PGJyPgomZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBUaGVuIHdlIHdpbGwgaGF2ZSBz
b21lIGV4cGxhbmF0aW9ucyBhYm91dCBob3cgTVBUQ1AgaXMgY3VycmVudGx5PGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyBpbXBsZW1lbnRlZC4gVGhpcyBjdXJyZW50IGltcGxl
bWVudGF0aW9uIGlzIHF1aXRlIGludHJ1c2l2ZSBhbmQgdGhhdDxicj4KJmd0OyAmZ3Q7ICZndDsg
aXM8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7IGNlcnRhaW5seSBub3Qgc29t
ZXRoaW5nIHdlIHdvdWxkIGxpa2UgdG8gaGF2ZSB1cHN0cmVhbS4gV2Ugd291bGQ8YnI+CiZndDsg
Jmd0OyAmZ3Q7IGxpa2UgdG88YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7IGV4
cHJlc3Mgd2hhdCB3ZSBoYXZlIGluIG1pbmQgdG8gY2hhbmdlIHRoYXQsIHdpdGggc29tZSBzYW1w
bGVzIGFuZDxicj4KJmd0OyAmZ3Q7ICZndDsgaW5pdGlhdGU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDsmZ3Q7IGRpc2N1c3Npb25zLjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyZndDsgTXkgZWRpdCBvZiB0aGUgYWJvdmU6PGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7ICZxdW90OyZx
dW90OyZxdW90Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7Jmd0OyBBIGNvbW11bml0eSBwcm9qZWN0IGlzIHVuZGVyd2F5IHRvIGFk
ZCBNdWx0aXBhdGggVENQIHRvIHRoZSB1cHN0cmVhbTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7Jmd0OyBMaW51eCBrZXJuZWwuIFRoaXMgdHV0b3JpYWwgd2lsbCBpbnRyb2R1Y2UgdGhlIGF1
ZGllbmNlIHRvIHRoaXMgVENQPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IGV4dGVu
c2lvbiAoUkZDIDY4MjQpLCBzaG93IHNvbWUgdXNlIGNhc2VzIGFscmVhZHkgaW4gcHJvZHVjdGlv
biwgYW5kPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IGRpc2N1c3MgdGhlIGNoYWxs
ZW5nZXMgaW4gY29udmVyZ2luZyBvbiBhbiB1cHN0cmVhbSBNUFRDUDxicj4KJmd0OyAmZ3Q7ICZn
dDsgaW1wbGVtZW50YXRpb24uPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBTaG91
bGQgd2UgaW5zaXN0IG9uIHRoZSAmcXVvdDtkaXNjdXNzaW9uJnF1b3Q7IHBhcnQ/IExpa2Ugc2F5
aW5nOiAmcXVvdDtkaXNjdXNzIHdpdGg8YnI+CiZndDsgJmd0OyAmZ3Q7IHRoZTxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7IGF1ZGllbmNlJnF1b3Q7PyAmcXVvdDtoYXZlIGludGVyYWN0aXZl
IGRpc2N1c3Npb25zJnF1b3Q7Pzxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IEl0IGlzIG1h
eWJlIG5vdCBuZWVkZWQgYnV0IGl0IHdhcyBtYWlubHkgdG8gZXhwcmVzcyB0aGUgaW50ZXJhY3Rp
dml0eSw8YnI+CiZndDsgJmd0OyAmZ3Q7IGl0PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsg
aXMgYSB0dXRvcmlhbCwgbm90IGp1c3QgYSAmcXVvdDtzaW1wbGUmcXVvdDsgcHJlc2VudGF0aW9u
Ljxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgV2Ugd2lsbCB1c2UgdGhlIGN1cnJlbnQgTVBUQ1AgaW1wbGVtZW50YXRpb24gdG8gZGVtb25z
dHJhdGUgdGhlPGJyPgomZ3Q7ICZndDsgJmd0OyB1dGlsaXR5IG9mPGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsmZ3Q7IHRoZSBwcm90b2NvbCBvbiB0b2RheSYjMzk7cyBpbnRlcm5ldCwgYW5k
IHRvIHNob3cgaG93IHRoaXMgaW1wbGVtZW50YXRpb248YnI+CiZndDsgJmd0OyAmZ3Q7IGNhbjxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyBjdXJyZW50bHkgYmUgZXh0ZW5kZWQgd2l0
aCBuZXRsaW5rIGFuZCBCUEYuIFRoaXMgbm90IG9ubHkgaGFzPGJyPgomZ3Q7ICZndDsgJmd0OyBw
cmFjdGljYWw8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsgYXBwbGljYXRpb24gZm9y
IGRlcGxveWluZyBNUFRDUCBub3csIGJ1dCBhbHNvIGlsbHVzdHJhdGVzIGhvdyB0aGU8YnI+CiZn
dDsgJmd0OyAmZ3Q7IEFQSXMgYW5kPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IGNv
ZGUgd2lsbCBuZWVkIHRvIGV2b2x2ZSBpbiBvcmRlciB0byBwcm9wZXJseSBjb2V4aXN0IHdpdGgg
dGhlPGJyPgomZ3Q7ICZndDsgJmd0OyBvcHRpbWl6ZWQ8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsg
Jmd0OyZndDsgTGludXggVENQIGNvcmUgd2UgYWxsIHJlbHkgb24uIFdlIHdpbGwgZGlzY3VzcyBv
dXIgaWRlYXMgZm9yIGJyaW5naW5nPGJyPgomZ3Q7ICZndDsgJmd0OyBNUFRDUDxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyB0byB0aGUgdXBzdHJlYW0ga2VybmVsIHNvIHRoZSB0ZWNo
bm9sb2d5IGlzIGF2YWlsYWJsZSB0byBhbGwgTGludXg8YnI+CiZndDsgJmd0OyAmZ3Q7IHVzZXJz
Ljxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgVG8gJnF1b3Q7YXR0cmFjdCZxdW90
OyBwZW9wbGUsIHNob3VsZCB3ZSBtZW50aW9uIHRoYXQgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b248YnI+CiZndDsgJmd0OyAmZ3Q7IGlzPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsgYWxy
ZWFkeSB1c2VkIGJ5IG1pbGxpb25zIG9mIHVzZXJzPzxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IEkgbGlrZSBob3cgeW91ciBpbXByb3ZlIHRoZSBsYXN0IGJpdCA6LSk8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZxdW90OyZxdW90
OyZxdW90Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7Jmd0OyBGZWVsIGZyZWUgdG8gZWRpdC9tZXJnZS9leHBhbmQvZGlzY2FyZCBh
cyBuZWVkZWQgOik8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRoYW5rIHlvdSBm
b3IgeW91ciBlZGl0LCBpdCBpcyBpbmRlZWQgY2xlYW5lciE8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqBGb3IgbW9yZSBpbmZv
cm1hdGlvbiBhYm91dCB0aGlzIHByb2plY3Q6PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7IDxhIGhyZWY9
Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwX25ldC1uZXh0L3dpa2kiIHJl
bD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBh
dGgtdDx3YnI+Y3AvbXB0Y3BfbmV0LW5leHQvd2lraTwvYT48YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDsgJmd0OyBJIGd1ZXNzIEkgY2FuIGtlZXAgdGhpcywgcmlnaHQ/PGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBQbGVhc2Ug
ZmVlbCBmcmVlIHRvIGNvbW1lbnQgdGhpcyBhcyB3ZWxsLiBXZSBhcmUgc3RpbGwgZmFyIGZyb20g
dGhlIG1heDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgMzUwIHdvcmRzIGxp
bWl0IHdlIGZvdW5kIGxhc3QgdGltZS4gQnV0IG9uIHRoZSBvdGhlciBoYW5kLCBJIGNhbiBubzxi
cj4KJmd0OyAmZ3Q7ICZndDsgbG9uZ2VyPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7
Jmd0OyBmaW5kIHRoaXMgbGltaXQgb24gdGhlaXIgd2Vic2l0ZSA6KTxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+
CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsgSG9wZSB0aGUgYWJvdmUgaXMgaGVscGZ1bC4g
VGhhbmtzIGFnYWluIGZvciB5b3VyIHdvcmsgb24gdGhpczxicj4KJmd0OyAmZ3Q7ICZndDsgcHJv
cG9zYWwuPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyBZZXMgaXQgaXMsIHRoYW5r
IHlvdSBmb3IgeW91ciBoZWxwITxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsgTWF0dGhpZXU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7IE1hdDxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgVGhhbmsgeW91IGZvciB5
b3VyIGhlbHAhPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsgSGF2ZSBhIGdvb2QgZGF5L2V2ZW5pbmcsPGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyBNYXR0aGlldTxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7
IE9uIDI1LzA0LzIwMTggMjE6NTgsIE1hdCBNYXJ0aW5lYXUgd3JvdGU6PGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZn
dDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgSGkgTWF0dGhp
ZXUgLTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgT24gRnJpLCAyMCBBcHIgMjAxOCwgTWF0dGhp
ZXUgQmFlcnRzIHdyb3RlOjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgSGVsbG8sPGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7
Jmd0OyZndDsmZ3Q7IE5ldERldiAweDEyIGlzIGNvbWluZyB0byBNb250csOpYWwgdGhpcyBzdW1t
ZXI6IEp1bHkgMTF0aCB0byAxM3RoLDxicj4KJmd0OyAmZ3Q7ICZndDsgMjAxOC48YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsm
Z3Q7Jmd0OyZndDsgV2UgYWxyZWFkeSB0YWxrZWQgYWJvdXQgdGhpcyBldmVudCBvbiB0aGlzIE1M
IGFuZCBhdCBvdXIgd2Vla2x5PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7IG1lZXRpbmdzIGJ1dCBoZXJlIGlzIGEgc3VtbWFyeSBvZiB0aGUgZGlzY3Vzc2lvbnMg
d2UgaGFkOjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gd2Ugd291bGQgbGlr
ZSB0byBoYXZlIGEgcHJlc2VudGF0aW9uIHRoZXJlIG1haW5seSB0byBnZXQ8YnI+CiZndDsgJmd0
OyAmZ3Q7IGZlZWRiYWNrPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7IGFuZCBhZHZpY2UgZnJvbSBvdGhlciBrZXJuZWwgZGV2ZWxvcGVyczxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gYSBwcmVzZW50YXRpb24gd291bGQg
Y2xlYXJseSBpbmRpY2F0ZSB0aGF0IHRoaXMgTVBUQ1AgVXBzdHJlYW08YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgcHJvamVjdCBleGlzdHMgYW5kIHdlIGNvdWxk
IGdldCBoZWxwIGZyb20gbW9yZSBkZXZlbG9wZXJzPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDsmZ3Q7wqAgLSB3ZSB3b3VsZCBsaWtlIHRvIGluZGljYXRlIHRoYXQgaGF2
aW5nIE1QVENQIHVwc3RyZWFtIGlzIGFza2VkIGJ5PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDsmZ3Q7IGRpZmZlcmVudCBjb21wYW5pZXMsIHNvbWUgYXJlIGV2ZW4gcmVh
ZHkgdG8gY29udHJpYnV0ZSA7IGl0IGlzIHRoZW48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyZndDsgaW1wb3J0YW50IHRvIGhhdmUgTVBUQ1AgdXBzdHJlYW08YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZn
dDsmZ3Q7Jmd0OyZndDsgQWxzbyBub3RlIHRoYXQ6PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7wqAgLSBEYXZpZCBNaWxsZXIgd2lsbCBub3QgYmUgcHJlc2VudCBpbiBNb250csOpYWwg
WzFdIGJ1dCBvdGhlciBtYWluPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7IGNvbnRyaWJ1dG9ycyBzaG91bGQgYmUgdGhlcmUgKHdlIGRvbiYjMzk7dCBoYXZlIGEg
bGlzdCk8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7Jmd0OyZndDsmZ3Q7IFNpZGUgbm90ZSwgaW4gdGhlIHBhc3QgZGF5IERhdmlkIHJlaXRl
cmF0ZWQgaGlzIHN0YXRlbWVudCBhYm91dCBub3Q8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyBhdHRlbmRpbmcgb3Igc3VwcG9ydGluZyB0aGUgY29uZmVyZW5jZTo8YnI+
CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsg
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4
LW5ldGRldiZhbXA7bT0xNTI0NjY4MjcyMDMzMDEmYW1wO3c9MiIgcmVsPSJub3JlZmVycmVyIiB0
YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbmV0PHdicj5kZXYmYW1w
O209MTUyNDY2ODI3MjAzMzAxJmFtcDt3PTI8L2E+PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0O8Kg
IC0gQSBwcmVzZW50YXRpb24gYnkgT2N0YXZpYW4gUHVyZGlsYSBhYm91dCAmcXVvdDtNUFRDUCBV
cHN0cmVhbWluZyZxdW90OyBoYXM8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7
Jmd0OyZndDsgYWxyZWFkeSBiZWVuIGdpdmVuIGluIDIwMTUgKE5ldERldiAwLjEpIFsyXTxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gMyB0eXBlcyBvZiBw
cmVzZW50YXRpb24gYXJlIGF2YWlsYWJsZTogdGFsa3MsIHR1dG9yaWFscyBhbmQ8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgd29ya3Nob3BzIFszXTxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gQ2FsbCBmb3IgUHJlc2Vu
dGF0aW9uIFByb3Bvc2FscyBjbG9zZXMgb24gTWF5IDFzdCwgMjAxOC48YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0
OyZndDsgVGhlIGN1cnJlbnQgaWRlYSB3ZSBicmllZmx5IGRpc2N1c3NlZCBkdXJpbmcgb3VyIHdl
ZWtseSBtZWV0aW5nczxicj4KJmd0OyAmZ3Q7ICZndDsgaXMgdG88YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgZ2l2ZSBhIHR1dG9yaWFsOjxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gSXQgaXMgbm90IHVzZWZ1bCB0byBnaXZlIGFsbW9zdCB0
aGUgc2FtZSBwcmVzZW50YXRpb24gYXMgdGhlPGJyPgomZ3Q7ICZndDsgJmd0OyBvbmUgb2Y8YnI+
CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgT2N0YXZpYW48YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCAtIEl0IHdpbGwgYWxsb3cg
dXMgbW9yZSBmbGV4aWJpbGl0eSBzb21laG93IHRvIGV4cGxhaW4gd2hhdCBpczxicj4KJmd0OyAm
Z3Q7ICZndDsgTVBUQ1AsPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7IHRoZSBkaWZmZXJlbnQgdXNlLWNhc2VzLCB3aHkgaXQgaXMgaW1wb3J0YW50IHRvIGhhdmUg
aXQgdXBzdHJlYW08YnI+CiZndDsgJmd0OyAmZ3Q7IGFuZCB3aGF0PGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IHByb2JsZW1zIHdlIGFyZSBjdXJyZW50bHkgZmFj
aW5nLjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gRGF2
aWQgTWlsbGVyIGFuZCBtYW55IG90aGVyIGtlcm5lbCBkZXZlbG9wZXJzIHdpbGwgZ28gdG8gTFBD
IGluPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IE5vdmVtYmVy
OiBhIGdvb2QgcGxhY2UgdG8gZ2l2ZSBhIHRhbGsgdGhpcyB0aW1lLjxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyBEbyB5b3UgaGF2ZSBhbnkgaWRlYXMgb24gd2hhdCB3ZSBjb3VsZCBzaG93IGluIHRoaXMg
dHV0b3JpYWw/PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IEkgcmVjZW50bHkgZGlzY3Vzc2VkIHdpdGgg
bXkgY29sbGVhZ3VlIE9saXZpZXIgQm9uYXZlbnR1cmUgd2hvIGhhczxicj4KJmd0OyAmZ3Q7ICZn
dDsgYTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBsb3Qgb2Yg
ZXhwZXJpZW5jZXMgaW4gZ2l2aW5nIGRpZmZlcmVudCBpbnRyb2R1Y3Rpb25zIGFuZCBtb3JlPGJy
PgomZ3Q7ICZndDsgJmd0OyBhYm91dCBNUFRDUDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0OyBhbmQgaGVyZSBpcyB3aGF0IGhlIHN1Z2dlc3RzOjxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gQSBmaXJzdCBwYXJ0IGFib3V0IGEgYmFzaWMgaW50
cm9kdWN0aW9uIG9mIE1QVENQPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7wqAgLSBJbmRpY2F0ZSBkaWZmZXJlbnQgdXNlLWNhc2VzIC0tIGlmIHBvc3NpYmxlIHdp
dGggYSAmcXVvdDtjbG9zZWQ8YnI+CiZndDsgJmd0OyAmZ3Q7IGRlbW8mcXVvdDsgdG88YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgYmUgc3VyZSBpdCBpcyB3b3Jr
aW5nIC0tIGFza2luZyBwZW9wbGUgdG8gc2V0dXAgc29tZXRoaW5nIGlzIG5vdDxicj4KJmd0OyAm
Z3Q7ICZndDsgZWFzeSBpbjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyAxaCwgbWF4IDFoMzAuPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0O8KgIEZyb20gdGhlIGRlc2NyaXB0aW9uIGF0
IFszXSwgZWl0aGVyICZxdW90O2luc3RydWN0b3ItbGVkJnF1b3Q7IDYwLTkwIG1pbnV0ZTxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IHR1dG9yaWFscyBvciAmcXVvdDtz
dHVkZW50LXBhcnRpY2lwYXRpb24mcXVvdDsgMi0zIGhvdXIgc2Vzc2lvbnMgYXJlPGJyPgomZ3Q7
ICZndDsgJmd0OyBwb3NzaWJsZS4gVGhlPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7
Jmd0OyZndDsgY2xvc2VkIGRlbW8gbWFwcyB3ZWxsIHRvIHRoZWlyICZxdW90O2luc3RydWN0b3It
bGVkJnF1b3Q7IGNhdGVnb3J5LiBMb29raW5nPGJyPgomZ3Q7ICZndDsgJmd0OyBhdCB0aGU8YnI+
CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBzY2hlZHVsZSwgdGhlIHBhc3Qg
dHdvIE5ldGRldiBDb25mZXJlbmNlcyBoYXZlIGhhZCBvbmUgdHV0b3JpYWw8YnI+CiZndDsgJmd0
OyAmZ3Q7IGVhY2gsIG9mPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsg
NjAtNzAgbWludXRlcy4gSSB0aGluayBpdCBoZWxwcyB0byBiZSBjbG9zZXIgdG8gYW4gaG91ciBp
biBsZW5ndGg8YnI+CiZndDsgJmd0OyAmZ3Q7IHRvIGhvbGQ8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyB0aGUgYXVkaWVuY2UmIzM5O3MgYXR0ZW50aW9uLjxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsmZ3Q7Jmd0OyZndDvCoCAtIFRoZW4gdHJ5aW5nIHRvIGhhdmUgaW50ZXJhY3RpdmUgZGlz
Y3Vzc2lvbnMgb3IgZXhwbGFuYXRpb25zIGFib3V0PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDsmZ3Q7IGhvdyBNUFRDUCBpcyBjdXJyZW50bHkgaW1wbGVtZW50ZWQgb3Ig
c2hvdWxkIGJlIGltcGxlbWVudGVkIGlmIGl0PGJyPgomZ3Q7ICZndDsgJmd0OyBnb2VzPGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IHVwc3RyZWFtLCBlLmcuOiBm
b3IgTVBUQ1AsIHdlIG5lZWQgdG8gaGF2ZSBleHRyYSBUQ1AgT3B0aW9ucywgd2U8YnI+CiZndDsg
Jmd0OyAmZ3Q7IG5lZWQgdG88YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0
OyZndDsgc3VwcG9ydCBtaWRkbGVib3hlcywgd2UgbmVlZCB0byBsaW5rIHN1YmZsb3dzIG9mIHRo
ZSBzYW1lPGJyPgomZ3Q7ICZndDsgJmd0OyBjb25uZWN0aW9uPGJyPgomZ3Q7ICZndDsgJmd0OyAm
Z3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IHRvZ2V0aGVyLCB3ZSBuZWVkIGEgc2NoZWR1bGVyLCBh
IFBNLCBldGMuPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBJdCYjMzk7cyBkaWZmaWN1bHQgdG8gcHJlZGljdCBob3cg
aW50ZXJhY3RpdmUgYW4gYXVkaWVuY2Ugd2lsbCBiZS4gSSYjMzk7dmU8YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBvbmx5IGF0dGVuZGVkIG9uZSBOZXRkZXYgQ29uZmVy
ZW5jZSwgYW5kIGl0IHNlZW1lZCBsaWtlIHRoZXJlIHdlcmU8YnI+CiZndDsgJmd0OyAmZ3Q7IGEg
bG90PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgbW9yZSBwZW9wbGUg
d2l0aCBleHBlcnRpc2UgYW5kIGludGVyZXN0IGluIGRyaXZlcnMsIGxvd2VyIGxheWVyczxicj4K
Jmd0OyAmZ3Q7ICZndDsgKFhEUCwgQlBGLDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0
OyZndDsmZ3Q7IFRDLCBuZXRmaWx0ZXIpLCBhbmQgbmV0d29yayB0b3BvbG9neS9zaW11bGF0aW9u
LiBEaXNjdXNzaW9uIGFyb3VuZDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsm
Z3Q7IG1pZGRsZWJveCBzdXBwb3J0IGFuZCB0aGUgdXNlcnNwYWNlIEFQSSBtaWdodCBoYXZlIG1v
cmUgYXVkaWVuY2U8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBpbnRl
cmFjdGlvbi4gSWYgd2Ugd2FudCB0byBkcml2ZSBhIGRpc2N1c3Npb24sIHdlIGNvdWxkIHRyeSB0
bzxicj4KJmd0OyAmZ3Q7ICZndDsgc3RyaWtlIGE8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyBiYWxhbmNlIGJldHdlZW4gdG9waWNzIGZvciB0aGUgYnJvYWRlciBhdWRp
ZW5jZSBhbmQgdGhvc2Ugd2l0aCBtb3JlPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7
Jmd0OyZndDsga25vd2xlZGdlIG9mIFRDUCBpbnRlcm5hbHMuIChIb3BlZnVsbHkgc29tZSBUQ1Ag
aW50ZXJuYWxzIHBlb3BsZTxicj4KJmd0OyAmZ3Q7ICZndDsgYXJlIHN0aWxsPGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgcGxhbm5pbmcgdG8gYXR0ZW5kKTxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICZndDsmZ3Q7Jmd0OyZndDvCoCAtIE9mIGNvdXJzZSwgd2Ugc2hvdWxkIGZvY3VzIG91ciBkaXNj
dXNzaW9ucyBvbiB0aGUgdXBzdHJlYW1pbmc8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZn
dDsmZ3Q7Jmd0OyZndDsgYXNwZWN0LCBlLmcuIHJlZHVjaW5nIHRoZSBmb290cHJpbnQgb2YgTVBU
Q1AgaW4gdGhlIGN1cnJlbnQgVENQPGJyPgomZ3Q7ICZndDsgJmd0OyBzdGFjazogd2hhdDxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBhcmUgd2UgYWxsb3cgdG8g
ZG8sIHdoYXQgbm90LiBJdCBpcyBsaW5rZWQgdG8gbWFueSBwcmV2aW91czxicj4KJmd0OyAmZ3Q7
ICZndDsgZGlzY3Vzc2lvbnMgd2U8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7
Jmd0OyZndDsgaGFkIG9uIHRoaXMgTUwsIGUuZy4gd2h5IHdlIG5lZWQgbW9yZSBpbmRpcmVjdCBm
dW5jdGlvbiBjYWxscyBhbmQ8YnI+CiZndDsgJmd0OyAmZ3Q7IGhvdyB0bzxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyByZWR1Y2UgdGhlIGltcGFjdCwgZXRjLjxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsgVGhlIHByZXZpb3VzIHRhbGsgKFsyXSkgaGFkIGEgc2VjdGlvbiBsaWtlIHRo
aXMuIEkgaGF2ZW4mIzM5O3Qgd2F0Y2hlZDxicj4KJmd0OyAmZ3Q7ICZndDsgaXQ8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyByZWNlbnRseSwgSSBzaG91bGQgbG9vayBh
dCBpdCBhZ2FpbiB0byBzZWUgd2hhdCBraW5kIG9mIHF1ZXN0aW9uczxicj4KJmd0OyAmZ3Q7ICZn
dDsgdGhlPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgYXVkaWVuY2Ug
d2FzIGFza2luZy4gQXMgeW91IG1lbnRpb25lZCBhYm92ZSB3ZSBzaG91bGQgYmUgY2FyZWZ1bCB0
bzxicj4KJmd0OyAmZ3Q7ICZndDsgaGF2ZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0
OyZndDsmZ3Q7IG5ldyBjb250ZW50IGNvbXBhcmVkIHRvIHRoZSBwcmV2aW91cyBzZXNzaW9uLjxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDvCoCAtIElmIHdlIGhhdmUgdGltZSwgd2UgY291bGQgZGlz
Y3VzcyBhYm91dCBob3cgdXNlcnMgY291bGQgaW50ZXJhY3Q8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgd2l0aCBNUFRDUDogZW5hYmxlIGl0IHBlciBjb25uZWN0
aW9uLCBjb250cm9sIHRoZSBwYXRoIG1hbmFnZXIsPGJyPgomZ3Q7ICZndDsgJmd0OyBtYXliZSB0
aGU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgc2NoZWR1bGVy
LCBldGMuPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoaXM/
IEZlZWwgZnJlZSB0byBjb21tZW50IGFuZCBldmVuIHByb3Bvc2U8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgY29tcGxldGVseSBkaWZmZXJlbnQgaWRlYXMhPGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZn
dDsmZ3Q7Jmd0OyBUaGFuayB5b3UgZm9yIG91dGxpbmluZyB0aGVzZSBpZGVhcy4gSSBzZWUgdGhh
dCB0aGlzIHRvcGljIGlzIG9uIG91cjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZn
dDsmZ3Q7IG1lZXRpbmcgYWdlbmRhIHNvIGl0IHdpbGwgYmUgZ29vZCB0byBkaXNjdXNzIHRoZSB0
dXRvcmlhbCB0aGVyZS48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgWzFdIDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMuMDEub3Jn
L3BpcGVybWFpbC9tcHRjcC8yMDE4LU1hcmNoLzAwMDM3OS5odG1sIiByZWw9Im5vcmVmZXJyZXIi
IHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWw8d2JyPi9tcHRj
cC8yMDE4LU1hcmNoLzAwMDM3OS5odG1sPC9hPjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0OyBbMl0gPGEgaHJlZj0iaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0
Y2g/dj13ZnR6MmNVNVNacyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6
Ly93d3cueW91dHViZS5jb20vd2F0Y2g/PHdicj52PXdmdHoyY1U1U1pzPC9hPjxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBbM10gPGEgaHJlZj0iaHR0cHM6Ly93
d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCIgcmVsPSJub3JlZmVy
cmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxPHdicj4y
L3N1Ym1pdC1wcm9wb3NhbC5odG1sPC9hPjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0
OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDsgJmd0OyZndDsgLS08YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDsgTWF0IE1h
cnRpbmVhdTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7Jmd0OyBJbnRlbCBPVEM8YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0Ozxi
cj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZndDs8
YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAtLTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAm
Z3Q7IFtpbWFnZTogVGVzc2FyZXMgU0FdICZsdDs8YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVz
Lm5ldCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cDovL3d3dy50ZXNzYXJl
cy5uZXQ8L2E+Jmd0OyBNYXR0aGlldSBCYWVydHMgfCBSJmFtcDtEPGJyPgomZ3Q7ICZndDsgJmd0
OyAmZ3Q7ICZndDsgRW5naW5lZXI8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyA8YSBocmVm
PSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCIgdGFyZ2V0PSJfYmxhbmsiPm1h
dHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ8L2E+PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZn
dDsgVGVzc2FyZXMgU0EgfCBIeWJyaWQgQWNjZXNzIFNvbHV0aW9uczxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IDxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0OyAmZ3Q7IDEgQXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEtTmV1
dmUsIEJlbGdpdW08YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgJmd0OyAmbHQ7PGEgaHJlZj0iaHR0
cHM6Ly93d3cuZ29vZ2xlLmNvbS9tYXBzP3E9MStBdmVudWUrSmVhbitNb25uZXQsKzEzNDgrIiBy
ZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5nb29nbGUuY29tL21h
cHM/cTx3YnI+PTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4KzwvYT48YnI+CiZndDsgJmd0OyAm
Z3Q7IE90dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZTx3YnI+bGdpdW0mZ3Q7PGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDsgLS08YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgW2ltYWdlOiBUZXNzYXJlcyBTQV0gJmx0Ozxh
IGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwOi8vd3d3LnRlc3NhcmVzLm5ldDwvYT4mZ3Q7IE1hdHRoaWV1IEJhZXJ0cyB8
IFImYW1wO0Q8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgRW5naW5lZXI8YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgPGEgaHJlZj0ibWFpbHRvOm1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQiIHRh
cmdldD0iX2JsYW5rIj5tYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PC9hPjxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyBUZXNzYXJlcyBTQSB8IEh5YnJpZCBBY2Nlc3MgU29sdXRpb25zPGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7IDxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiByZWw9
Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyAxIEF2ZW51ZSBKZWFuIE1vbm5ldCwgMTM0OCBMb3V2YWluLWxhLU5l
dXZlLCBCZWxnaXVtPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICZsdDs8YSBocmVmPSJodHRwczov
L3d3dy5nb29nbGUuY29tL21hcHM/cT0xK0F2ZW51ZStKZWFuK01vbm5ldCwrMTM0OCsiIHJlbD0i
bm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9x
PHdicj49MStBdmVudWUrSmVhbitNb25uZXQsKzEzNDgrPC9hPjxicj4KJmd0OyAmZ3Q7ICZndDsg
T3R0aWduaWVzLUxvdXZhaW4tbGEtTmV1dmUsK0JlPHdicj5sZ2l1bSZndDs8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgLS08YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgRElT
Q0xBSU1FUi48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgVGhpcyBlbWFpbCBhbmQgYW55IGZpbGVz
IHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVudGlhbDxicj4KJmd0OyAmZ3Q7ICZndDsg
Jmd0OyBhbmQgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9y
IGVudGl0eSB0byB3aG9tIHRoZXk8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgYXJlIGFkZHJlc3Nl
ZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVhc2Ugbm90aWZ5
PGJyPgomZ3Q7ICZndDsgJmd0OyB0aGU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgc3lzdGVtIG1h
bmFnZXIuIFRoaXMgbWVzc2FnZSBjb250YWlucyBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5k
IGlzPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IGludGVuZGVkIG9ubHkgZm9yIHRoZSBpbmRpdmlk
dWFsIG5hbWVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgbmFtZWQ8YnI+CiZndDsgJmd0OyAmZ3Q7IGFk
ZHJlc3NlZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyB5b3Ugc2hvdWxkIG5vdCBkaXNzZW1pbmF0
ZSwgZGlzdHJpYnV0ZSBvciBjb3B5IHRoaXMgZS1tYWlsLiBQbGVhc2U8YnI+CiZndDsgJmd0OyAm
Z3Q7IG5vdGlmeTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGJ5IGUtbWFpbCBpZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieTxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0OyBtaXN0YWtlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwgZnJvbSB5b3VyIHN5
c3RlbS4gSWYgeW91IGFyZSBub3QgdGhlPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IGludGVuZGVk
IHJlY2lwaWVudCB5b3UgYXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29weWluZyw8YnI+
CiZndDsgJmd0OyAmZ3Q7IGRpc3RyaWJ1dGluZzxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBvciB0
YWtpbmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpcyBpbmZv
cm1hdGlvbiBpczxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBzdHJpY3RseSBwcm9oaWJpdGVkLjxi
cj4KJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsg
Jmd0OyA8YnI+CiZndDsgJmd0OyAtLSA8YnI+CiZndDsgJmd0OyBbaW1hZ2U6IFRlc3NhcmVzIFNB
XSAmbHQ7PGEgaHJlZj0iaHR0cDovL3d3dy50ZXNzYXJlcy5uZXQiIHJlbD0ibm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cudGVzc2FyZXMubmV0PC9hPiZndDsgTWF0dGhpZXUg
QmFlcnRzIHwgUiZhbXA7RDxicj4KJmd0OyAmZ3Q7IEVuZ2luZWVyPGJyPgomZ3Q7ICZndDsgPGEg
aHJlZj0ibWFpbHRvOm1hdHRoaWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQiIHRhcmdldD0iX2JsYW5r
Ij5tYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PC9hPjxicj4KJmd0OyAmZ3Q7IFRlc3NhcmVz
IFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+CiZndDsgJmd0OyA8YSBocmVmPSJodHRw
Oi8vd3d3LnRlc3NhcmVzLm5ldCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+d3d3
LnRlc3NhcmVzLm5ldDwvYT48YnI+CiZndDsgJmd0OyAxIEF2ZW51ZSBKZWFuIE1vbm5ldCwgMTM0
OCBMb3V2YWluLWxhLU5ldXZlLCBCZWxnaXVtPGJyPgomZ3Q7ICZndDsgJmx0OzxhIGhyZWY9Imh0
dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4K090
dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxnaXVtIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj5odHRwczovL3d3dy5nb29nbGUuY29tL21hcHM/cTx3YnI+PTErQXZlbnVlK0pl
YW4rTW9ubmV0LCsxMzQ4K090PHdicj50aWduaWVzLUxvdXZhaW4tbGEtTmV1dmUsK0JlbGc8d2Jy
Pml1bTwvYT4mZ3Q7PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgLS0gPGJyPgomZ3Q7ICZn
dDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgRElTQ0xBSU1FUi48YnI+CiZndDsgJmd0
OyBUaGlzIGVtYWlsIGFuZCBhbnkgZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBhcmUgY29uZmlk
ZW50aWFsIDxicj4KJmd0OyAmZ3Q7IGFuZCBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2Yg
dGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRvIHdob20gdGhleSA8YnI+CiZndDsgJmd0OyBhcmUg
YWRkcmVzc2VkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9yIHBsZWFz
ZSBub3RpZnkgdGhlIDxicj4KJmd0OyAmZ3Q7IHN5c3RlbSBtYW5hZ2VyLiBUaGlzIG1lc3NhZ2Ug
Y29udGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBpcyA8YnI+CiZndDsgJmd0OyBp
bnRlbmRlZCBvbmx5IGZvciB0aGUgaW5kaXZpZHVhbCBuYW1lZC4gSWYgeW91IGFyZSBub3QgdGhl
IG5hbWVkIGFkZHJlc3NlZSA8YnI+CiZndDsgJmd0OyB5b3Ugc2hvdWxkIG5vdCBkaXNzZW1pbmF0
ZSwgZGlzdHJpYnV0ZSBvciBjb3B5IHRoaXMgZS1tYWlsLiBQbGVhc2Ugbm90aWZ5IDxicj4KJmd0
OyAmZ3Q7IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgZS1tYWlsIGlmIHlvdSBoYXZlIHJlY2Vp
dmVkIHRoaXMgZS1tYWlsIGJ5IDxicj4KJmd0OyAmZ3Q7IG1pc3Rha2UgYW5kIGRlbGV0ZSB0aGlz
IGUtbWFpbCBmcm9tIHlvdXIgc3lzdGVtLiBJZiB5b3UgYXJlIG5vdCB0aGUgPGJyPgomZ3Q7ICZn
dDsgaW50ZW5kZWQgcmVjaXBpZW50IHlvdSBhcmUgbm90aWZpZWQgdGhhdCBkaXNjbG9zaW5nLCBj
b3B5aW5nLCBkaXN0cmlidXRpbmcgPGJyPgomZ3Q7ICZndDsgb3IgdGFraW5nIGFueSBhY3Rpb24g
aW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgaW5mb3JtYXRpb24gaXMgPGJyPgom
Z3Q7ICZndDsgc3RyaWN0bHkgcHJvaGliaXRlZC48YnI+CjwvZGl2PjwvZGl2PiZndDsgX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fPHdicj5fX19fX19fX19fX19fX19fXzxicj4KJmd0OyBt
cHRjcCBtYWlsaW5nIGxpc3Q8YnI+CiZndDsgPGEgaHJlZj0ibWFpbHRvOm1wdGNwQGxpc3RzLjAx
Lm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm1wdGNwQGxpc3RzLjAxLm9yZzwvYT48YnI+CiZndDsgPGEg
aHJlZj0iaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9tcHRjcCIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9s
PHdicj5pc3RpbmZvL21wdGNwPC9hPjxicj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2
PjxzcGFuIGNsYXNzPSJnbWFpbC1IT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+PGJy
IGNsZWFyPSJhbGwiPjxicj4tLSA8YnI+PC9mb250Pjwvc3Bhbj48ZGl2IGNsYXNzPSJnbWFpbC1t
XzMzNTA5NTc3MDgzMjkyMjU1MzZnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+
PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48dGFibGUgc3R5bGU9ImZvbnQtZmFt
aWx5OiZxdW90O1RpbWVzIE5ldyBSb21hbiZxdW90OztsZXR0ZXItc3BhY2luZzpub3JtYWw7dGV4
dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3JtOm5vbmU7d29yZC1zcGFjaW5nOjBweCIgd2lkdGg9
IjEwMCUiIGJvcmRlcj0iMCI+PHRib2R5Pjx0cj48dGQgcm93c3Bhbj0iMyIgc3R5bGU9InBhZGRp
bmctbGVmdDo1cHg7cGFkZGluZy1yaWdodDo1cHgiIHdpZHRoPSIxMCIgdmFsaWduPSJ0b3AiIGFs
aWduPSJsZWZ0Ij48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgdGFyZ2V0PSJfYmxh
bmsiPjxpbWcgc3JjPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldC9zaWdsb2dvLnBuZyIgYWx0PSJU
ZXNzYXJlcyBTQSIgd2lkdGg9IjgwIiBoZWlnaHQ9IjgwIiBib3JkZXI9IjAiPjwvYT48L3RkPjx0
ZCBzdHlsZT0icGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2Vy
aWY7Zm9udC1zaXplOjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48c3BhbiBzdHlsZT0i
Zm9udC13ZWlnaHQ6Ym9sZDtjb2xvcjpyZ2IoMzcsODMsMTU1KTtkaXNwbGF5OmlubGluZSI+TWF0
dGhpZXUgQmFlcnRzIHwgUiZhbXA7RCBFbmdpbmVlcjwvc3Bhbj48L3RkPjwvdHI+PHRyPjx0ZCBz
dHlsZT0icGFkZGluZzowcHg7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7
Zm9udC1zaXplOjEwcHgiIGhlaWdodD0iMTIiIGFsaWduPSJsZWZ0Ij48YSBocmVmPSJtYWlsdG86
bWF0dGhpZXUuYmFlcnRzJTQwdGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0
ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPm1hdHRo
aWV1LmJhZXJ0c0B0ZXNzYXJlcy5uZXQ8YnI+PC9hPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJw
YWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNp
emU6MTBweCIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9y
OnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5UZXNzYXJlcyBTQSB8IEh5YnJpZCBBY2Nl
c3MgU29sdXRpb25zPGJyPjwvc3Bhbj48YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIg
c3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxp
bmUiIHRhcmdldD0iX2JsYW5rIj53d3cudGVzc2FyZXMubmV0PC9hPjxzcGFuPsKgPC9zcGFuPjxi
cj48YSBocmVmPSJodHRwczovL3d3dy5nb29nbGUuY29tL21hcHM/cT0xK0F2ZW51ZStKZWFuK01v
bm5ldCwrMTM0OCtPdHRpZ25pZXMtTG91dmFpbi1sYS1OZXV2ZSwrQmVsZ2l1bSIgc3R5bGU9ImNv
bG9yOnJnYigwLDAsMCk7dGV4dC1kZWNvcmF0aW9uOm5vbmU7ZGlzcGxheTppbmxpbmUiIHRhcmdl
dD0iX2JsYW5rIj4xIEF2ZW51ZSBKZWFuIE1vbm5ldCwgMTM0OCBMb3V2YWluLWxhLU5ldXZlLCBC
ZWxnaXVtPC9hPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9kaXY+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+CjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxiciBj
bGVhcj0iYWxsIj48YnI+LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBk
aXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBz
dHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFj
aW5nOm5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNp
bmc6MHB4IiB3aWR0aD0iMTAwJSIgYm9yZGVyPSIwIj48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIz
IiBzdHlsZT0icGFkZGluZy1sZWZ0OjVweDtwYWRkaW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2
YWxpZ249InRvcCIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0
IiB0YXJnZXQ9Il9ibGFuayI+PGltZyBzcmM9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xv
Z28ucG5nIiBhbHQ9IlRlc3NhcmVzIFNBIiB3aWR0aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0i
MCI+PC9hPjwvdGQ+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2Es
QXJpYWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQi
PjxzcGFuIHN0eWxlPSJmb250LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3Bs
YXk6aW5saW5lIj5NYXR0aGlldSBCYWVydHMgfCBSJmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+
PC90cj48dHI+PHRkIHN0eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJp
YWwsc2Fucy1zZXJpZjtmb250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxh
IGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHMlNDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xv
cjpyZ2IoMCwwLDApO3RleHQtZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9
Il9ibGFuayI+bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0
cj48dGQgc3R5bGU9InBhZGRpbmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5z
LXNlcmlmO2ZvbnQtc2l6ZToxMHB4IiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2Vp
Z2h0OmJvbGQ7Y29sb3I6cmdiKDM3LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNB
IHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cu
dGVzc2FyZXMubmV0IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9u
ZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNw
YW4+wqA8L3NwYW4+PGJyPjxhIGhyZWY9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTEr
QXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4K090dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxn
aXVtIiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5
OmlubGluZSIgdGFyZ2V0PSJfYmxhbmsiPjEgQXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZh
aW4tbGEtTmV1dmUsIEJlbGdpdW08L2E+PC90ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4KPC9kaXY+PC9kaXY+Cgo8YnI+CjxkaXY+PGJy
Pjxocj48L2Rpdj48Zm9udCBzaXplPSIxIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFu
YSxzYW5zLXNlcmlmO2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+RElTQ0xBSU1F
Ui48L3NwYW4+PGJyIHN0eWxlPSJmb250LWZhbWlseTpWZXJkYW5hLHNhbnMtc2VyaWY7YmFja2dy
b3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj48Zm9udCBjb2xvcj0iIzAwMDAwMCIgZmFjZT0i
VmVyZGFuYSwgc2Fucy1zZXJpZiIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUs
MjU1KSI+VGhpcyBlbWFpbCBhbmQgYW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNv
bmZpZGVudGlhbCBhbmQgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlk
dWFsIG9yIGVudGl0eSB0byB3aG9tIHRoZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGhhdmUgcmVj
ZWl2ZWQgdGhpcyBlbWFpbCBpbiBlcnJvciBwbGVhc2Ugbm90aWZ5IHRoZSBzeXN0ZW0gbWFuYWdl
ci4gVGhpcyBtZXNzYWdlIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgaXMg
aW50ZW5kZWQgb25seSBmb3IgdGhlIGluZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBhcmUgbm90IHRo
ZSBuYW1lZCBhZGRyZXNzZWUgeW91IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUg
b3IgY29weSB0aGlzIGUtbWFpbC4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGJ5IGUtbWFpbCBpZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieSBtaXN0YWtlIGFu
ZCBkZWxldGUgdGhpcyBlLW1haWwgZnJvbSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCB5b3UgYXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29w
eWluZywgZGlzdHJpYnV0aW5nIG9yIHRha2luZyBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIG9uIHRo
ZSBjb250ZW50cyBvZiB0aGlzIGluZm9ybWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPC9m
b250PjwvZm9udD4=
--===============5708680749589809769==--
