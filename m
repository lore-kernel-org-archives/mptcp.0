Content-Type: multipart/mixed; boundary="===============4381564022392928369=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 19:32:44 +0200
Message-ID: <CAKuKrB=8wGAd6bg7pXBaJPEyBkmm0=xdsSzPxU58R0qTW+JPbA@mail.gmail.com>
In-Reply-To: 20180430161235.GL19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 572

--===============4381564022392928369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 6:12 PM, Christoph Paasch <cpaasch(a)apple.com> wro=
te:

> Hello,
>
> On 30/04/18 - 09:05:41, Mat Martineau wrote:
> >
> > On Mon, 30 Apr 2018, Matthieu Baerts wrote:
> >
> > > Hi Mat,
> > >
> > > On Mon, Apr 30, 2018 at 5:37 PM, Mat Martineau <
> mathew.j.martineau(a)linux.intel.com> wrote:
> > >
> > >       On Sun, 29 Apr 2018, Matthieu Baerts wrote:
> > >
> > >             Hi Mat,
> > >
> > >             Thank you for your review and input!
> > >
> > >             On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau <
> mathew.j.martineau(a)linux.intel.com> wrote:
> > >
> > >                   Hi Matthieu -
> > >
> > >                   On Fri, 27 Apr 2018, Matthieu Baerts wrote:
> > >
> > >                         Hello,
> > >
> > >                         Following yesterday's discussion about NetDev
> 0x12, here is a proposition of mail to send to NetDev
> > >             committee. I
> > >                         already put some comments. Note that I have
> followed the submission guidelines from:
> > >                         https://www.netdevconf.org/
> 0x12/submit-proposal.html#proposals
> > >
> > >                         Please comment it before Monday morning. Sorry
> for the rush but the deadline is the 1st of May :)
> > >
> > >                               * Name(s) of the submitter(s): Christoph
> Paasch (Apple), Mat Martineau
> > >
> > >                         (Intel), Peter Krystad (Intel), Ossama Othman
> (Intel) and myself, Matthieu Baerts (Tessares)
> > >
> > >                         I wrote down the names of people who
> participated in the discussion in the ML and during the weekly
> > >             meetings. I can
> > >                         add more people if more people would like to
> join the preparation and presentation of this tutorial.
> > >                         @Christoph, Mat, Peter, Ossama: can I write
> your names there?
> > >
> > >
> > >                   Ossama won't be able to attend. It looks like most
> sessions have 1 or 2 presenters, so I don't know if 4 is too
> > >             many. I'm sure
> > >                   they'll give us some feedback if they want to limit
> the number of presenters.
> > >
> > >
> > >             OK thank you!
> > >             Yes indeed, I am sure they will say something if we are
> too many.
> > >
> > >                               * Title of the submission: MPTCP: from
> the basic to an upstreamable base
> > >
> > >
> > >                         We certainly need a better title, please
> comment!
> > >
> > >
> > >                   "Multipath TCP: Present Use Cases and an Upstream
> Future" ?
> > >
> > >
> > >             I was trying to find something that catch the attention
> but it is maybe not needed for these kind of presentation.
> > >
> > >                         > * Label (one of moonshot, nuts'n bolts,
> hands-on): hands-on
> > >
> > >                         "hands-on" seems to be the correct one
> according to the Submission Types.
> > >                         https://www.netdevconf.org/
> 0x12/submit-proposal.html#types
> > >
> > >
> > >                   It's a little bit of "nuts & bolts" too, but I agree
> that hands-on is the better match.
> > >
> > >
> > >             Thank you!
> > >
> > >                               * Submission type (one of talk,
> presentation, workshop): tutorial,
> > >
> > >                         instructor-led sessions (minimum 1 hour long
> and not to exceed 1.5 hours. The instructor will go over the
> > >             technology
> > >                         either through code review or execution and
> interact with the attendees.)
> > >
> > >                         I guess there is a typo here: presentation
> should be replaced by tutorial in the guidelines.
> > >
> > >                               Estimate of length of time for
> presentation: 1h
> > >
> > >
> > >                         That's what we agreed yesterday but I can
> change.
> > >
> > >                               Affiliations of submitters (needed for
> conflict of interest check): Apple,
> > >
> > >                         Intel, Tessares
> > >
> > >                               Description of proposal:
> > >                                   A project to add an implementation
> of the MultiPath TCP protocol to the
> > >
> > >                         Linux kernel is in progress by a small
> community. The goal of this tutorial is to discover what is this
> > >             TCP extension
> > >                         (RFC 6824), what are the different use-cases
> already in production by some companies and what are the
> > >             challenges to
> > >                         upstream MPTCP. We hope having interactive
> discussions and getting feedback from experienced developers
> > >             will help us
> > >                         in this task of easily bringing MPTCP to all
> Linux users, a technology already used by millions of
> > >             people.
> > >
> > >
> > >                                   In a bit more detail, we will start
> with a basic introduction of MPTCP.
> > >
> > >                         A few use-cases will be presented with a demo
> to explain how useful this protocol is in today's Internet
> > >             and how it
> > >                         can be extended with API's like Netlink and
> BPF.
> > >
> > >
> > >                   I recognize how Netlink is associated with a
> userspace path manager, but what's the BPF extensibility you're
> > >             referring to?
> > >
> > >
> > >             It was only to mention that it would be possible to extend
> MPTCP with eBPF.
> > >             Even if it is not already available in the current
> Open-Source implementation, there is already the possibility to
> > >             get a version with a
> > >             programmable scheduler: https://progmp.net
> > >
> > >
> > > If we don't have something specific to our effort with BPF, I'm not
> sure it belongs in the summary. But I don't have a strong opinion
> > > about it.
> > >
> > >
> > > We are saying that "the [Open-Source] implementation can currently be
> extended with netlink and BPF". It can come later :)
> > >
> > >                         Then we will have some explanations about how
> MPTCP is currently implemented. This current implementation
> > >             is quite
> > >                         intrusive and that is certainly not something
> we would like to have upstream. We would like to express
> > >             what we have
> > >                         in mind to change that, with some samples and
> initiate discussions.
> > >
> > >
> > >                   My edit of the above:
> > >
> > >                   """
> > >
> > >                   A community project is underway to add Multipath TCP
> to the upstream Linux kernel. This tutorial will introduce
> > >             the audience to
> > >                   this TCP extension (RFC 6824), show some use cases
> already in production, and discuss the challenges in
> > >             converging on an upstream
> > >                   MPTCP implementation.
> > >
> > >
> > >             Should we insist on the "discussion" part? Like saying:
> "discuss with the audience"? "have interactive discussions"?
> > >             It is maybe not needed but it was mainly to express the
> interactivity, it is a tutorial, not just a "simple"
> > >             presentation.
> > >
> > >
> > >       I think it's ok to mention that - while I left the word
> "discuss" in there for that reason, maybe that's not obvious or clear
> > >       enough.
> > >
> > >
> > > It was maybe me, maybe no need to insist :-)
> > >
> > >                   We will use the current MPTCP implementation to
> demonstrate the utility of the protocol on today's internet,
> > >             and to show how this
> > >                   implementation can currently be extended with
> netlink and BPF. This not only has practical application for
> > >             deploying MPTCP now,
> > >                   but also illustrates how the APIs and code will need
> to evolve in order to properly coexist with the optimized
> > >             Linux TCP core we
> > >                   all rely on. We will discuss our ideas for bringing
> MPTCP to the upstream kernel so the technology is available
> > >             to all Linux
> > >                   users.
> > >
> > >
> > >             To "attract" people, should we mention that the current
> implementation is already used by millions of users?
> > >             I like how your improve the last bit :-)
> > >
> > >
> > >       Sure. I liked that in your text, but ran out of time figuring
> out how to fit it in to the last sentence :)
> > >
> > >
> > > Could we simply say:
> > >
> > > We will use the current MPTCP implementation to demonstrate the
> utility of the protocol already used by millions of users on today's
> Internet
> >
> > How about "used by millions of devices"? I think it flows a little bett=
er
> > than "used by ... users".
>
> +1 on the "used by millions of devices".
>

Good point! :)

Matthieu


>
> Christoph
>
> >
> >
> > Thanks,
> >
> > Mat
> >
> > >
> > > or:
> > >
> > > and to show how this implementation - already used by millions of
> users - can currently be extended with Netlink and BPF.
> > >
> > >
> > >                   """
> > >
> > >                   Feel free to edit/merge/expand/discard as needed :)
> > >
> > >
> > >             Thank you for your edit, it is indeed cleaner!
> > >
> > >                                   For more information about this
> project:
> > >
> > >                         https://github.com/multipath-
> tcp/mptcp_net-next/wiki
> > >
> > >
> > >             I guess I can keep this, right?
> > >
> > >
> > >       Yes, that was my intent.
> > >
> > >
> > > Will do!
> > >
> > > Thank you!
> > >
> > > Matthieu
> > >
> > >
> > >
> > >
> > >       Thanks,
> > >
> > >       Mat
> > >
> > >
> > >
> > >                         Please feel free to comment this as well. We
> are still far from the max 350 words limit we found last
> > >             time. But on
> > >                         the other hand, I can no longer find this
> limit on their website :)
> > >
> > >
> > >                   Hope the above is helpful. Thanks again for your
> work on this proposal.
> > >
> > >
> > >             Yes it is, thank you for your help!
> > >
> > >             Matthieu
> > >
> > >
> > >
> > >                   Mat
> > >
> > >
> > >
> > >                         Thank you for your help!
> > >
> > >                         Have a good day/evening,
> > >                         Matthieu
> > >
> > >                         On 25/04/2018 21:58, Mat Martineau wrote:
> > >
> > >                               Hi Matthieu -
> > >
> > >                               On Fri, 20 Apr 2018, Matthieu Baerts
> wrote:
> > >
> > >                                     Hello,
> > >
> > >
> > >                                     NetDev 0x12 is coming to Montr=C3=
=A9al
> this summer: July 11th to 13th, 2018.
> > >
> > >
> > >                                     We already talked about this event
> on this ML and at our weekly meetings but here is a
> > >                                     summary of the discussions we had:
> > >
> > >                                      - we would like to have a
> presentation there mainly to get feedback and advice from other
> > >                                     kernel developers
> > >                                      - a presentation would clearly
> indicate that this MPTCP Upstream project exists and we could
> > >                                     get help from more developers
> > >                                      - we would like to indicate that
> having MPTCP upstream is asked by different companies, some
> > >                                     are even ready to contribute ; it
> is then important to have MPTCP upstream
> > >
> > >
> > >                                     Also note that:
> > >
> > >                                      - David Miller will not be
> present in Montr=C3=A9al [1] but other main contributors should be
> > >                                     there (we don't have a list)
> > >
> > >
> > >                               Side note, in the past day David
> reiterated his statement about not attending or supporting the
> > >                               conference:
> > >
> > >                               https://marc.info/?l=3Dlinux-
> netdev&m=3D152466827203301&w=3D2
> > >
> > >                                      - A presentation by Octavian
> Purdila about "MPTCP Upstreaming" has already been given in
> > >                                     2015 (NetDev 0.1) [2]
> > >                                      - 3 types of presentation are
> available: talks, tutorials and workshops [3]
> > >                                      - Call for Presentation Proposals
> closes on May 1st, 2018.
> > >
> > >
> > >                                     The current idea we briefly
> discussed during our weekly meetings is to give a tutorial:
> > >
> > >                                      - It is not useful to give almost
> the same presentation as the one of Octavian
> > >                                      - It will allow us more
> flexibility somehow to explain what is MPTCP, the different
> > >                                     use-cases, why it is important to
> have it upstream and what problems we are currently facing.
> > >                                      - David Miller and many other
> kernel developers will go to LPC in November: a good place to
> > >                                     give a talk this time.
> > >
> > >
> > >                                     Do you have any ideas on what we
> could show in this tutorial?
> > >
> > >
> > >                                     I recently discussed with my
> colleague Olivier Bonaventure who has a lot of experiences in
> > >                                     giving different introductions and
> more about MPTCP and here is what he suggests:
> > >
> > >                                      - A first part about a basic
> introduction of MPTCP
> > >                                      - Indicate different use-cases --
> if possible with a "closed demo" to be sure it is working
> > >                                     -- asking people to setup
> something is not easy in 1h, max 1h30.
> > >
> > >
> > >                                From the description at [3], either
> "instructor-led" 60-90 minute tutorials or
> > >             "student-participation"
> > >                               2-3 hour sessions are possible. The
> closed demo maps well to their "instructor-led" category.
> > >             Looking at
> > >                               the schedule, the past two Netdev
> Conferences have had one tutorial each, of 60-70 minutes. I think
> > >             it
> > >                               helps to be closer to an hour in length
> to hold the audience's attention.
> > >
> > >                                      - Then trying to have interactive
> discussions or explanations about how MPTCP is currently
> > >                                     implemented or should be
> implemented if it goes upstream, e.g.: for MPTCP, we need to have
> > >                                     extra TCP Options, we need to
> support middleboxes, we need to link subflows of the same
> > >                                     connection together, we need a
> scheduler, a PM, etc.
> > >
> > >
> > >                               It's difficult to predict how
> interactive an audience will be. I've only attended one Netdev
> > >             Conference,
> > >                               and it seemed like there were a lot more
> people with expertise and interest in drivers, lower
> > >             layers
> > >                               (XDP, BPF, TC, netfilter), and network
> topology/simulation. Discussion around middlebox support and
> > >             the
> > >                               userspace API might have more audience
> interaction. If we want to drive a discussion, we could try
> > >             to
> > >                               strike a balance between topics for the
> broader audience and those with more knowledge of TCP
> > >             internals.
> > >                               (Hopefully some TCP internals people are
> still planning to attend)
> > >
> > >                                      - Of course, we should focus our
> discussions on the upstreaming aspect, e.g. reducing the
> > >                                     footprint of MPTCP in the current
> TCP stack: what are we allow to do, what not. It is linked
> > >                                     to many previous discussions we
> had on this ML, e.g. why we need more indirect function calls
> > >                                     and how to reduce the impact, etc.
> > >
> > >
> > >                               The previous talk ([2]) had a section
> like this. I haven't watched it recently, I should look at it
> > >             again
> > >                               to see what kind of questions the
> audience was asking. As you mentioned above we should be careful
> > >             to
> > >                               have new content compared to the
> previous session.
> > >
> > >                                      - If we have time, we could
> discuss about how users could interact with MPTCP: enable it per
> > >                                     connection, control the path
> manager, maybe the scheduler, etc.
> > >
> > >
> > >                                     What do you think about this? Feel
> free to comment and even propose completely different
> > >                                     ideas!
> > >
> > >
> > >                               Thank you for outlining these ideas. I
> see that this topic is on our meeting agenda so it will be
> > >             good to
> > >                               discuss the tutorial there.
> > >
> > >
> > >                                     [1] https://lists.01.org/
> pipermail/mptcp/2018-March/000379.html
> > >                                     [2] https://www.youtube.com/watch?
> v=3Dwftz2cU5SZs
> > >                                     [3] https://www.netdevconf.org/
> 0x12/submit-proposal.html
> > >
> > >
> > >       --
> > >       Mat Martineau
> > >       Intel OTC
> > >
> > >
> > >
> > >
> > > --
> > > Tessares SA
> > > Matthieu Baerts | R&D Engineer
> > > matthieu.baerts(a)tessares.net
> > > Tessares SA | Hybrid Access Solutions
> > > www.tessares.net 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> > >
> > >
> > > ____________________________________________________________
> ____________________________________________________________
> _____________________
> > > DISCLAIMER.
> > > This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they are
> > > addressed. If you have received this email in error please notify the
> system manager. This message contains confidential information and is
> > > intended only for the individual named. If you are not the named
> addressee you should not disseminate, distribute or copy this e-mail. Ple=
ase
> > > notify the sender immediately by e-mail if you have received this
> e-mail by mistake and delete this e-mail from your system. If you are not
> > > the intended recipient you are notified that disclosing, copying,
> distributing or taking any action in reliance on the contents of this
> > > information is strictly prohibited.
> > >
> >
> > --
> > Mat Martineau
> > Intel OTC
>
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

--===============4381564022392928369==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgQXByIDMwLCAyMDE4IGF0IDY6MTIgUE0sIENocmlzdG9w
aCBQYWFzY2ggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBs
ZS5jb20iIHRhcmdldD0iX2JsYW5rIj5jcGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3
cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+SGVs
bG8sPGJyPgo8ZGl2PjxkaXYgY2xhc3M9Img1Ij48YnI+Ck9uIDMwLzA0LzE4IC0gMDk6MDU6NDEs
IE1hdCBNYXJ0aW5lYXUgd3JvdGU6PGJyPgomZ3Q7IDxicj4KJmd0OyBPbiBNb24sIDMwIEFwciAy
MDE4LCBNYXR0aGlldSBCYWVydHMgd3JvdGU6PGJyPgomZ3Q7IDxicj4KJmd0OyAmZ3Q7IEhpIE1h
dCw8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBPbiBNb24sIEFwciAzMCwgMjAxOCBhdCA1
OjM3IFBNLCBNYXQgTWFydGluZWF1ICZsdDs8YSBocmVmPSJtYWlsdG86bWF0aGV3LmoubWFydGlu
ZWF1QGxpbnV4LmludGVsLmNvbSI+bWF0aGV3LmoubWFydGluZWF1QGxpbnV4Ljx3YnI+aW50ZWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oE9uIFN1biwgMjkgQXByIDIwMTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+CiZndDsgJmd0
OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgSGkgTWF0LDxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBUaGFuayB5b3UgZm9yIHlvdXIgcmV2
aWV3IGFuZCBpbnB1dCE8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgT24gU2F0LCBBcHIgMjgsIDIwMTggYXQgMjo0NCBBTSwgTWF0IE1hcnRpbmVhdSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOm1hdGhldy5qLm1hcnRpbmVhdUBsaW51eC5pbnRlbC5jb20iPm1hdGhl
dy5qLm1hcnRpbmVhdUBsaW51eC48d2JyPmludGVsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4KJmd0
OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCBIaSBNYXR0
aGlldSAtPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgIE9uIEZyaSwgMjcgQXByIDIwMTgsIE1hdHRoaWV1IEJhZXJ0cyB3cm90ZTo8YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgSGVsbG8sPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oMKgIMKgIMKgIMKgIMKgIMKgIEZvbGxvd2luZyB5ZXN0ZXJkYXkmIzM5O3MgZGlzY3Vzc2lvbiBh
Ym91dCBOZXREZXYgMHgxMiwgaGVyZSBpcyBhIHByb3Bvc2l0aW9uIG9mIG1haWwgdG8gc2VuZCB0
byBOZXREZXY8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgY29tbWl0dGVlLiBJPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIGFscmVhZHkg
cHV0IHNvbWUgY29tbWVudHMuIE5vdGUgdGhhdCBJIGhhdmUgZm9sbG93ZWQgdGhlIHN1Ym1pc3Np
b24gZ3VpZGVsaW5lcyBmcm9tOjxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy8weDEyL3N1
Ym1pdC1wcm9wb3NhbC5odG1sI3Byb3Bvc2FscyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvPHdicj4weDEyL3N1Ym1pdC1wcm9wb3Nh
bC5odG1sIzx3YnI+cHJvcG9zYWxzPC9hPjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCBQbGVhc2UgY29tbWVudCBpdCBiZWZv
cmUgTW9uZGF5IG1vcm5pbmcuIFNvcnJ5IGZvciB0aGUgcnVzaCBidXQgdGhlIGRlYWRsaW5lIGlz
IHRoZSAxc3Qgb2YgTWF5IDopPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogTmFtZShzKSBvZiB0aGUgc3Vi
bWl0dGVyKHMpOiBDaHJpc3RvcGggUGFhc2NoIChBcHBsZSksIE1hdCBNYXJ0aW5lYXU8YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgKEludGVsKSwgUGV0ZXIgS3J5c3RhZCAoSW50ZWwpLCBPc3NhbWEgT3RobWFuIChJbnRlbCkg
YW5kIG15c2VsZiwgTWF0dGhpZXUgQmFlcnRzIChUZXNzYXJlcyk8YnI+CiZndDsgJmd0OyA8YnI+
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgSSB3cm90ZSBk
b3duIHRoZSBuYW1lcyBvZiBwZW9wbGUgd2hvIHBhcnRpY2lwYXRlZCBpbiB0aGUgZGlzY3Vzc2lv
biBpbiB0aGUgTUwgYW5kIGR1cmluZyB0aGUgd2Vla2x5PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoG1lZXRpbmdzLiBJIGNhbjxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCDCoCDCoCBhZGQgbW9yZSBwZW9wbGUgaWYgbW9yZSBwZW9wbGUgd291bGQg
bGlrZSB0byBqb2luIHRoZSBwcmVwYXJhdGlvbiBhbmQgcHJlc2VudGF0aW9uIG9mIHRoaXMgdHV0
b3JpYWwuPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKg
IEBDaHJpc3RvcGgsIE1hdCwgUGV0ZXIsIE9zc2FtYTogY2FuIEkgd3JpdGUgeW91ciBuYW1lcyB0
aGVyZT88YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgwqAgwqAgwqAgT3NzYW1hIHdvbiYjMzk7dCBiZSBhYmxlIHRvIGF0dGVuZC4g
SXQgbG9va3MgbGlrZSBtb3N0IHNlc3Npb25zIGhhdmUgMSBvciAyIHByZXNlbnRlcnMsIHNvIEkg
ZG9uJiMzOTt0IGtub3cgaWYgNCBpcyB0b288YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgbWFueS4gSSYjMzk7bSBzdXJlPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgIHRoZXkmIzM5O2xsIGdpdmUgdXMgc29tZSBmZWVkYmFjayBpZiB0aGV5IHdhbnQgdG8g
bGltaXQgdGhlIG51bWJlciBvZiBwcmVzZW50ZXJzLjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAm
Z3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBPSyB0aGFuayB5b3UhPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoFllcyBpbmRlZWQsIEkgYW0gc3VyZSB0aGV5IHdp
bGwgc2F5IHNvbWV0aGluZyBpZiB3ZSBhcmUgdG9vIG1hbnkuPGJyPgomZ3Q7ICZndDsgPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICog
VGl0bGUgb2YgdGhlIHN1Ym1pc3Npb246IE1QVENQOiBmcm9tIHRoZSBiYXNpYyB0byBhbiB1cHN0
cmVhbWFibGUgYmFzZTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCBXZSBjZXJ0YWlubHkgbmVlZCBh
IGJldHRlciB0aXRsZSwgcGxlYXNlIGNvbW1lbnQhPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZn
dDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgICZxdW90O011bHRp
cGF0aCBUQ1A6IFByZXNlbnQgVXNlIENhc2VzIGFuZCBhbiBVcHN0cmVhbSBGdXR1cmUmcXVvdDsg
Pzxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqBJIHdhcyB0cnlpbmcgdG8gZmluZCBzb21ldGhpbmcgdGhhdCBjYXRjaCB0aGUgYXR0
ZW50aW9uIGJ1dCBpdCBpcyBtYXliZSBub3QgbmVlZGVkIGZvciB0aGVzZSBraW5kIG9mIHByZXNl
bnRhdGlvbi48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgJmd0OyAqIExhYmVsIChvbmUgb2YgbW9vbnNob3QsIG51dHMmIzM5
O24gYm9sdHMsIGhhbmRzLW9uKTogaGFuZHMtb248YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7aGFuZHMtb24mcXVv
dDsgc2VlbXMgdG8gYmUgdGhlIGNvcnJlY3Qgb25lIGFjY29yZGluZyB0byB0aGUgU3VibWlzc2lv
biBUeXBlcy48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgPGEgaHJlZj0iaHR0cHM6Ly93d3cubmV0ZGV2Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9z
YWwuaHRtbCN0eXBlcyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93
d3cubmV0ZGV2Y29uZi5vcmcvPHdicj4weDEyL3N1Ym1pdC1wcm9wb3NhbC5odG1sIzx3YnI+dHlw
ZXM8L2E+PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgIMKgIMKgIEl0JiMzOTtzIGEgbGl0dGxlIGJpdCBvZiAmcXVvdDtudXRz
ICZhbXA7IGJvbHRzJnF1b3Q7IHRvbywgYnV0IEkgYWdyZWUgdGhhdCBoYW5kcy1vbiBpcyB0aGUg
YmV0dGVyIG1hdGNoLjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqBUaGFuayB5b3UhPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogU3VibWlz
c2lvbiB0eXBlIChvbmUgb2YgdGFsaywgcHJlc2VudGF0aW9uLCB3b3Jrc2hvcCk6IHR1dG9yaWFs
LDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDC
oCDCoCDCoCDCoCBpbnN0cnVjdG9yLWxlZCBzZXNzaW9ucyAobWluaW11bSAxIGhvdXIgbG9uZyBh
bmQgbm90IHRvIGV4Y2VlZCAxLjUgaG91cnMuIFRoZSBpbnN0cnVjdG9yIHdpbGwgZ28gb3ZlciB0
aGU8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdGVjaG5vbG9neTxicj4KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCBlaXRoZXIgdGhyb3VnaCBj
b2RlIHJldmlldyBvciBleGVjdXRpb24gYW5kIGludGVyYWN0IHdpdGggdGhlIGF0dGVuZGVlcy4p
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKg
IMKgIMKgIMKgIEkgZ3Vlc3MgdGhlcmUgaXMgYSB0eXBvIGhlcmU6IHByZXNlbnRhdGlvbiBzaG91
bGQgYmUgcmVwbGFjZWQgYnkgdHV0b3JpYWwgaW4gdGhlIGd1aWRlbGluZXMuPGJyPgomZ3Q7ICZn
dDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIEVzdGltYXRlIG9mIGxlbmd0aCBvZiB0aW1lIGZvciBwcmVzZW50YXRpb246IDFoPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoMKgIMKgIMKgIMKgIMKgIMKgIFRoYXQmIzM5O3Mgd2hhdCB3ZSBhZ3JlZWQgeWVzdGVyZGF5
IGJ1dCBJIGNhbiBjaGFuZ2UuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFmZmlsaWF0aW9ucyBvZiBzdWJt
aXR0ZXJzIChuZWVkZWQgZm9yIGNvbmZsaWN0IG9mIGludGVyZXN0IGNoZWNrKTogQXBwbGUsPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKg
IMKgIMKgIEludGVsLCBUZXNzYXJlczxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEZXNjcmlwdGlvbiBvZiBw
cm9wb3NhbDo8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgQSBwcm9qZWN0IHRvIGFkZCBhbiBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgTXVsdGlQYXRoIFRDUCBwcm90b2NvbCB0byB0aGU8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgTGludXgga2VybmVsIGlz
IGluIHByb2dyZXNzIGJ5IGEgc21hbGwgY29tbXVuaXR5LiBUaGUgZ29hbCBvZiB0aGlzIHR1dG9y
aWFsIGlzIHRvIGRpc2NvdmVyIHdoYXQgaXMgdGhpczxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqBUQ1AgZXh0ZW5zaW9uPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgIMKgIChSRkMgNjgyNCksIHdoYXQgYXJlIHRoZSBkaWZmZXJlbnQgdXNlLWNh
c2VzIGFscmVhZHkgaW4gcHJvZHVjdGlvbiBieSBzb21lIGNvbXBhbmllcyBhbmQgd2hhdCBhcmUg
dGhlPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoGNoYWxsZW5nZXMgdG88YnI+CiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgdXBzdHJlYW0gTVBU
Q1AuIFdlIGhvcGUgaGF2aW5nIGludGVyYWN0aXZlIGRpc2N1c3Npb25zIGFuZCBnZXR0aW5nIGZl
ZWRiYWNrIGZyb20gZXhwZXJpZW5jZWQgZGV2ZWxvcGVyczxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqB3aWxsIGhlbHAgdXM8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgaW4gdGhpcyB0YXNrIG9mIGVhc2lseSBicmluZ2luZyBNUFRDUCB0
byBhbGwgTGludXggdXNlcnMsIGEgdGVjaG5vbG9neSBhbHJlYWR5IHVzZWQgYnkgbWlsbGlvbnMg
b2Y8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgcGVvcGxlLjxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJbiBhIGJpdCBtb3JlIGRldGFpbCwgd2Ugd2lsbCBz
dGFydCB3aXRoIGEgYmFzaWMgaW50cm9kdWN0aW9uIG9mIE1QVENQLjxicj4KJmd0OyAmZ3Q7IDxi
cj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCBBIGZldyB1
c2UtY2FzZXMgd2lsbCBiZSBwcmVzZW50ZWQgd2l0aCBhIGRlbW8gdG8gZXhwbGFpbiBob3cgdXNl
ZnVsIHRoaXMgcHJvdG9jb2wgaXMgaW4gdG9kYXkmIzM5O3MgSW50ZXJuZXQ8YnI+CiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgYW5kIGhvdyBpdDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCBjYW4gYmUgZXh0ZW5kZWQgd2l0aCBBUEkmIzM5O3Mg
bGlrZSBOZXRsaW5rIGFuZCBCUEYuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIEkgcmVjb2duaXplIGhvdyBOZXRs
aW5rIGlzIGFzc29jaWF0ZWQgd2l0aCBhIHVzZXJzcGFjZSBwYXRoIG1hbmFnZXIsIGJ1dCB3aGF0
JiMzOTtzIHRoZSBCUEYgZXh0ZW5zaWJpbGl0eSB5b3UmIzM5O3JlPGJyPgomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoHJlZmVycmluZyB0bz88YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0
OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgSXQgd2FzIG9ubHkgdG8gbWVudGlv
biB0aGF0IGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIGV4dGVuZCBNUFRDUCB3aXRoIGVCUEYuPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEV2ZW4gaWYgaXQgaXMgbm90IGFscmVhZHkg
YXZhaWxhYmxlIGluIHRoZSBjdXJyZW50IE9wZW4tU291cmNlIGltcGxlbWVudGF0aW9uLCB0aGVy
ZSBpcyBhbHJlYWR5IHRoZSBwb3NzaWJpbGl0eSB0bzxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqBnZXQgYSB2ZXJzaW9uIHdpdGggYTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqBwcm9ncmFtbWFibGUgc2NoZWR1bGVyOiA8YSBocmVmPSJodHRwczovL3Byb2dtcC5uZXQi
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcHJvZ21wLm5ldDwvYT48
YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBJZiB3ZSBkb24mIzM5
O3QgaGF2ZSBzb21ldGhpbmcgc3BlY2lmaWMgdG8gb3VyIGVmZm9ydCB3aXRoIEJQRiwgSSYjMzk7
bSBub3Qgc3VyZSBpdCBiZWxvbmdzIGluIHRoZSBzdW1tYXJ5LiBCdXQgSSBkb24mIzM5O3QgaGF2
ZSBhIHN0cm9uZyBvcGluaW9uPGJyPgomZ3Q7ICZndDsgYWJvdXQgaXQuPGJyPgomZ3Q7ICZndDsg
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgV2UgYXJlIHNheWluZyB0aGF0ICZxdW90O3Ro
ZSBbT3Blbi1Tb3VyY2VdIGltcGxlbWVudGF0aW9uIGNhbiBjdXJyZW50bHkgYmUgZXh0ZW5kZWQg
d2l0aCBuZXRsaW5rIGFuZCBCUEYmcXVvdDsuIEl0IGNhbiBjb21lIGxhdGVyIDopPGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKg
IFRoZW4gd2Ugd2lsbCBoYXZlIHNvbWUgZXhwbGFuYXRpb25zIGFib3V0IGhvdyBNUFRDUCBpcyBj
dXJyZW50bHkgaW1wbGVtZW50ZWQuIFRoaXMgY3VycmVudCBpbXBsZW1lbnRhdGlvbjxicj4KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBpcyBxdWl0ZTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCBpbnRydXNpdmUgYW5kIHRoYXQgaXMgY2VydGFp
bmx5IG5vdCBzb21ldGhpbmcgd2Ugd291bGQgbGlrZSB0byBoYXZlIHVwc3RyZWFtLiBXZSB3b3Vs
ZCBsaWtlIHRvIGV4cHJlc3M8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgd2hhdCB3
ZSBoYXZlPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKg
IGluIG1pbmQgdG8gY2hhbmdlIHRoYXQsIHdpdGggc29tZSBzYW1wbGVzIGFuZCBpbml0aWF0ZSBk
aXNjdXNzaW9ucy48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgTXkgZWRpdCBvZiB0aGUgYWJvdmU6PGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgICZxdW90OyZx
dW90OyZxdW90Ozxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCBBIGNvbW11bml0eSBwcm9qZWN0IGlzIHVuZGVyd2F5IHRvIGFkZCBNdWx0aXBh
dGggVENQIHRvIHRoZSB1cHN0cmVhbSBMaW51eCBrZXJuZWwuIFRoaXMgdHV0b3JpYWwgd2lsbCBp
bnRyb2R1Y2U8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdGhlIGF1ZGllbmNlIHRv
PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIHRoaXMgVENQIGV4dGVu
c2lvbiAoUkZDIDY4MjQpLCBzaG93IHNvbWUgdXNlIGNhc2VzIGFscmVhZHkgaW4gcHJvZHVjdGlv
biwgYW5kIGRpc2N1c3MgdGhlIGNoYWxsZW5nZXMgaW48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgY29udmVyZ2luZyBvbiBhbiB1cHN0cmVhbTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqDCoCDCoCDCoCBNUFRDUCBpbXBsZW1lbnRhdGlvbi48YnI+CiZndDsgJmd0OyA8
YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgU2hvdWxkIHdl
IGluc2lzdCBvbiB0aGUgJnF1b3Q7ZGlzY3Vzc2lvbiZxdW90OyBwYXJ0PyBMaWtlIHNheWluZzog
JnF1b3Q7ZGlzY3VzcyB3aXRoIHRoZSBhdWRpZW5jZSZxdW90Oz8gJnF1b3Q7aGF2ZSBpbnRlcmFj
dGl2ZSBkaXNjdXNzaW9ucyZxdW90Oz88YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
SXQgaXMgbWF5YmUgbm90IG5lZWRlZCBidXQgaXQgd2FzIG1haW5seSB0byBleHByZXNzIHRoZSBp
bnRlcmFjdGl2aXR5LCBpdCBpcyBhIHR1dG9yaWFsLCBub3QganVzdCBhICZxdW90O3NpbXBsZSZx
dW90Ozxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBwcmVzZW50YXRpb24uPGJyPgom
Z3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoEkgdGhpbmsg
aXQmIzM5O3Mgb2sgdG8gbWVudGlvbiB0aGF0IC0gd2hpbGUgSSBsZWZ0IHRoZSB3b3JkICZxdW90
O2Rpc2N1c3MmcXVvdDsgaW4gdGhlcmUgZm9yIHRoYXQgcmVhc29uLCBtYXliZSB0aGF0JiMzOTtz
IG5vdCBvYnZpb3VzIG9yIGNsZWFyPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoGVub3VnaC48YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBJdCB3YXMgbWF5YmUgbWUs
IG1heWJlIG5vIG5lZWQgdG8gaW5zaXN0IDotKTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCBXZSB3aWxsIHVzZSB0aGUgY3VycmVudCBNUFRD
UCBpbXBsZW1lbnRhdGlvbiB0byBkZW1vbnN0cmF0ZSB0aGUgdXRpbGl0eSBvZiB0aGUgcHJvdG9j
b2wgb24gdG9kYXkmIzM5O3MgaW50ZXJuZXQsPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoGFuZCB0byBzaG93IGhvdyB0aGlzPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oMKgIMKgIMKgIGltcGxlbWVudGF0aW9uIGNhbiBjdXJyZW50bHkgYmUgZXh0ZW5kZWQgd2l0aCBu
ZXRsaW5rIGFuZCBCUEYuIFRoaXMgbm90IG9ubHkgaGFzIHByYWN0aWNhbCBhcHBsaWNhdGlvbiBm
b3I8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgZGVwbG95aW5nIE1QVENQIG5vdyw8
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgYnV0IGFsc28gaWxsdXN0
cmF0ZXMgaG93IHRoZSBBUElzIGFuZCBjb2RlIHdpbGwgbmVlZCB0byBldm9sdmUgaW4gb3JkZXIg
dG8gcHJvcGVybHkgY29leGlzdCB3aXRoIHRoZSBvcHRpbWl6ZWQ8YnI+CiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgTGludXggVENQIGNvcmUgd2U8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgwqAgwqAgwqAgYWxsIHJlbHkgb24uIFdlIHdpbGwgZGlzY3VzcyBvdXIgaWRlYXMg
Zm9yIGJyaW5naW5nIE1QVENQIHRvIHRoZSB1cHN0cmVhbSBrZXJuZWwgc28gdGhlIHRlY2hub2xv
Z3kgaXMgYXZhaWxhYmxlPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoHRvIGFsbCBM
aW51eDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCB1c2Vycy48YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgVG8gJnF1b3Q7YXR0cmFjdCZxdW90OyBwZW9wbGUsIHNob3VsZCB3ZSBtZW50aW9uIHRoYXQg
dGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXMgYWxyZWFkeSB1c2VkIGJ5IG1pbGxpb25zIG9m
IHVzZXJzPzxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBJIGxpa2UgaG93IHlvdXIg
aW1wcm92ZSB0aGUgbGFzdCBiaXQgOi0pPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoFN1cmUuIEkgbGlrZWQgdGhhdCBpbiB5b3VyIHRleHQsIGJ1
dCByYW4gb3V0IG9mIHRpbWUgZmlndXJpbmcgb3V0IGhvdyB0byBmaXQgaXQgaW4gdG8gdGhlIGxh
c3Qgc2VudGVuY2UgOik8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0
OyBDb3VsZCB3ZSBzaW1wbHkgc2F5Ojxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IFdlIHdp
bGwgdXNlIHRoZSBjdXJyZW50IE1QVENQIGltcGxlbWVudGF0aW9uIHRvIGRlbW9uc3RyYXRlIHRo
ZSB1dGlsaXR5IG9mIHRoZSBwcm90b2NvbCBhbHJlYWR5IHVzZWQgYnkgbWlsbGlvbnMgb2YgdXNl
cnMgb24gdG9kYXkmIzM5O3MgSW50ZXJuZXQ8YnI+CiZndDsgPGJyPgomZ3Q7IEhvdyBhYm91dCAm
cXVvdDt1c2VkIGJ5IG1pbGxpb25zIG9mIGRldmljZXMmcXVvdDs/IEkgdGhpbmsgaXQgZmxvd3Mg
YSBsaXR0bGUgYmV0dGVyPGJyPgomZ3Q7IHRoYW4gJnF1b3Q7dXNlZCBieSAuLi4gdXNlcnMmcXVv
dDsuPGJyPgo8YnI+CjwvZGl2PjwvZGl2PisxIG9uIHRoZSAmcXVvdDt1c2VkIGJ5IG1pbGxpb25z
IG9mIGRldmljZXMmcXVvdDsuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pkdv
b2QgcG9pbnQhIDopPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5NYXR0aGlldTwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
IDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPgo8
c3BhbiBjbGFzcz0iSE9FblpiIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+PGJyPgo8YnI+CkNocmlz
dG9waDxicj4KPC9mb250Pjwvc3Bhbj48ZGl2IGNsYXNzPSJIT0VuWmIiPjxkaXYgY2xhc3M9Img1
Ij48YnI+CiZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGFua3MsPGJyPgomZ3Q7IDxicj4KJmd0
OyBNYXQ8YnI+CiZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgb3I6PGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7ICZndDsgYW5kIHRvIHNob3cgaG93IHRoaXMgaW1wbGVtZW50YXRpb24g
LSBhbHJlYWR5IHVzZWQgYnkgbWlsbGlvbnMgb2YgdXNlcnMgLSBjYW4gY3VycmVudGx5IGJlIGV4
dGVuZGVkIHdpdGggTmV0bGluayBhbmQgQlBGLjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCAmcXVvdDsmcXVvdDsm
cXVvdDs8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAg
wqAgwqAgRmVlbCBmcmVlIHRvIGVkaXQvbWVyZ2UvZXhwYW5kL2Rpc2NhcmQgYXMgbmVlZGVkIDop
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoFRoYW5rIHlvdSBmb3IgeW91ciBlZGl0LCBpdCBpcyBpbmRlZWQgY2xlYW5lciE8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgRm9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhpcyBwcm9q
ZWN0Ojxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbXVsdGlwYXRoLXRjcC9t
cHRjcF9uZXQtbmV4dC93aWtpIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRw
czovL2dpdGh1Yi5jb20vbXVsdGlwYXRoLTx3YnI+dGNwL21wdGNwX25ldC1uZXh0L3dpa2k8L2E+
PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoEkgZ3Vlc3MgSSBjYW4ga2VlcCB0aGlzLCByaWdodD88YnI+CiZndDsgJmd0OyA8YnI+
CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgWWVzLCB0aGF0IHdhcyBteSBpbnRl
bnQuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgV2lsbCBkbyE8
YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyBUaGFuayB5b3UhPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDsgTWF0dGhpZXU8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgVGhhbmtzLDxi
cj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqBNYXQ8YnI+CiZndDsgJmd0OyA8
YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgUGxlYXNlIGZlZWwgZnJlZSB0byBjb21tZW50IHRoaXMg
YXMgd2VsbC4gV2UgYXJlIHN0aWxsIGZhciBmcm9tIHRoZSBtYXggMzUwIHdvcmRzIGxpbWl0IHdl
IGZvdW5kIGxhc3Q8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdGltZS4gQnV0IG9u
PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIHRoZSBv
dGhlciBoYW5kLCBJIGNhbiBubyBsb25nZXIgZmluZCB0aGlzIGxpbWl0IG9uIHRoZWlyIHdlYnNp
dGUgOik8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgwqAgwqAgwqAgSG9wZSB0aGUgYWJvdmUgaXMgaGVscGZ1bC4gVGhhbmtzIGFn
YWluIGZvciB5b3VyIHdvcmsgb24gdGhpcyBwcm9wb3NhbC48YnI+CiZndDsgJmd0OyA8YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgWWVzIGl0IGlzLCB0aGFu
ayB5b3UgZm9yIHlvdXIgaGVscCE8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgTWF0dGhpZXU8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgTWF0PGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIFRoYW5rIHlvdSBmb3IgeW91ciBo
ZWxwITxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCDCoCDCoCBIYXZlIGEgZ29vZCBkYXkvZXZlbmluZyw8YnI+CiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgTWF0dGhpZXU8YnI+CiZndDsgJmd0OyA8
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgT24gMjUv
MDQvMjAxOCAyMTo1OCwgTWF0IE1hcnRpbmVhdSB3cm90ZTo8YnI+CiZndDsgJmd0OyA8YnI+CiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSGkg
TWF0dGhpZXUgLTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBPbiBGcmksIDIwIEFwciAyMDE4LCBNYXR0aGll
dSBCYWVydHMgd3JvdGU6PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEhlbGxvLDxicj4KJmd0
OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBOZXREZXYgMHgxMiBpcyBjb21pbmcg
dG8gTW9udHLDqWFsIHRoaXMgc3VtbWVyOiBKdWx5IDExdGggdG8gMTN0aCwgMjAxOC48YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgV2UgYWxyZWFkeSB0YWxrZWQgYWJv
dXQgdGhpcyBldmVudCBvbiB0aGlzIE1MIGFuZCBhdCBvdXIgd2Vla2x5IG1lZXRpbmdzIGJ1dCBo
ZXJlIGlzIGE8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3VtbWFyeSBvZiB0aGUgZGlzY3Vzc2lvbnMgd2UgaGFkOjxi
cj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gd2Ugd291bGQgbGlrZSB0byBoYXZlIGEgcHJl
c2VudGF0aW9uIHRoZXJlIG1haW5seSB0byBnZXQgZmVlZGJhY2sgYW5kIGFkdmljZSBmcm9tIG90
aGVyPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGtlcm5lbCBkZXZlbG9wZXJzPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBhIHByZXNl
bnRhdGlvbiB3b3VsZCBjbGVhcmx5IGluZGljYXRlIHRoYXQgdGhpcyBNUFRDUCBVcHN0cmVhbSBw
cm9qZWN0IGV4aXN0cyBhbmQgd2UgY291bGQ8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ2V0IGhlbHAgZnJvbSBtb3Jl
IGRldmVsb3BlcnM8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtIHdlIHdvdWxkIGxpa2UgdG8gaW5kaWNhdGUgdGhh
dCBoYXZpbmcgTVBUQ1AgdXBzdHJlYW0gaXMgYXNrZWQgYnkgZGlmZmVyZW50IGNvbXBhbmllcywg
c29tZTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBhcmUgZXZlbiByZWFkeSB0byBjb250cmlidXRlIDsgaXQgaXMgdGhl
biBpbXBvcnRhbnQgdG8gaGF2ZSBNUFRDUCB1cHN0cmVhbTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0
OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBBbHNvIG5vdGUgdGhhdDo8YnI+CiZndDsgJmd0OyA8YnI+CiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAtIERhdmlkIE1pbGxlciB3aWxsIG5vdCBiZSBwcmVzZW50IGluIE1vbnRyw6lhbCBb
MV0gYnV0IG90aGVyIG1haW4gY29udHJpYnV0b3JzIHNob3VsZCBiZTxicj4KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aGVy
ZSAod2UgZG9uJiMzOTt0IGhhdmUgYSBsaXN0KTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7
IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBTaWRlIG5vdGUsIGluIHRoZSBwYXN0IGRheSBEYXZpZCByZWl0ZXJhdGVkIGhpcyBzdGF0
ZW1lbnQgYWJvdXQgbm90IGF0dGVuZGluZyBvciBzdXBwb3J0aW5nIHRoZTxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25mZXJlbmNl
Ojxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA8YSBocmVmPSJodHRwczovL21hcmMuaW5mby8/bD1saW51eC1u
ZXRkZXYmYW1wO209MTUyNDY2ODI3MjAzMzAxJmFtcDt3PTIiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LTx3YnI+bmV0ZGV2JmFtcDtt
PTE1MjQ2NjgyNzIwMzMwMSZhbXA7dz0yPC9hPjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oC0gQSBwcmVzZW50YXRpb24gYnkgT2N0YXZpYW4gUHVyZGlsYSBhYm91dCAmcXVvdDtNUFRDUCBV
cHN0cmVhbWluZyZxdW90OyBoYXMgYWxyZWFkeSBiZWVuIGdpdmVuIGluPGJyPgomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDIw
MTUgKE5ldERldiAwLjEpIFsyXTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gMyB0eXBlcyBvZiBwcmVzZW50YXRp
b24gYXJlIGF2YWlsYWJsZTogdGFsa3MsIHR1dG9yaWFscyBhbmQgd29ya3Nob3BzIFszXTxicj4K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoC0gQ2FsbCBmb3IgUHJlc2VudGF0aW9uIFByb3Bvc2FscyBjbG9zZXMgb24gTWF5
IDFzdCwgMjAxOC48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVGhl
IGN1cnJlbnQgaWRlYSB3ZSBicmllZmx5IGRpc2N1c3NlZCBkdXJpbmcgb3VyIHdlZWtseSBtZWV0
aW5ncyBpcyB0byBnaXZlIGEgdHV0b3JpYWw6PGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LSBJdCBpcyBub3QgdXNlZnVsIHRvIGdpdmUgYWxtb3N0IHRoZSBzYW1lIHByZXNlbnRhdGlvbiBh
cyB0aGUgb25lIG9mIE9jdGF2aWFuPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBJdCB3aWxsIGFsbG93IHVzIG1v
cmUgZmxleGliaWxpdHkgc29tZWhvdyB0byBleHBsYWluIHdoYXQgaXMgTVBUQ1AsIHRoZSBkaWZm
ZXJlbnQ8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgdXNlLWNhc2VzLCB3aHkgaXQgaXMgaW1wb3J0YW50IHRvIGhhdmUg
aXQgdXBzdHJlYW0gYW5kIHdoYXQgcHJvYmxlbXMgd2UgYXJlIGN1cnJlbnRseSBmYWNpbmcuPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLSBEYXZpZCBNaWxsZXIgYW5kIG1hbnkgb3RoZXIga2VybmVsIGRldmVsb3Bl
cnMgd2lsbCBnbyB0byBMUEMgaW4gTm92ZW1iZXI6IGEgZ29vZCBwbGFjZSB0bzxicj4KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBnaXZlIGEgdGFsayB0aGlzIHRpbWUuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIERvIHlvdSBoYXZlIGFueSBpZGVhcyBvbiB3aGF0IHdlIGNvdWxkIHNob3cgaW4g
dGhpcyB0dXRvcmlhbD88YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
SSByZWNlbnRseSBkaXNjdXNzZWQgd2l0aCBteSBjb2xsZWFndWUgT2xpdmllciBCb25hdmVudHVy
ZSB3aG8gaGFzIGEgbG90IG9mIGV4cGVyaWVuY2VzIGluPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdpdmluZyBkaWZm
ZXJlbnQgaW50cm9kdWN0aW9ucyBhbmQgbW9yZSBhYm91dCBNUFRDUCBhbmQgaGVyZSBpcyB3aGF0
IGhlIHN1Z2dlc3RzOjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0gQSBmaXJzdCBwYXJ0
IGFib3V0IGEgYmFzaWMgaW50cm9kdWN0aW9uIG9mIE1QVENQPGJyPgomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBJbmRp
Y2F0ZSBkaWZmZXJlbnQgdXNlLWNhc2VzIC0tIGlmIHBvc3NpYmxlIHdpdGggYSAmcXVvdDtjbG9z
ZWQgZGVtbyZxdW90OyB0byBiZSBzdXJlIGl0IGlzIHdvcmtpbmc8YnI+CiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLS0gYXNr
aW5nIHBlb3BsZSB0byBzZXR1cCBzb21ldGhpbmcgaXMgbm90IGVhc3kgaW4gMWgsIG1heCAxaDMw
Ljxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEZyb20gdGhlIGRlc2NyaXB0aW9u
IGF0IFszXSwgZWl0aGVyICZxdW90O2luc3RydWN0b3ItbGVkJnF1b3Q7IDYwLTkwIG1pbnV0ZSB0
dXRvcmlhbHMgb3I8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7c3R1ZGVu
dC1wYXJ0aWNpcGF0aW9uJnF1b3Q7PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDItMyBob3VyIHNlc3Npb25zIGFyZSBwb3NzaWJsZS4g
VGhlIGNsb3NlZCBkZW1vIG1hcHMgd2VsbCB0byB0aGVpciAmcXVvdDtpbnN0cnVjdG9yLWxlZCZx
dW90OyBjYXRlZ29yeS48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgTG9va2luZyBh
dDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB0aGUgc2NoZWR1bGUsIHRoZSBwYXN0IHR3byBOZXRkZXYgQ29uZmVyZW5jZXMgaGF2ZSBo
YWQgb25lIHR1dG9yaWFsIGVhY2gsIG9mIDYwLTcwIG1pbnV0ZXMuIEkgdGhpbms8YnI+CiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgaXQ8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGVscHMgdG8gYmUgY2xvc2VyIHRvIGFuIGhv
dXIgaW4gbGVuZ3RoIHRvIGhvbGQgdGhlIGF1ZGllbmNlJiMzOTtzIGF0dGVudGlvbi48YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtIFRoZW4gdHJ5aW5nIHRvIGhhdmUgaW50ZXJhY3RpdmUg
ZGlzY3Vzc2lvbnMgb3IgZXhwbGFuYXRpb25zIGFib3V0IGhvdyBNUFRDUCBpcyBjdXJyZW50bHk8
YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaW1wbGVtZW50ZWQgb3Igc2hvdWxkIGJlIGltcGxlbWVudGVkIGlmIGl0IGdv
ZXMgdXBzdHJlYW0sIGUuZy46IGZvciBNUFRDUCwgd2UgbmVlZCB0byBoYXZlPGJyPgomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGV4dHJhIFRDUCBPcHRpb25zLCB3ZSBuZWVkIHRvIHN1cHBvcnQgbWlkZGxlYm94ZXMsIHdlIG5l
ZWQgdG8gbGluayBzdWJmbG93cyBvZiB0aGUgc2FtZTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25uZWN0aW9uIHRv
Z2V0aGVyLCB3ZSBuZWVkIGEgc2NoZWR1bGVyLCBhIFBNLCBldGMuPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIEl0JiMzOTtzIGRpZmZpY3VsdCB0byBwcmVkaWN0IGhvdyBpbnRlcmFj
dGl2ZSBhbiBhdWRpZW5jZSB3aWxsIGJlLiBJJiMzOTt2ZSBvbmx5IGF0dGVuZGVkIG9uZSBOZXRk
ZXY8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgQ29uZmVyZW5jZSw8YnI+CiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYW5kIGl0
IHNlZW1lZCBsaWtlIHRoZXJlIHdlcmUgYSBsb3QgbW9yZSBwZW9wbGUgd2l0aCBleHBlcnRpc2Ug
YW5kIGludGVyZXN0IGluIGRyaXZlcnMsIGxvd2VyPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoGxheWVyczxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAoWERQLCBCUEYsIFRDLCBuZXRmaWx0ZXIpLCBhbmQgbmV0d29yayB0
b3BvbG9neS9zaW11bGF0aW9uLiBEaXNjdXNzaW9uIGFyb3VuZCBtaWRkbGVib3ggc3VwcG9ydCBh
bmQ8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdGhlPGJyPgomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVzZXJzcGFjZSBBUEkg
bWlnaHQgaGF2ZSBtb3JlIGF1ZGllbmNlIGludGVyYWN0aW9uLiBJZiB3ZSB3YW50IHRvIGRyaXZl
IGEgZGlzY3Vzc2lvbiwgd2UgY291bGQgdHJ5PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoHRvPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN0cmlrZSBhIGJhbGFuY2UgYmV0d2VlbiB0b3BpY3MgZm9yIHRoZSBicm9hZGVy
IGF1ZGllbmNlIGFuZCB0aG9zZSB3aXRoIG1vcmUga25vd2xlZGdlIG9mIFRDUDxicj4KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBpbnRlcm5hbHMuPGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIChIb3BlZnVsbHkgc29tZSBUQ1Ag
aW50ZXJuYWxzIHBlb3BsZSBhcmUgc3RpbGwgcGxhbm5pbmcgdG8gYXR0ZW5kKTxicj4KJmd0OyAm
Z3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC0gT2YgY291cnNlLCB3ZSBzaG91bGQgZm9jdXMgb3VyIGRpc2N1
c3Npb25zIG9uIHRoZSB1cHN0cmVhbWluZyBhc3BlY3QsIGUuZy4gcmVkdWNpbmcgdGhlPGJyPgom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZvb3RwcmludCBvZiBNUFRDUCBpbiB0aGUgY3VycmVudCBUQ1Agc3RhY2s6IHdoYXQg
YXJlIHdlIGFsbG93IHRvIGRvLCB3aGF0IG5vdC4gSXQgaXMgbGlua2VkPGJyPgomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRv
IG1hbnkgcHJldmlvdXMgZGlzY3Vzc2lvbnMgd2UgaGFkIG9uIHRoaXMgTUwsIGUuZy4gd2h5IHdl
IG5lZWQgbW9yZSBpbmRpcmVjdCBmdW5jdGlvbiBjYWxsczxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhbmQgaG93IHRv
IHJlZHVjZSB0aGUgaW1wYWN0LCBldGMuPGJyPgomZ3Q7ICZndDsgPGJyPgomZ3Q7ICZndDsgPGJy
PgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFRoZSBwcmV2aW91cyB0YWxrIChbMl0pIGhhZCBhIHNlY3Rpb24gbGlrZSB0aGlzLiBJIGhhdmVu
JiMzOTt0IHdhdGNoZWQgaXQgcmVjZW50bHksIEkgc2hvdWxkIGxvb2sgYXQgaXQ8YnI+CiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgYWdhaW48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdG8gc2VlIHdoYXQga2luZCBvZiBxdWVz
dGlvbnMgdGhlIGF1ZGllbmNlIHdhcyBhc2tpbmcuIEFzIHlvdSBtZW50aW9uZWQgYWJvdmUgd2Ug
c2hvdWxkIGJlIGNhcmVmdWw8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgdG88YnI+
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aGF2ZSBuZXcgY29udGVudCBjb21wYXJlZCB0byB0aGUgcHJldmlvdXMgc2Vzc2lvbi48YnI+CiZn
dDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtIElmIHdlIGhhdmUgdGltZSwgd2UgY291bGQgZGlzY3Vz
cyBhYm91dCBob3cgdXNlcnMgY291bGQgaW50ZXJhY3Qgd2l0aCBNUFRDUDogZW5hYmxlIGl0IHBl
cjxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBjb25uZWN0aW9uLCBjb250cm9sIHRoZSBwYXRoIG1hbmFnZXIsIG1heWJl
IHRoZSBzY2hlZHVsZXIsIGV0Yy48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcz8gRmVlbCBmcmVlIHRvIGNvbW1lbnQg
YW5kIGV2ZW4gcHJvcG9zZSBjb21wbGV0ZWx5IGRpZmZlcmVudDxicj4KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZGVhcyE8
YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgVGhhbmsgeW91IGZvciBvdXRsaW5pbmcg
dGhlc2UgaWRlYXMuIEkgc2VlIHRoYXQgdGhpcyB0b3BpYyBpcyBvbiBvdXIgbWVldGluZyBhZ2Vu
ZGEgc28gaXQgd2lsbCBiZTxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBnb29kIHRv
PGJyPgomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGRpc2N1c3MgdGhlIHR1dG9yaWFsIHRoZXJlLjxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAm
Z3Q7IDxicj4KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBbMV0gPGEgaHJlZj0iaHR0cHM6Ly9saXN0cy4wMS5vcmcvcGlwZXJt
YWlsL21wdGNwLzIwMTgtTWFyY2gvMDAwMzc5Lmh0bWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vbGlzdHMuMDEub3JnLzx3YnI+cGlwZXJtYWlsL21wdGNwLzIwMTgt
TWFyY2gvPHdicj4wMDAzNzkuaHRtbDwvYT48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgWzJdIDxhIGhyZWY9Imh0dHBz
Oi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9d2Z0ejJjVTVTWnMiIHJlbD0ibm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoPzx3YnI+dj13ZnR6
MmNVNVNaczwvYT48YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgWzNdIDxhIGhyZWY9Imh0dHBzOi8vd3d3Lm5ldGRldmNv
bmYub3JnLzB4MTIvc3VibWl0LXByb3Bvc2FsLmh0bWwiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiPmh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzx3YnI+MHgxMi9zdWJtaXQtcHJv
cG9zYWwuaHRtbDwvYT48YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0
O8KgIMKgIMKgIMKgLS08YnI+CiZndDsgJmd0O8KgIMKgIMKgIMKgTWF0IE1hcnRpbmVhdTxicj4K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqBJbnRlbCBPVEM8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0
OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyA8YnI+CiZndDsgJmd0OyAtLTxicj4KJmd0
OyAmZ3Q7IFRlc3NhcmVzIFNBPGJyPgomZ3Q7ICZndDsgTWF0dGhpZXUgQmFlcnRzIHwgUiZhbXA7
RCBFbmdpbmVlcjxicj4KJmd0OyAmZ3Q7IDxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHNA
dGVzc2FyZXMubmV0Ij5tYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PC9hPjxicj4KJmd0OyAm
Z3Q7IFRlc3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+CiZndDsgJmd0OyA8
YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+d3d3LnRlc3NhcmVzLm5ldDwvYT4gMSBBdmVudWUgSmVhbiBNb25uZXQsIDEzNDgg
TG91dmFpbi1sYS1OZXV2ZSwgQmVsZ2l1bTxicj4KJmd0OyAmZ3Q7IDxicj4KJmd0OyAmZ3Q7IDxi
cj4KJmd0OyAmZ3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzx3YnI+X19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fPHdicj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188
d2JyPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzx3YnI+X19fX19fX19fX19fX19fX19f
X19fPGJyPgomZ3Q7ICZndDsgRElTQ0xBSU1FUi48YnI+CiZndDsgJmd0OyBUaGlzIGVtYWlsIGFu
ZCBhbnkgZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBhcmUgY29uZmlkZW50aWFsIGFuZCBpbnRl
bmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRvIHdo
b20gdGhleSBhcmU8YnI+CiZndDsgJmd0OyBhZGRyZXNzZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVk
IHRoaXMgZW1haWwgaW4gZXJyb3IgcGxlYXNlIG5vdGlmeSB0aGUgc3lzdGVtIG1hbmFnZXIuIFRo
aXMgbWVzc2FnZSBjb250YWlucyBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gYW5kIGlzPGJyPgom
Z3Q7ICZndDsgaW50ZW5kZWQgb25seSBmb3IgdGhlIGluZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgeW91IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRp
c3RyaWJ1dGUgb3IgY29weSB0aGlzIGUtbWFpbC4gUGxlYXNlPGJyPgomZ3Q7ICZndDsgbm90aWZ5
IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgZS1tYWlsIGlmIHlvdSBoYXZlIHJlY2VpdmVkIHRo
aXMgZS1tYWlsIGJ5IG1pc3Rha2UgYW5kIGRlbGV0ZSB0aGlzIGUtbWFpbCBmcm9tIHlvdXIgc3lz
dGVtLiBJZiB5b3UgYXJlIG5vdDxicj4KJmd0OyAmZ3Q7IHRoZSBpbnRlbmRlZCByZWNpcGllbnQg
eW91IGFyZSBub3RpZmllZCB0aGF0IGRpc2Nsb3NpbmcsIGNvcHlpbmcsIGRpc3RyaWJ1dGluZyBv
ciB0YWtpbmcgYW55IGFjdGlvbiBpbiByZWxpYW5jZSBvbiB0aGUgY29udGVudHMgb2YgdGhpczxi
cj4KJmd0OyAmZ3Q7IGluZm9ybWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPGJyPgomZ3Q7
ICZndDsgPGJyPgomZ3Q7IDxicj4KJmd0OyAtLTxicj4KJmd0OyBNYXQgTWFydGluZWF1PGJyPgom
Z3Q7IEludGVsIE9UQzxicj4KPGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJy
PjxiciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIg
ZGF0YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2
IGRpcj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBzdHlsZT0iZm9udC1mYW1pbHk6
JnF1b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFjaW5nOm5vcm1hbDt0ZXh0LWlu
ZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNpbmc6MHB4IiB3aWR0aD0iMTAw
JSIgYm9yZGVyPSIwIj48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIzIiBzdHlsZT0icGFkZGluZy1s
ZWZ0OjVweDtwYWRkaW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2YWxpZ249InRvcCIgYWxpZ249
ImxlZnQiPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+
PGltZyBzcmM9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xvZ28ucG5nIiBhbHQ9IlRlc3Nh
cmVzIFNBIiB3aWR0aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0iMCI+PC9hPjwvdGQ+PHRkIHN0
eWxlPSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtm
b250LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250
LXdlaWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5NYXR0aGll
dSBCYWVydHMgfCBSJmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxl
PSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250
LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Im1haWx0bzptYXR0
aGlldS5iYWVydHMlNDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO3RleHQt
ZGVjb3JhdGlvbjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUu
YmFlcnRzQHRlc3NhcmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRp
bmc6MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZTox
MHB4IiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQ7Y29sb3I6cmdi
KDM3LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBT
b2x1dGlvbnM8YnI+PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiBzdHls
ZT0iY29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIg
dGFyZ2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNwYW4+wqA8L3NwYW4+PGJyPjxh
IGhyZWY9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTErQXZlbnVlK0plYW4rTW9ubmV0
LCsxMzQ4K090dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxnaXVtIiBzdHlsZT0iY29sb3I6
cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJf
YmxhbmsiPjEgQXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEtTmV1dmUsIEJlbGdp
dW08L2E+PC90ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48
L2Rpdj48L2Rpdj4KPC9kaXY+PC9kaXY+Cgo8YnI+CjxkaXY+PGJyPjxocj48L2Rpdj48Zm9udCBz
aXplPSIxIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tn
cm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+RElTQ0xBSU1FUi48L3NwYW4+PGJyIHN0eWxl
PSJmb250LWZhbWlseTpWZXJkYW5hLHNhbnMtc2VyaWY7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1
LDI1NSwyNTUpIj48Zm9udCBjb2xvcj0iIzAwMDAwMCIgZmFjZT0iVmVyZGFuYSwgc2Fucy1zZXJp
ZiIgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+VGhpcyBlbWFpbCBh
bmQgYW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50
ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3
aG9tIHRoZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBp
biBlcnJvciBwbGVhc2Ugbm90aWZ5IHRoZSBzeXN0ZW0gbWFuYWdlci4gVGhpcyBtZXNzYWdlIGNv
bnRhaW5zIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgb25seSBmb3Ig
dGhlIGluZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUg
eW91IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUgb3IgY29weSB0aGlzIGUtbWFp
bC4gUGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGUtbWFpbCBpZiB5b3Ug
aGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieSBtaXN0YWtlIGFuZCBkZWxldGUgdGhpcyBlLW1h
aWwgZnJvbSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCB5b3UgYXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29weWluZywgZGlzdHJpYnV0aW5n
IG9yIHRha2luZyBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlz
IGluZm9ybWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPC9mb250PjwvZm9udD4=
--===============4381564022392928369==--
