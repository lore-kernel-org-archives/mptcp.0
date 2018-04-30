Content-Type: multipart/mixed; boundary="===============2609213453653917614=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Call for ideas for a presentation about MPTCP Upstream
 project at NetDev 0x12 in July
Date: Mon, 30 Apr 2018 19:34:10 +0200
Message-ID: <CAKuKrBnWVy5+g9wszeDxrxbT=Ea3c0a+QTKrJP6Lt5SyaxgcUw@mail.gmail.com>
In-Reply-To: 20180430161842.GM19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 573

--===============2609213453653917614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 6:18 PM, Christoph Paasch <cpaasch(a)apple.com> wro=
te:

> On 30/04/18 - 16:26:01, Matthieu Baerts wrote:
> > Hi Mat, Christoph, Peter, Ossama,
> >
> > I will wait for ~10am your time before sending it to let you some times
> to
> > comment this if you want to do so.
> >
> > Best regards,
> > Matthieu
> >
> > On Sun, Apr 29, 2018 at 4:08 PM, Matthieu Baerts <
> > matthieu.baerts(a)tessares.net> wrote:
> >
> > > Hi Mat,
> > >
> > > Thank you for your review and input!
> > >
> > > On Sat, Apr 28, 2018 at 2:44 AM, Mat Martineau
> <mathew.j.martineau(a)linux.
> > > intel.com> wrote:
> > >
> > >>
> > >> Hi Matthieu -
> > >>
> > >> On Fri, 27 Apr 2018, Matthieu Baerts wrote:
> > >>
> > >> Hello,
> > >>>
> > >>> Following yesterday's discussion about NetDev 0x12, here is a
> > >>> proposition of mail to send to NetDev committee. I already put some
> > >>> comments. Note that I have followed the submission guidelines from:
> > >>> https://www.netdevconf.org/0x12/submit-proposal.html#proposals
> > >>>
> > >>> Please comment it before Monday morning. Sorry for the rush but the
> > >>> deadline is the 1st of May :)
> > >>>
> > >>> * Name(s) of the submitter(s): Christoph Paasch (Apple), Mat
> Martineau
> > >>>>
> > >>> (Intel), Peter Krystad (Intel), Ossama Othman (Intel) and myself,
> > >>> Matthieu Baerts (Tessares)
> > >>>
> > >>> I wrote down the names of people who participated in the discussion
> in
> > >>> the ML and during the weekly meetings. I can add more people if more
> people
> > >>> would like to join the preparation and presentation of this tutoria=
l.
> > >>> @Christoph, Mat, Peter, Ossama: can I write your names there?
> > >>>
> > >>
> > >> Ossama won't be able to attend. It looks like most sessions have 1 or
> 2
> > >> presenters, so I don't know if 4 is too many. I'm sure they'll give
> us some
> > >> feedback if they want to limit the number of presenters.
> > >>
> > >
> > > OK thank you!
> > > Yes indeed, I am sure they will say something if we are too many.
> > >
> > > * Title of the submission: MPTCP: from the basic to an upstreamable
> base
> > >>>>
> > >>>
> > >>> We certainly need a better title, please comment!
> > >>>
> > >>
> > >> "Multipath TCP: Present Use Cases and an Upstream Future" ?
> > >>
> > >
> > > I was trying to find something that catch the attention but it is may=
be
> > > not needed for these kind of presentation.
> > >
> > > > * Label (one of moonshot, nuts'n bolts, hands-on): hands-on
> > >>>
> > >>> "hands-on" seems to be the correct one according to the Submission
> Types.
> > >>> https://www.netdevconf.org/0x12/submit-proposal.html#types
> > >>>
> > >>
> > >> It's a little bit of "nuts & bolts" too, but I agree that hands-on is
> the
> > >> better match.
> > >>
> > >
> > > Thank you!
> > >
> > > * Submission type (one of talk, presentation, workshop): tutorial,
> > >>>>
> > >>> instructor-led sessions (minimum 1 hour long and not to exceed 1.5
> > >>> hours. The instructor will go over the technology either through co=
de
> > >>> review or execution and interact with the attendees.)
> > >>>
> > >>> I guess there is a typo here: presentation should be replaced by
> > >>> tutorial in the guidelines.
> > >>>
> > >>> Estimate of length of time for presentation: 1h
> > >>>>
> > >>>
> > >>> That's what we agreed yesterday but I can change.
> > >>>
> > >>> Affiliations of submitters (needed for conflict of interest check):
> > >>>> Apple,
>
> I will have to double-check on the affiliation part wrt to Apple.
>
> If I don't get a thumbs up, you can simply remove me from the list.
>

Do you want me to wait or can I send it today and ask to remove you from
the list later if needed?

Matthieu


>
> Christoph
>
>
> > >>>>
> > >>> Intel, Tessares
> > >>>
> > >>> Description of proposal:
> > >>>>     A project to add an implementation of the MultiPath TCP
> protocol to
> > >>>> the
> > >>>>
> > >>> Linux kernel is in progress by a small community. The goal of this
> > >>> tutorial is to discover what is this TCP extension (RFC 6824), what
> are the
> > >>> different use-cases already in production by some companies and what
> are
> > >>> the challenges to upstream MPTCP. We hope having interactive
> discussions
> > >>> and getting feedback from experienced developers will help us in
> this task
> > >>> of easily bringing MPTCP to all Linux users, a technology already
> used by
> > >>> millions of people.
> > >>>
> > >>
> > >>     In a bit more detail, we will start with a basic introduction of
> > >>>> MPTCP.
> > >>>>
> > >>> A few use-cases will be presented with a demo to explain how useful
> this
> > >>> protocol is in today's Internet and how it can be extended with
> API's like
> > >>> Netlink and BPF.
> > >>>
> > >>
> > >> I recognize how Netlink is associated with a userspace path manager,
> but
> > >> what's the BPF extensibility you're referring to?
> > >>
> > >
> > > It was only to mention that it would be possible to extend MPTCP with
> eBPF.
> > > Even if it is not already available in the current Open-Source
> > > implementation, there is already the possibility to get a version with
> a
> > > programmable scheduler: https://progmp.net
> > >
> > > Then we will have some explanations about how MPTCP is currently
> > >>> implemented. This current implementation is quite intrusive and that
> is
> > >>> certainly not something we would like to have upstream. We would
> like to
> > >>> express what we have in mind to change that, with some samples and
> initiate
> > >>> discussions.
> > >>>
> > >>
> > >> My edit of the above:
> > >>
> > >> """
> > >>
> > >> A community project is underway to add Multipath TCP to the upstream
> > >> Linux kernel. This tutorial will introduce the audience to this TCP
> > >> extension (RFC 6824), show some use cases already in production, and
> > >> discuss the challenges in converging on an upstream MPTCP
> implementation.
> > >>
> > >
> > > Should we insist on the "discussion" part? Like saying: "discuss with
> the
> > > audience"? "have interactive discussions"?
> > > It is maybe not needed but it was mainly to express the interactivity,
> it
> > > is a tutorial, not just a "simple" presentation.
> > >
> > > We will use the current MPTCP implementation to demonstrate the
> utility of
> > >> the protocol on today's internet, and to show how this implementation
> can
> > >> currently be extended with netlink and BPF. This not only has
> practical
> > >> application for deploying MPTCP now, but also illustrates how the
> APIs and
> > >> code will need to evolve in order to properly coexist with the
> optimized
> > >> Linux TCP core we all rely on. We will discuss our ideas for bringing
> MPTCP
> > >> to the upstream kernel so the technology is available to all Linux
> users.
> > >>
> > >
> > > To "attract" people, should we mention that the current implementation
> is
> > > already used by millions of users?
> > > I like how your improve the last bit :-)
> > >
> > > """
> > >>
> > >> Feel free to edit/merge/expand/discard as needed :)
> > >>
> > >
> > > Thank you for your edit, it is indeed cleaner!
> > >
> > >     For more information about this project:
> > >>>>
> > >>> https://github.com/multipath-tcp/mptcp_net-next/wiki
> > >>
> > >>
> > > I guess I can keep this, right?
> > >
> > > Please feel free to comment this as well. We are still far from the m=
ax
> > >>> 350 words limit we found last time. But on the other hand, I can no
> longer
> > >>> find this limit on their website :)
> > >>>
> > >>
> > >> Hope the above is helpful. Thanks again for your work on this
> proposal.
> > >>
> > >
> > > Yes it is, thank you for your help!
> > >
> > > Matthieu
> > >
> > >
> > >>
> > >> Mat
> > >>
> > >>
> > >>
> > >>
> > >>> Thank you for your help!
> > >>>
> > >>> Have a good day/evening,
> > >>> Matthieu
> > >>>
> > >>> On 25/04/2018 21:58, Mat Martineau wrote:
> > >>>
> > >>>>
> > >>>> Hi Matthieu -
> > >>>>
> > >>>> On Fri, 20 Apr 2018, Matthieu Baerts wrote:
> > >>>>
> > >>>> Hello,
> > >>>>>
> > >>>>>
> > >>>>> NetDev 0x12 is coming to Montr=C3=A9al this summer: July 11th to =
13th,
> 2018.
> > >>>>>
> > >>>>>
> > >>>>> We already talked about this event on this ML and at our weekly
> > >>>>> meetings but here is a summary of the discussions we had:
> > >>>>>
> > >>>>>  - we would like to have a presentation there mainly to get
> feedback
> > >>>>> and advice from other kernel developers
> > >>>>>  - a presentation would clearly indicate that this MPTCP Upstream
> > >>>>> project exists and we could get help from more developers
> > >>>>>  - we would like to indicate that having MPTCP upstream is asked =
by
> > >>>>> different companies, some are even ready to contribute ; it is th=
en
> > >>>>> important to have MPTCP upstream
> > >>>>>
> > >>>>>
> > >>>>> Also note that:
> > >>>>>
> > >>>>>  - David Miller will not be present in Montr=C3=A9al [1] but othe=
r main
> > >>>>> contributors should be there (we don't have a list)
> > >>>>>
> > >>>>
> > >>>> Side note, in the past day David reiterated his statement about not
> > >>>> attending or supporting the conference:
> > >>>>
> > >>>> https://marc.info/?l=3Dlinux-netdev&m=3D152466827203301&w=3D2
> > >>>>
> > >>>>  - A presentation by Octavian Purdila about "MPTCP Upstreaming" has
> > >>>>> already been given in 2015 (NetDev 0.1) [2]
> > >>>>>  - 3 types of presentation are available: talks, tutorials and
> > >>>>> workshops [3]
> > >>>>>  - Call for Presentation Proposals closes on May 1st, 2018.
> > >>>>>
> > >>>>>
> > >>>>> The current idea we briefly discussed during our weekly meetings
> is to
> > >>>>> give a tutorial:
> > >>>>>
> > >>>>>  - It is not useful to give almost the same presentation as the
> one of
> > >>>>> Octavian
> > >>>>>  - It will allow us more flexibility somehow to explain what is
> MPTCP,
> > >>>>> the different use-cases, why it is important to have it upstream
> and what
> > >>>>> problems we are currently facing.
> > >>>>>  - David Miller and many other kernel developers will go to LPC in
> > >>>>> November: a good place to give a talk this time.
> > >>>>>
> > >>>>>
> > >>>>> Do you have any ideas on what we could show in this tutorial?
> > >>>>>
> > >>>>>
> > >>>>> I recently discussed with my colleague Olivier Bonaventure who has
> a
> > >>>>> lot of experiences in giving different introductions and more
> about MPTCP
> > >>>>> and here is what he suggests:
> > >>>>>
> > >>>>>  - A first part about a basic introduction of MPTCP
> > >>>>>  - Indicate different use-cases -- if possible with a "closed
> demo" to
> > >>>>> be sure it is working -- asking people to setup something is not
> easy in
> > >>>>> 1h, max 1h30.
> > >>>>>
> > >>>>
> > >>>>  From the description at [3], either "instructor-led" 60-90 minute
> > >>>> tutorials or "student-participation" 2-3 hour sessions are
> possible. The
> > >>>> closed demo maps well to their "instructor-led" category. Looking
> at the
> > >>>> schedule, the past two Netdev Conferences have had one tutorial
> each, of
> > >>>> 60-70 minutes. I think it helps to be closer to an hour in length
> to hold
> > >>>> the audience's attention.
> > >>>>
> > >>>>  - Then trying to have interactive discussions or explanations abo=
ut
> > >>>>> how MPTCP is currently implemented or should be implemented if it
> goes
> > >>>>> upstream, e.g.: for MPTCP, we need to have extra TCP Options, we
> need to
> > >>>>> support middleboxes, we need to link subflows of the same
> connection
> > >>>>> together, we need a scheduler, a PM, etc.
> > >>>>>
> > >>>>
> > >>>> It's difficult to predict how interactive an audience will be. I've
> > >>>> only attended one Netdev Conference, and it seemed like there were
> a lot
> > >>>> more people with expertise and interest in drivers, lower layers
> (XDP, BPF,
> > >>>> TC, netfilter), and network topology/simulation. Discussion around
> > >>>> middlebox support and the userspace API might have more audience
> > >>>> interaction. If we want to drive a discussion, we could try to
> strike a
> > >>>> balance between topics for the broader audience and those with more
> > >>>> knowledge of TCP internals. (Hopefully some TCP internals people
> are still
> > >>>> planning to attend)
> > >>>>
> > >>>>  - Of course, we should focus our discussions on the upstreaming
> > >>>>> aspect, e.g. reducing the footprint of MPTCP in the current TCP
> stack: what
> > >>>>> are we allow to do, what not. It is linked to many previous
> discussions we
> > >>>>> had on this ML, e.g. why we need more indirect function calls and
> how to
> > >>>>> reduce the impact, etc.
> > >>>>>
> > >>>>
> > >>>> The previous talk ([2]) had a section like this. I haven't watched
> it
> > >>>> recently, I should look at it again to see what kind of questions
> the
> > >>>> audience was asking. As you mentioned above we should be careful to
> have
> > >>>> new content compared to the previous session.
> > >>>>
> > >>>>  - If we have time, we could discuss about how users could interact
> > >>>>> with MPTCP: enable it per connection, control the path manager,
> maybe the
> > >>>>> scheduler, etc.
> > >>>>>
> > >>>>>
> > >>>>> What do you think about this? Feel free to comment and even propo=
se
> > >>>>> completely different ideas!
> > >>>>>
> > >>>>
> > >>>> Thank you for outlining these ideas. I see that this topic is on o=
ur
> > >>>> meeting agenda so it will be good to discuss the tutorial there.
> > >>>>
> > >>>>
> > >>>> [1] https://lists.01.org/pipermail/mptcp/2018-March/000379.html
> > >>>>> [2] https://www.youtube.com/watch?v=3Dwftz2cU5SZs
> > >>>>> [3] https://www.netdevconf.org/0x12/submit-proposal.html
> > >>>>>
> > >>>>
> > >>>>
> > >> --
> > >> Mat Martineau
> > >> Intel OTC
> > >>
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
> Ottignies-Louvain-la-Neuve,+Belgium>
> > >
> >
> >
> >
> > --
> > [image: Tessares SA] <http://www.tessares.net> Matthieu Baerts | R&D
> > Engineer
> > matthieu.baerts(a)tessares.net
> > Tessares SA | Hybrid Access Solutions
> > www.tessares.net
> > 1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
> > <https://www.google.com/maps?q=3D1+Avenue+Jean+Monnet,+1348+
> Ottignies-Louvain-la-Neuve,+Belgium>
> >
> > --
> >
> >
> > DISCLAIMER.
> > This email and any files transmitted with it are confidential
> > and intended solely for the use of the individual or entity to whom they
> > are addressed. If you have received this email in error please notify
> the
> > system manager. This message contains confidential information and is
> > intended only for the individual named. If you are not the named
> addressee
> > you should not disseminate, distribute or copy this e-mail. Please
> notify
> > the sender immediately by e-mail if you have received this e-mail by
> > mistake and delete this e-mail from your system. If you are not the
> > intended recipient you are notified that disclosing, copying,
> distributing
> > or taking any action in reliance on the contents of this information is
> > strictly prohibited.
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

--===============2609213453653917614==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX2V4dHJhIj48YnI+PGRpdiBjbGFz
cz0iZ21haWxfcXVvdGUiPk9uIE1vbiwgQXByIDMwLCAyMDE4IGF0IDY6MTggUE0sIENocmlzdG9w
aCBQYWFzY2ggPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBs
ZS5jb20iIHRhcmdldD0iX2JsYW5rIj5jcGFhc2NoQGFwcGxlLmNvbTwvYT4mZ3Q7PC9zcGFuPiB3
cm90ZTo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRp
diBjbGFzcz0iSE9FblpiIj48ZGl2IGNsYXNzPSJoNSI+T24gMzAvMDQvMTggLSAxNjoyNjowMSwg
TWF0dGhpZXUgQmFlcnRzIHdyb3RlOjxicj4KJmd0OyBIaSBNYXQsIENocmlzdG9waCwgUGV0ZXIs
IE9zc2FtYSw8YnI+CiZndDsgPGJyPgomZ3Q7IEkgd2lsbCB3YWl0IGZvciB+MTBhbSB5b3VyIHRp
bWUgYmVmb3JlIHNlbmRpbmcgaXQgdG8gbGV0IHlvdSBzb21lIHRpbWVzIHRvPGJyPgomZ3Q7IGNv
bW1lbnQgdGhpcyBpZiB5b3Ugd2FudCB0byBkbyBzby48YnI+CiZndDsgPGJyPgomZ3Q7IEJlc3Qg
cmVnYXJkcyw8YnI+CiZndDsgTWF0dGhpZXU8YnI+CiZndDsgPGJyPgomZ3Q7IE9uIFN1biwgQXBy
IDI5LCAyMDE4IGF0IDQ6MDggUE0sIE1hdHRoaWV1IEJhZXJ0cyAmbHQ7PGJyPgomZ3Q7IDxhIGhy
ZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0Ij5tYXR0aGlldS5iYWVydHNA
dGVzc2FyZXMubmV0PC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7IDxicj4KJmd0OyAmZ3Q7IEhpIE1h
dCw8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IFRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcg
YW5kIGlucHV0ITxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgT24gU2F0LCBBcHIgMjgsIDIw
MTggYXQgMjo0NCBBTSwgTWF0IE1hcnRpbmVhdSAmbHQ7bWF0aGV3LmoubWFydGluZWF1QGxpbnV4
Ljxicj4KJmd0OyAmZ3Q7IDxhIGhyZWY9Imh0dHA6Ly9pbnRlbC5jb20iIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPmludGVsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4KJmd0OyAmZ3Q7
PGJyPgomZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7IEhpIE1hdHRoaWV1IC08YnI+CiZn
dDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsgT24gRnJpLCAyNyBBcHIgMjAxOCwgTWF0dGhp
ZXUgQmFlcnRzIHdyb3RlOjxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyBIZWxs
byw8YnI+CiZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBGb2xsb3dpbmcg
eWVzdGVyZGF5JiMzOTtzIGRpc2N1c3Npb24gYWJvdXQgTmV0RGV2IDB4MTIsIGhlcmUgaXMgYTxi
cj4KJmd0OyAmZ3Q7Jmd0OyZndDsgcHJvcG9zaXRpb24gb2YgbWFpbCB0byBzZW5kIHRvIE5ldERl
diBjb21taXR0ZWUuIEkgYWxyZWFkeSBwdXQgc29tZTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgY29t
bWVudHMuIE5vdGUgdGhhdCBJIGhhdmUgZm9sbG93ZWQgdGhlIHN1Ym1pc3Npb24gZ3VpZGVsaW5l
cyBmcm9tOjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgPGEgaHJlZj0iaHR0cHM6Ly93d3cubmV0ZGV2
Y29uZi5vcmcvMHgxMi9zdWJtaXQtcHJvcG9zYWwuaHRtbCNwcm9wb3NhbHMiIHJlbD0ibm9yZWZl
cnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vd3d3Lm5ldGRldmNvbmYub3JnLzx3YnI+MHgx
Mi9zdWJtaXQtcHJvcG9zYWwuaHRtbCM8d2JyPnByb3Bvc2FsczwvYT48YnI+CiZndDsgJmd0OyZn
dDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBQbGVhc2UgY29tbWVudCBpdCBiZWZvcmUgTW9u
ZGF5IG1vcm5pbmcuIFNvcnJ5IGZvciB0aGUgcnVzaCBidXQgdGhlPGJyPgomZ3Q7ICZndDsmZ3Q7
Jmd0OyBkZWFkbGluZSBpcyB0aGUgMXN0IG9mIE1heSA6KTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8
YnI+CiZndDsgJmd0OyZndDsmZ3Q7ICogTmFtZShzKSBvZiB0aGUgc3VibWl0dGVyKHMpOiBDaHJp
c3RvcGggUGFhc2NoIChBcHBsZSksIE1hdCBNYXJ0aW5lYXU8YnI+CiZndDsgJmd0OyZndDsmZ3Q7
Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgKEludGVsKSwgUGV0ZXIgS3J5c3RhZCAoSW50ZWwp
LCBPc3NhbWEgT3RobWFuIChJbnRlbCkgYW5kIG15c2VsZiw8YnI+CiZndDsgJmd0OyZndDsmZ3Q7
IE1hdHRoaWV1IEJhZXJ0cyAoVGVzc2FyZXMpPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0
OyAmZ3Q7Jmd0OyZndDsgSSB3cm90ZSBkb3duIHRoZSBuYW1lcyBvZiBwZW9wbGUgd2hvIHBhcnRp
Y2lwYXRlZCBpbiB0aGUgZGlzY3Vzc2lvbiBpbjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgdGhlIE1M
IGFuZCBkdXJpbmcgdGhlIHdlZWtseSBtZWV0aW5ncy4gSSBjYW4gYWRkIG1vcmUgcGVvcGxlIGlm
IG1vcmUgcGVvcGxlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyB3b3VsZCBsaWtlIHRvIGpvaW4gdGhl
IHByZXBhcmF0aW9uIGFuZCBwcmVzZW50YXRpb24gb2YgdGhpcyB0dXRvcmlhbC48YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7IEBDaHJpc3RvcGgsIE1hdCwgUGV0ZXIsIE9zc2FtYTogY2FuIEkgd3JpdGUg
eW91ciBuYW1lcyB0aGVyZT88YnI+CiZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7
PGJyPgomZ3Q7ICZndDsmZ3Q7IE9zc2FtYSB3b24mIzM5O3QgYmUgYWJsZSB0byBhdHRlbmQuIEl0
IGxvb2tzIGxpa2UgbW9zdCBzZXNzaW9ucyBoYXZlIDEgb3IgMjxicj4KJmd0OyAmZ3Q7Jmd0OyBw
cmVzZW50ZXJzLCBzbyBJIGRvbiYjMzk7dCBrbm93IGlmIDQgaXMgdG9vIG1hbnkuIEkmIzM5O20g
c3VyZSB0aGV5JiMzOTtsbCBnaXZlIHVzIHNvbWU8YnI+CiZndDsgJmd0OyZndDsgZmVlZGJhY2sg
aWYgdGhleSB3YW50IHRvIGxpbWl0IHRoZSBudW1iZXIgb2YgcHJlc2VudGVycy48YnI+CiZndDsg
Jmd0OyZndDs8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IE9LIHRoYW5rIHlvdSE8YnI+CiZn
dDsgJmd0OyBZZXMgaW5kZWVkLCBJIGFtIHN1cmUgdGhleSB3aWxsIHNheSBzb21ldGhpbmcgaWYg
d2UgYXJlIHRvbyBtYW55Ljxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgKiBUaXRsZSBvZiB0
aGUgc3VibWlzc2lvbjogTVBUQ1A6IGZyb20gdGhlIGJhc2ljIHRvIGFuIHVwc3RyZWFtYWJsZSBi
YXNlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7PGJyPgom
Z3Q7ICZndDsmZ3Q7Jmd0OyBXZSBjZXJ0YWlubHkgbmVlZCBhIGJldHRlciB0aXRsZSwgcGxlYXNl
IGNvbW1lbnQhPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0
OyAmZ3Q7Jmd0OyAmcXVvdDtNdWx0aXBhdGggVENQOiBQcmVzZW50IFVzZSBDYXNlcyBhbmQgYW4g
VXBzdHJlYW0gRnV0dXJlJnF1b3Q7ID88YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0Ozxi
cj4KJmd0OyAmZ3Q7IEkgd2FzIHRyeWluZyB0byBmaW5kIHNvbWV0aGluZyB0aGF0IGNhdGNoIHRo
ZSBhdHRlbnRpb24gYnV0IGl0IGlzIG1heWJlPGJyPgomZ3Q7ICZndDsgbm90IG5lZWRlZCBmb3Ig
dGhlc2Uga2luZCBvZiBwcmVzZW50YXRpb24uPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAm
Z3Q7ICogTGFiZWwgKG9uZSBvZiBtb29uc2hvdCwgbnV0cyYjMzk7biBib2x0cywgaGFuZHMtb24p
OiBoYW5kcy1vbjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7ICZx
dW90O2hhbmRzLW9uJnF1b3Q7IHNlZW1zIHRvIGJlIHRoZSBjb3JyZWN0IG9uZSBhY2NvcmRpbmcg
dG8gdGhlIFN1Ym1pc3Npb24gVHlwZXMuPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyA8YSBocmVmPSJo
dHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy8weDEyL3N1Ym1pdC1wcm9wb3NhbC5odG1sI3R5cGVz
IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5uZXRkZXZjb25m
Lm9yZy88d2JyPjB4MTIvc3VibWl0LXByb3Bvc2FsLmh0bWwjPHdicj50eXBlczwvYT48YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7IEl0JiMz
OTtzIGEgbGl0dGxlIGJpdCBvZiAmcXVvdDtudXRzICZhbXA7IGJvbHRzJnF1b3Q7IHRvbywgYnV0
IEkgYWdyZWUgdGhhdCBoYW5kcy1vbiBpcyB0aGU8YnI+CiZndDsgJmd0OyZndDsgYmV0dGVyIG1h
dGNoLjxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgVGhhbmsg
eW91ITxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgKiBTdWJtaXNzaW9uIHR5cGUgKG9uZSBv
ZiB0YWxrLCBwcmVzZW50YXRpb24sIHdvcmtzaG9wKTogdHV0b3JpYWwsPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IGluc3RydWN0b3ItbGVkIHNlc3Npb25z
IChtaW5pbXVtIDEgaG91ciBsb25nIGFuZCBub3QgdG8gZXhjZWVkIDEuNTxicj4KJmd0OyAmZ3Q7
Jmd0OyZndDsgaG91cnMuIFRoZSBpbnN0cnVjdG9yIHdpbGwgZ28gb3ZlciB0aGUgdGVjaG5vbG9n
eSBlaXRoZXIgdGhyb3VnaCBjb2RlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyByZXZpZXcgb3IgZXhl
Y3V0aW9uIGFuZCBpbnRlcmFjdCB3aXRoIHRoZSBhdHRlbmRlZXMuKTxicj4KJmd0OyAmZ3Q7Jmd0
OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IEkgZ3Vlc3MgdGhlcmUgaXMgYSB0eXBvIGhlcmU6
IHByZXNlbnRhdGlvbiBzaG91bGQgYmUgcmVwbGFjZWQgYnk8YnI+CiZndDsgJmd0OyZndDsmZ3Q7
IHR1dG9yaWFsIGluIHRoZSBndWlkZWxpbmVzLjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7IEVzdGltYXRlIG9mIGxlbmd0aCBvZiB0aW1lIGZvciBwcmVzZW50YXRp
b246IDFoPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7PGJy
PgomZ3Q7ICZndDsmZ3Q7Jmd0OyBUaGF0JiMzOTtzIHdoYXQgd2UgYWdyZWVkIHllc3RlcmRheSBi
dXQgSSBjYW4gY2hhbmdlLjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsm
Z3Q7IEFmZmlsaWF0aW9ucyBvZiBzdWJtaXR0ZXJzIChuZWVkZWQgZm9yIGNvbmZsaWN0IG9mIGlu
dGVyZXN0IGNoZWNrKTo8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBBcHBsZSw8YnI+Cjxicj4K
PC9kaXY+PC9kaXY+SSB3aWxsIGhhdmUgdG8gZG91YmxlLWNoZWNrIG9uIHRoZSBhZmZpbGlhdGlv
biBwYXJ0IHdydCB0byBBcHBsZS48YnI+Cjxicj4KSWYgSSBkb24mIzM5O3QgZ2V0IGEgdGh1bWJz
IHVwLCB5b3UgY2FuIHNpbXBseSByZW1vdmUgbWUgZnJvbSB0aGUgbGlzdC48YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+RG8geW91IHdhbnQgbWUgdG8gd2FpdCBvciBjYW4gSSBz
ZW5kIGl0IHRvZGF5IGFuZCBhc2sgdG8gcmVtb3ZlIHlvdSBmcm9tIHRoZSBsaXN0IGxhdGVyIGlm
IG5lZWRlZD88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk1hdHRoaWV1PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+Cjxicj4K
PGJyPgpDaHJpc3RvcGg8YnI+CjxkaXY+PGRpdiBjbGFzcz0iaDUiPjxicj4KPGJyPgomZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IEludGVsLCBUZXNzYXJlczxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IERlc2NyaXB0aW9uIG9mIHBy
b3Bvc2FsOjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7wqAgwqAgwqBBIHByb2plY3QgdG8gYWRk
IGFuIGltcGxlbWVudGF0aW9uIG9mIHRoZSBNdWx0aVBhdGggVENQIHByb3RvY29sIHRvPGJyPgom
Z3Q7ICZndDsmZ3Q7Jmd0OyZndDsgdGhlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7IExpbnV4IGtlcm5lbCBpcyBpbiBwcm9ncmVzcyBieSBhIHNtYWxsIGNv
bW11bml0eS4gVGhlIGdvYWwgb2YgdGhpczxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgdHV0b3JpYWwg
aXMgdG8gZGlzY292ZXIgd2hhdCBpcyB0aGlzIFRDUCBleHRlbnNpb24gKFJGQyA2ODI0KSwgd2hh
dCBhcmUgdGhlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBkaWZmZXJlbnQgdXNlLWNhc2VzIGFscmVh
ZHkgaW4gcHJvZHVjdGlvbiBieSBzb21lIGNvbXBhbmllcyBhbmQgd2hhdCBhcmU8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7IHRoZSBjaGFsbGVuZ2VzIHRvIHVwc3RyZWFtIE1QVENQLiBXZSBob3BlIGhh
dmluZyBpbnRlcmFjdGl2ZSBkaXNjdXNzaW9uczxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgYW5kIGdl
dHRpbmcgZmVlZGJhY2sgZnJvbSBleHBlcmllbmNlZCBkZXZlbG9wZXJzIHdpbGwgaGVscCB1cyBp
biB0aGlzIHRhc2s8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IG9mIGVhc2lseSBicmluZ2luZyBNUFRD
UCB0byBhbGwgTGludXggdXNlcnMsIGEgdGVjaG5vbG9neSBhbHJlYWR5IHVzZWQgYnk8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7IG1pbGxpb25zIG9mIHBlb3BsZS48YnI+CiZndDsgJmd0OyZndDsmZ3Q7
PGJyPgomZ3Q7ICZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7wqAgwqAgwqBJbiBhIGJpdCBtb3Jl
IGRldGFpbCwgd2Ugd2lsbCBzdGFydCB3aXRoIGEgYmFzaWMgaW50cm9kdWN0aW9uIG9mPGJyPgom
Z3Q7ICZndDsmZ3Q7Jmd0OyZndDsgTVBUQ1AuPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+
CiZndDsgJmd0OyZndDsmZ3Q7IEEgZmV3IHVzZS1jYXNlcyB3aWxsIGJlIHByZXNlbnRlZCB3aXRo
IGEgZGVtbyB0byBleHBsYWluIGhvdyB1c2VmdWwgdGhpczxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsg
cHJvdG9jb2wgaXMgaW4gdG9kYXkmIzM5O3MgSW50ZXJuZXQgYW5kIGhvdyBpdCBjYW4gYmUgZXh0
ZW5kZWQgd2l0aCBBUEkmIzM5O3MgbGlrZTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgTmV0bGluayBh
bmQgQlBGLjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsg
Jmd0OyZndDsgSSByZWNvZ25pemUgaG93IE5ldGxpbmsgaXMgYXNzb2NpYXRlZCB3aXRoIGEgdXNl
cnNwYWNlIHBhdGggbWFuYWdlciwgYnV0PGJyPgomZ3Q7ICZndDsmZ3Q7IHdoYXQmIzM5O3MgdGhl
IEJQRiBleHRlbnNpYmlsaXR5IHlvdSYjMzk7cmUgcmVmZXJyaW5nIHRvPzxicj4KJmd0OyAmZ3Q7
Jmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgSXQgd2FzIG9ubHkgdG8gbWVudGlvbiB0
aGF0IGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIGV4dGVuZCBNUFRDUCB3aXRoIGVCUEYuPGJyPgom
Z3Q7ICZndDsgRXZlbiBpZiBpdCBpcyBub3QgYWxyZWFkeSBhdmFpbGFibGUgaW4gdGhlIGN1cnJl
bnQgT3Blbi1Tb3VyY2U8YnI+CiZndDsgJmd0OyBpbXBsZW1lbnRhdGlvbiwgdGhlcmUgaXMgYWxy
ZWFkeSB0aGUgcG9zc2liaWxpdHkgdG8gZ2V0IGEgdmVyc2lvbiB3aXRoIGE8YnI+CiZndDsgJmd0
OyBwcm9ncmFtbWFibGUgc2NoZWR1bGVyOiA8YSBocmVmPSJodHRwczovL3Byb2dtcC5uZXQiIHJl
bD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vcHJvZ21wLm5ldDwvYT48YnI+
CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IFRoZW4gd2Ugd2lsbCBoYXZlIHNvbWUgZXhwbGFuYXRp
b25zIGFib3V0IGhvdyBNUFRDUCBpcyBjdXJyZW50bHk8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IGlt
cGxlbWVudGVkLiBUaGlzIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXMgcXVpdGUgaW50cnVzaXZl
IGFuZCB0aGF0IGlzPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBjZXJ0YWlubHkgbm90IHNvbWV0aGlu
ZyB3ZSB3b3VsZCBsaWtlIHRvIGhhdmUgdXBzdHJlYW0uIFdlIHdvdWxkIGxpa2UgdG88YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7IGV4cHJlc3Mgd2hhdCB3ZSBoYXZlIGluIG1pbmQgdG8gY2hhbmdlIHRo
YXQsIHdpdGggc29tZSBzYW1wbGVzIGFuZCBpbml0aWF0ZTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsg
ZGlzY3Vzc2lvbnMuPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4K
Jmd0OyAmZ3Q7Jmd0OyBNeSBlZGl0IG9mIHRoZSBhYm92ZTo8YnI+CiZndDsgJmd0OyZndDs8YnI+
CiZndDsgJmd0OyZndDsgJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7PGJyPgom
Z3Q7ICZndDsmZ3Q7IEEgY29tbXVuaXR5IHByb2plY3QgaXMgdW5kZXJ3YXkgdG8gYWRkIE11bHRp
cGF0aCBUQ1AgdG8gdGhlIHVwc3RyZWFtPGJyPgomZ3Q7ICZndDsmZ3Q7IExpbnV4IGtlcm5lbC4g
VGhpcyB0dXRvcmlhbCB3aWxsIGludHJvZHVjZSB0aGUgYXVkaWVuY2UgdG8gdGhpcyBUQ1A8YnI+
CiZndDsgJmd0OyZndDsgZXh0ZW5zaW9uIChSRkMgNjgyNCksIHNob3cgc29tZSB1c2UgY2FzZXMg
YWxyZWFkeSBpbiBwcm9kdWN0aW9uLCBhbmQ8YnI+CiZndDsgJmd0OyZndDsgZGlzY3VzcyB0aGUg
Y2hhbGxlbmdlcyBpbiBjb252ZXJnaW5nIG9uIGFuIHVwc3RyZWFtIE1QVENQIGltcGxlbWVudGF0
aW9uLjxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgU2hvdWxk
IHdlIGluc2lzdCBvbiB0aGUgJnF1b3Q7ZGlzY3Vzc2lvbiZxdW90OyBwYXJ0PyBMaWtlIHNheWlu
ZzogJnF1b3Q7ZGlzY3VzcyB3aXRoIHRoZTxicj4KJmd0OyAmZ3Q7IGF1ZGllbmNlJnF1b3Q7PyAm
cXVvdDtoYXZlIGludGVyYWN0aXZlIGRpc2N1c3Npb25zJnF1b3Q7Pzxicj4KJmd0OyAmZ3Q7IEl0
IGlzIG1heWJlIG5vdCBuZWVkZWQgYnV0IGl0IHdhcyBtYWlubHkgdG8gZXhwcmVzcyB0aGUgaW50
ZXJhY3Rpdml0eSwgaXQ8YnI+CiZndDsgJmd0OyBpcyBhIHR1dG9yaWFsLCBub3QganVzdCBhICZx
dW90O3NpbXBsZSZxdW90OyBwcmVzZW50YXRpb24uPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0
OyBXZSB3aWxsIHVzZSB0aGUgY3VycmVudCBNUFRDUCBpbXBsZW1lbnRhdGlvbiB0byBkZW1vbnN0
cmF0ZSB0aGUgdXRpbGl0eSBvZjxicj4KJmd0OyAmZ3Q7Jmd0OyB0aGUgcHJvdG9jb2wgb24gdG9k
YXkmIzM5O3MgaW50ZXJuZXQsIGFuZCB0byBzaG93IGhvdyB0aGlzIGltcGxlbWVudGF0aW9uIGNh
bjxicj4KJmd0OyAmZ3Q7Jmd0OyBjdXJyZW50bHkgYmUgZXh0ZW5kZWQgd2l0aCBuZXRsaW5rIGFu
ZCBCUEYuIFRoaXMgbm90IG9ubHkgaGFzIHByYWN0aWNhbDxicj4KJmd0OyAmZ3Q7Jmd0OyBhcHBs
aWNhdGlvbiBmb3IgZGVwbG95aW5nIE1QVENQIG5vdywgYnV0IGFsc28gaWxsdXN0cmF0ZXMgaG93
IHRoZSBBUElzIGFuZDxicj4KJmd0OyAmZ3Q7Jmd0OyBjb2RlIHdpbGwgbmVlZCB0byBldm9sdmUg
aW4gb3JkZXIgdG8gcHJvcGVybHkgY29leGlzdCB3aXRoIHRoZSBvcHRpbWl6ZWQ8YnI+CiZndDsg
Jmd0OyZndDsgTGludXggVENQIGNvcmUgd2UgYWxsIHJlbHkgb24uIFdlIHdpbGwgZGlzY3VzcyBv
dXIgaWRlYXMgZm9yIGJyaW5naW5nIE1QVENQPGJyPgomZ3Q7ICZndDsmZ3Q7IHRvIHRoZSB1cHN0
cmVhbSBrZXJuZWwgc28gdGhlIHRlY2hub2xvZ3kgaXMgYXZhaWxhYmxlIHRvIGFsbCBMaW51eCB1
c2Vycy48YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IFRvICZx
dW90O2F0dHJhY3QmcXVvdDsgcGVvcGxlLCBzaG91bGQgd2UgbWVudGlvbiB0aGF0IHRoZSBjdXJy
ZW50IGltcGxlbWVudGF0aW9uIGlzPGJyPgomZ3Q7ICZndDsgYWxyZWFkeSB1c2VkIGJ5IG1pbGxp
b25zIG9mIHVzZXJzPzxicj4KJmd0OyAmZ3Q7IEkgbGlrZSBob3cgeW91ciBpbXByb3ZlIHRoZSBs
YXN0IGJpdCA6LSk8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZxdW90OyZxdW90OyZxdW90
Ozxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyBGZWVsIGZyZWUgdG8gZWRpdC9t
ZXJnZS9leHBhbmQvZGlzY2FyZCBhcyBuZWVkZWQgOik8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZn
dDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IFRoYW5rIHlvdSBmb3IgeW91ciBlZGl0LCBpdCBpcyBpbmRl
ZWQgY2xlYW5lciE8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7wqAgwqAgwqBGb3IgbW9yZSBp
bmZvcm1hdGlvbiBhYm91dCB0aGlzIHByb2plY3Q6PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8
YnI+CiZndDsgJmd0OyZndDsmZ3Q7IDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBh
dGgtdGNwL21wdGNwX25ldC1uZXh0L3dpa2kiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxh
bmsiPmh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtPHdicj50Y3AvbXB0Y3BfbmV0LW5leHQv
d2lraTwvYT48YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0
OyBJIGd1ZXNzIEkgY2FuIGtlZXAgdGhpcywgcmlnaHQ/PGJyPgomZ3Q7ICZndDs8YnI+CiZndDsg
Jmd0OyBQbGVhc2UgZmVlbCBmcmVlIHRvIGNvbW1lbnQgdGhpcyBhcyB3ZWxsLiBXZSBhcmUgc3Rp
bGwgZmFyIGZyb20gdGhlIG1heDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgMzUwIHdvcmRzIGxpbWl0
IHdlIGZvdW5kIGxhc3QgdGltZS4gQnV0IG9uIHRoZSBvdGhlciBoYW5kLCBJIGNhbiBubyBsb25n
ZXI8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IGZpbmQgdGhpcyBsaW1pdCBvbiB0aGVpciB3ZWJzaXRl
IDopPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7
Jmd0OyBIb3BlIHRoZSBhYm92ZSBpcyBoZWxwZnVsLiBUaGFua3MgYWdhaW4gZm9yIHlvdXIgd29y
ayBvbiB0aGlzIHByb3Bvc2FsLjxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgom
Z3Q7ICZndDsgWWVzIGl0IGlzLCB0aGFuayB5b3UgZm9yIHlvdXIgaGVscCE8YnI+CiZndDsgJmd0
Ozxicj4KJmd0OyAmZ3Q7IE1hdHRoaWV1PGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0Ozxicj4K
Jmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyBNYXQ8YnI+CiZndDsgJmd0OyZndDs8YnI+
CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7IFRoYW5rIHlvdSBmb3IgeW91ciBoZWxwITxicj4KJmd0OyAmZ3Q7Jmd0
OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IEhhdmUgYSBnb29kIGRheS9ldmVuaW5nLDxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsgTWF0dGhpZXU8YnI+CiZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7
ICZndDsmZ3Q7Jmd0OyBPbiAyNS8wNC8yMDE4IDIxOjU4LCBNYXQgTWFydGluZWF1IHdyb3RlOjxi
cj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7Jmd0OyZndDsmZ3Q7IEhpIE1hdHRoaWV1IC08YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxi
cj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IE9uIEZyaSwgMjAgQXByIDIwMTgsIE1hdHRoaWV1IEJh
ZXJ0cyB3cm90ZTo8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZn
dDsmZ3Q7IEhlbGxvLDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBOZXREZXYgMHgx
MiBpcyBjb21pbmcgdG8gTW9udHLDqWFsIHRoaXMgc3VtbWVyOiBKdWx5IDExdGggdG8gMTN0aCwg
MjAxOC48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7
Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgV2UgYWxyZWFkeSB0YWxrZWQg
YWJvdXQgdGhpcyBldmVudCBvbiB0aGlzIE1MIGFuZCBhdCBvdXIgd2Vla2x5PGJyPgomZ3Q7ICZn
dDsmZ3Q7Jmd0OyZndDsmZ3Q7IG1lZXRpbmdzIGJ1dCBoZXJlIGlzIGEgc3VtbWFyeSBvZiB0aGUg
ZGlzY3Vzc2lvbnMgd2UgaGFkOjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0
OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0O8KgIC0gd2Ugd291bGQgbGlrZSB0byBoYXZlIGEgcHJlc2Vu
dGF0aW9uIHRoZXJlIG1haW5seSB0byBnZXQgZmVlZGJhY2s8YnI+CiZndDsgJmd0OyZndDsmZ3Q7
Jmd0OyZndDsgYW5kIGFkdmljZSBmcm9tIG90aGVyIGtlcm5lbCBkZXZlbG9wZXJzPGJyPgomZ3Q7
ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7wqAgLSBhIHByZXNlbnRhdGlvbiB3b3VsZCBjbGVhcmx5IGlu
ZGljYXRlIHRoYXQgdGhpcyBNUFRDUCBVcHN0cmVhbTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyBwcm9qZWN0IGV4aXN0cyBhbmQgd2UgY291bGQgZ2V0IGhlbHAgZnJvbSBtb3JlIGRldmVs
b3BlcnM8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCAtIHdlIHdvdWxkIGxpa2UgdG8g
aW5kaWNhdGUgdGhhdCBoYXZpbmcgTVBUQ1AgdXBzdHJlYW0gaXMgYXNrZWQgYnk8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7Jmd0OyZndDsgZGlmZmVyZW50IGNvbXBhbmllcywgc29tZSBhcmUgZXZlbiBy
ZWFkeSB0byBjb250cmlidXRlIDsgaXQgaXMgdGhlbjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyBpbXBvcnRhbnQgdG8gaGF2ZSBNUFRDUCB1cHN0cmVhbTxicj4KJmd0OyAmZ3Q7Jmd0OyZn
dDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0
OyZndDsmZ3Q7Jmd0OyBBbHNvIG5vdGUgdGhhdDo8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZn
dDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCAtIERhdmlkIE1pbGxlciB3aWxsIG5v
dCBiZSBwcmVzZW50IGluIE1vbnRyw6lhbCBbMV0gYnV0IG90aGVyIG1haW48YnI+CiZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyZndDsgY29udHJpYnV0b3JzIHNob3VsZCBiZSB0aGVyZSAod2UgZG9uJiMz
OTt0IGhhdmUgYSBsaXN0KTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgU2lkZSBub3RlLCBpbiB0
aGUgcGFzdCBkYXkgRGF2aWQgcmVpdGVyYXRlZCBoaXMgc3RhdGVtZW50IGFib3V0IG5vdDxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IGF0dGVuZGluZyBvciBzdXBwb3J0aW5nIHRoZSBjb25mZXJl
bmNlOjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsg
PGEgaHJlZj0iaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbmV0ZGV2JmFtcDttPTE1MjQ2Njgy
NzIwMzMwMSZhbXA7dz0yIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczov
L21hcmMuaW5mby8/bD1saW51eC08d2JyPm5ldGRldiZhbXA7bT0xNTI0NjY4MjcyMDMzMDEmYW1w
O3c9MjwvYT48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsm
Z3Q7wqAgLSBBIHByZXNlbnRhdGlvbiBieSBPY3RhdmlhbiBQdXJkaWxhIGFib3V0ICZxdW90O01Q
VENQIFVwc3RyZWFtaW5nJnF1b3Q7IGhhczxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBh
bHJlYWR5IGJlZW4gZ2l2ZW4gaW4gMjAxNSAoTmV0RGV2IDAuMSkgWzJdPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsmZ3Q7wqAgLSAzIHR5cGVzIG9mIHByZXNlbnRhdGlvbiBhcmUgYXZhaWxhYmxl
OiB0YWxrcywgdHV0b3JpYWxzIGFuZDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyB3b3Jr
c2hvcHMgWzNdPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7wqAgLSBDYWxsIGZvciBQcmVz
ZW50YXRpb24gUHJvcG9zYWxzIGNsb3NlcyBvbiBNYXkgMXN0LCAyMDE4Ljxicj4KJmd0OyAmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBUaGUgY3VycmVudCBpZGVhIHdlIGJyaWVmbHkgZGlzY3Vzc2Vk
IGR1cmluZyBvdXIgd2Vla2x5IG1lZXRpbmdzIGlzIHRvPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7IGdpdmUgYSB0dXRvcmlhbDo8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+
CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCAtIEl0IGlzIG5vdCB1c2VmdWwgdG8gZ2l2ZSBh
bG1vc3QgdGhlIHNhbWUgcHJlc2VudGF0aW9uIGFzIHRoZSBvbmUgb2Y8YnI+CiZndDsgJmd0OyZn
dDsmZ3Q7Jmd0OyZndDsgT2N0YXZpYW48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCAt
IEl0IHdpbGwgYWxsb3cgdXMgbW9yZSBmbGV4aWJpbGl0eSBzb21laG93IHRvIGV4cGxhaW4gd2hh
dCBpcyBNUFRDUCw8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgdGhlIGRpZmZlcmVudCB1
c2UtY2FzZXMsIHdoeSBpdCBpcyBpbXBvcnRhbnQgdG8gaGF2ZSBpdCB1cHN0cmVhbSBhbmQgd2hh
dDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBwcm9ibGVtcyB3ZSBhcmUgY3VycmVudGx5
IGZhY2luZy48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCAtIERhdmlkIE1pbGxlciBh
bmQgbWFueSBvdGhlciBrZXJuZWwgZGV2ZWxvcGVycyB3aWxsIGdvIHRvIExQQyBpbjxicj4KJmd0
OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBOb3ZlbWJlcjogYSBnb29kIHBsYWNlIHRvIGdpdmUgYSB0
YWxrIHRoaXMgdGltZS48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgRG8geW91IGhh
dmUgYW55IGlkZWFzIG9uIHdoYXQgd2UgY291bGQgc2hvdyBpbiB0aGlzIHR1dG9yaWFsPzxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxi
cj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBJIHJlY2VudGx5IGRpc2N1c3NlZCB3aXRoIG15
IGNvbGxlYWd1ZSBPbGl2aWVyIEJvbmF2ZW50dXJlIHdobyBoYXMgYTxicj4KJmd0OyAmZ3Q7Jmd0
OyZndDsmZ3Q7Jmd0OyBsb3Qgb2YgZXhwZXJpZW5jZXMgaW4gZ2l2aW5nIGRpZmZlcmVudCBpbnRy
b2R1Y3Rpb25zIGFuZCBtb3JlIGFib3V0IE1QVENQPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7IGFuZCBoZXJlIGlzIHdoYXQgaGUgc3VnZ2VzdHM6PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7wqAgLSBBIGZpcnN0IHBhcnQgYWJv
dXQgYSBiYXNpYyBpbnRyb2R1Y3Rpb24gb2YgTVBUQ1A8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0
OyZndDvCoCAtIEluZGljYXRlIGRpZmZlcmVudCB1c2UtY2FzZXMgLS0gaWYgcG9zc2libGUgd2l0
aCBhICZxdW90O2Nsb3NlZCBkZW1vJnF1b3Q7IHRvPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7IGJlIHN1cmUgaXQgaXMgd29ya2luZyAtLSBhc2tpbmcgcGVvcGxlIHRvIHNldHVwIHNvbWV0
aGluZyBpcyBub3QgZWFzeSBpbjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyAxaCwgbWF4
IDFoMzAuPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0
OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0O8KgIEZyb20gdGhlIGRlc2NyaXB0aW9uIGF0
IFszXSwgZWl0aGVyICZxdW90O2luc3RydWN0b3ItbGVkJnF1b3Q7IDYwLTkwIG1pbnV0ZTxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IHR1dG9yaWFscyBvciAmcXVvdDtzdHVkZW50LXBhcnRpY2lw
YXRpb24mcXVvdDsgMi0zIGhvdXIgc2Vzc2lvbnMgYXJlIHBvc3NpYmxlLiBUaGU8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7Jmd0OyBjbG9zZWQgZGVtbyBtYXBzIHdlbGwgdG8gdGhlaXIgJnF1b3Q7aW5z
dHJ1Y3Rvci1sZWQmcXVvdDsgY2F0ZWdvcnkuIExvb2tpbmcgYXQgdGhlPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsgc2NoZWR1bGUsIHRoZSBwYXN0IHR3byBOZXRkZXYgQ29uZmVyZW5jZXMgaGF2
ZSBoYWQgb25lIHR1dG9yaWFsIGVhY2gsIG9mPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgNjAt
NzAgbWludXRlcy4gSSB0aGluayBpdCBoZWxwcyB0byBiZSBjbG9zZXIgdG8gYW4gaG91ciBpbiBs
ZW5ndGggdG8gaG9sZDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IHRoZSBhdWRpZW5jZSYjMzk7
cyBhdHRlbnRpb24uPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsm
Z3Q7Jmd0O8KgIC0gVGhlbiB0cnlpbmcgdG8gaGF2ZSBpbnRlcmFjdGl2ZSBkaXNjdXNzaW9ucyBv
ciBleHBsYW5hdGlvbnMgYWJvdXQ8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgaG93IE1Q
VENQIGlzIGN1cnJlbnRseSBpbXBsZW1lbnRlZCBvciBzaG91bGQgYmUgaW1wbGVtZW50ZWQgaWYg
aXQgZ29lczxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyB1cHN0cmVhbSwgZS5nLjogZm9y
IE1QVENQLCB3ZSBuZWVkIHRvIGhhdmUgZXh0cmEgVENQIE9wdGlvbnMsIHdlIG5lZWQgdG88YnI+
CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgc3VwcG9ydCBtaWRkbGVib3hlcywgd2UgbmVlZCB0
byBsaW5rIHN1YmZsb3dzIG9mIHRoZSBzYW1lIGNvbm5lY3Rpb248YnI+CiZndDsgJmd0OyZndDsm
Z3Q7Jmd0OyZndDsgdG9nZXRoZXIsIHdlIG5lZWQgYSBzY2hlZHVsZXIsIGEgUE0sIGV0Yy48YnI+
CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IEl0JiMzOTtzIGRpZmZpY3VsdCB0byBwcmVkaWN0IGhvdyBp
bnRlcmFjdGl2ZSBhbiBhdWRpZW5jZSB3aWxsIGJlLiBJJiMzOTt2ZTxicj4KJmd0OyAmZ3Q7Jmd0
OyZndDsmZ3Q7IG9ubHkgYXR0ZW5kZWQgb25lIE5ldGRldiBDb25mZXJlbmNlLCBhbmQgaXQgc2Vl
bWVkIGxpa2UgdGhlcmUgd2VyZSBhIGxvdDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IG1vcmUg
cGVvcGxlIHdpdGggZXhwZXJ0aXNlIGFuZCBpbnRlcmVzdCBpbiBkcml2ZXJzLCBsb3dlciBsYXll
cnMgKFhEUCwgQlBGLDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IFRDLCBuZXRmaWx0ZXIpLCBh
bmQgbmV0d29yayB0b3BvbG9neS9zaW11bGF0aW9uLiBEaXNjdXNzaW9uIGFyb3VuZDxicj4KJmd0
OyAmZ3Q7Jmd0OyZndDsmZ3Q7IG1pZGRsZWJveCBzdXBwb3J0IGFuZCB0aGUgdXNlcnNwYWNlIEFQ
SSBtaWdodCBoYXZlIG1vcmUgYXVkaWVuY2U8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBpbnRl
cmFjdGlvbi4gSWYgd2Ugd2FudCB0byBkcml2ZSBhIGRpc2N1c3Npb24sIHdlIGNvdWxkIHRyeSB0
byBzdHJpa2UgYTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IGJhbGFuY2UgYmV0d2VlbiB0b3Bp
Y3MgZm9yIHRoZSBicm9hZGVyIGF1ZGllbmNlIGFuZCB0aG9zZSB3aXRoIG1vcmU8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7Jmd0OyBrbm93bGVkZ2Ugb2YgVENQIGludGVybmFscy4gKEhvcGVmdWxseSBz
b21lIFRDUCBpbnRlcm5hbHMgcGVvcGxlIGFyZSBzdGlsbDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsm
Z3Q7IHBsYW5uaW5nIHRvIGF0dGVuZCk8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0
OyAmZ3Q7Jmd0OyZndDsmZ3Q7wqAgLSBPZiBjb3Vyc2UsIHdlIHNob3VsZCBmb2N1cyBvdXIgZGlz
Y3Vzc2lvbnMgb24gdGhlIHVwc3RyZWFtaW5nPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7
IGFzcGVjdCwgZS5nLiByZWR1Y2luZyB0aGUgZm9vdHByaW50IG9mIE1QVENQIGluIHRoZSBjdXJy
ZW50IFRDUCBzdGFjazogd2hhdDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBhcmUgd2Ug
YWxsb3cgdG8gZG8sIHdoYXQgbm90LiBJdCBpcyBsaW5rZWQgdG8gbWFueSBwcmV2aW91cyBkaXNj
dXNzaW9ucyB3ZTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBoYWQgb24gdGhpcyBNTCwg
ZS5nLiB3aHkgd2UgbmVlZCBtb3JlIGluZGlyZWN0IGZ1bmN0aW9uIGNhbGxzIGFuZCBob3cgdG88
YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgcmVkdWNlIHRoZSBpbXBhY3QsIGV0Yy48YnI+
CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7IFRoZSBwcmV2aW91cyB0YWxrIChbMl0pIGhhZCBhIHNlY3Rp
b24gbGlrZSB0aGlzLiBJIGhhdmVuJiMzOTt0IHdhdGNoZWQgaXQ8YnI+CiZndDsgJmd0OyZndDsm
Z3Q7Jmd0OyByZWNlbnRseSwgSSBzaG91bGQgbG9vayBhdCBpdCBhZ2FpbiB0byBzZWUgd2hhdCBr
aW5kIG9mIHF1ZXN0aW9ucyB0aGU8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBhdWRpZW5jZSB3
YXMgYXNraW5nLiBBcyB5b3UgbWVudGlvbmVkIGFib3ZlIHdlIHNob3VsZCBiZSBjYXJlZnVsIHRv
IGhhdmU8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyBuZXcgY29udGVudCBjb21wYXJlZCB0byB0
aGUgcHJldmlvdXMgc2Vzc2lvbi48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7Jmd0OyZndDsmZ3Q7wqAgLSBJZiB3ZSBoYXZlIHRpbWUsIHdlIGNvdWxkIGRpc2N1c3MgYWJv
dXQgaG93IHVzZXJzIGNvdWxkIGludGVyYWN0PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7
IHdpdGggTVBUQ1A6IGVuYWJsZSBpdCBwZXIgY29ubmVjdGlvbiwgY29udHJvbCB0aGUgcGF0aCBt
YW5hZ2VyLCBtYXliZSB0aGU8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgc2NoZWR1bGVy
LCBldGMuPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0
OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IFdoYXQgZG8geW91IHRoaW5r
IGFib3V0IHRoaXM/IEZlZWwgZnJlZSB0byBjb21tZW50IGFuZCBldmVuIHByb3Bvc2U8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgY29tcGxldGVseSBkaWZmZXJlbnQgaWRlYXMhPGJyPgom
Z3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyBUaGFuayB5b3UgZm9yIG91dGxpbmluZyB0aGVzZSBpZGVhcy4g
SSBzZWUgdGhhdCB0aGlzIHRvcGljIGlzIG9uIG91cjxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
IG1lZXRpbmcgYWdlbmRhIHNvIGl0IHdpbGwgYmUgZ29vZCB0byBkaXNjdXNzIHRoZSB0dXRvcmlh
bCB0aGVyZS48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsm
Z3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsgWzFdIDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMu
MDEub3JnL3BpcGVybWFpbC9tcHRjcC8yMDE4LU1hcmNoLzAwMDM3OS5odG1sIiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLjAxLm9yZy88d2JyPnBpcGVybWFp
bC9tcHRjcC8yMDE4LU1hcmNoLzx3YnI+MDAwMzc5Lmh0bWw8L2E+PGJyPgomZ3Q7ICZndDsmZ3Q7
Jmd0OyZndDsmZ3Q7IFsyXSA8YSBocmVmPSJodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92
PXdmdHoyY1U1U1pzIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3
dy55b3V0dWJlLmNvbS93YXRjaD88d2JyPnY9d2Z0ejJjVTVTWnM8L2E+PGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsmZ3Q7IFszXSA8YSBocmVmPSJodHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy8w
eDEyL3N1Ym1pdC1wcm9wb3NhbC5odG1sIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij5odHRwczovL3d3dy5uZXRkZXZjb25mLm9yZy88d2JyPjB4MTIvc3VibWl0LXByb3Bvc2FsLmh0
bWw8L2E+PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0
OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyAtLTxicj4K
Jmd0OyAmZ3Q7Jmd0OyBNYXQgTWFydGluZWF1PGJyPgomZ3Q7ICZndDsmZ3Q7IEludGVsIE9UQzxi
cj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0
Ozxicj4KJmd0OyAmZ3Q7IC0tPGJyPgo8L2Rpdj48L2Rpdj4mZ3Q7ICZndDsgW2ltYWdlOiBUZXNz
YXJlcyBTQV0gJmx0OzxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwOi8vd3d3LnRlc3NhcmVzLm5ldDwvYT4mZ3Q7IE1h
dHRoaWV1IEJhZXJ0cyB8IFImYW1wO0Q8YnI+CjxzcGFuIGNsYXNzPSIiPiZndDsgJmd0OyBFbmdp
bmVlcjxicj4KJmd0OyAmZ3Q7IDxhIGhyZWY9Im1haWx0bzptYXR0aGlldS5iYWVydHNAdGVzc2Fy
ZXMubmV0Ij5tYXR0aGlldS5iYWVydHNAdGVzc2FyZXMubmV0PC9hPjxicj4KJmd0OyAmZ3Q7IFRl
c3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1dGlvbnM8YnI+CiZndDsgJmd0OyA8YSBocmVm
PSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+d3d3LnRlc3NhcmVzLm5ldDwvYT48YnI+CiZndDsgJmd0OyAxIEF2ZW51ZSBKZWFuIE1vbm5l
dCwgMTM0OCBMb3V2YWluLWxhLU5ldXZlLCBCZWxnaXVtPGJyPgo8L3NwYW4+Jmd0OyAmZ3Q7ICZs
dDs8YSBocmVmPSJodHRwczovL3d3dy5nb29nbGUuY29tL21hcHM/cT0xK0F2ZW51ZStKZWFuK01v
bm5ldCwrMTM0OCtPdHRpZ25pZXMtTG91dmFpbi1sYS1OZXV2ZSwrQmVsZ2l1bSIgcmVsPSJub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuZ29vZ2xlLmNvbS9tYXBzPzx3YnI+
cT0xK0F2ZW51ZStKZWFuK01vbm5ldCwrMTM0OCs8d2JyPk90dGlnbmllcy1Mb3V2YWluLWxhLU5l
dXZlLCs8d2JyPkJlbGdpdW08L2E+Jmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7IDxicj4KJmd0
OyA8YnI+CiZndDsgPGJyPgomZ3Q7IC0tIDxicj4KJmd0OyBbaW1hZ2U6IFRlc3NhcmVzIFNBXSAm
bHQ7PGEgaHJlZj0iaHR0cDovL3d3dy50ZXNzYXJlcy5uZXQiIHJlbD0ibm9yZWZlcnJlciIgdGFy
Z2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cudGVzc2FyZXMubmV0PC9hPiZndDsgTWF0dGhpZXUgQmFl
cnRzIHwgUiZhbXA7RDxicj4KPHNwYW4gY2xhc3M9IiI+Jmd0OyBFbmdpbmVlcjxicj4KJmd0OyA8
YSBocmVmPSJtYWlsdG86bWF0dGhpZXUuYmFlcnRzQHRlc3NhcmVzLm5ldCI+bWF0dGhpZXUuYmFl
cnRzQHRlc3NhcmVzLm5ldDwvYT48YnI+CiZndDsgVGVzc2FyZXMgU0EgfCBIeWJyaWQgQWNjZXNz
IFNvbHV0aW9uczxicj4KJmd0OyA8YSBocmVmPSJodHRwOi8vd3d3LnRlc3NhcmVzLm5ldCIgcmVs
PSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+d3d3LnRlc3NhcmVzLm5ldDwvYT48YnI+CiZn
dDsgMSBBdmVudWUgSmVhbiBNb25uZXQsIDEzNDggTG91dmFpbi1sYS1OZXV2ZSwgQmVsZ2l1bTxi
cj4KPC9zcGFuPiZndDsgJmx0OzxhIGhyZWY9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9x
PTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4K090dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtC
ZWxnaXVtIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL3d3dy5nb29n
bGUuY29tL21hcHM/PHdicj5xPTErQXZlbnVlK0plYW4rTW9ubmV0LCsxMzQ4Kzx3YnI+T3R0aWdu
aWVzLUxvdXZhaW4tbGEtTmV1dmUsKzx3YnI+QmVsZ2l1bTwvYT4mZ3Q7PGJyPgo8c3BhbiBjbGFz
cz0iSE9FblpiIj48Zm9udCBjb2xvcj0iIzg4ODg4OCI+Jmd0OyA8YnI+CiZndDsgLS0gPGJyPgo8
L2ZvbnQ+PC9zcGFuPjxkaXYgY2xhc3M9IkhPRW5aYiI+PGRpdiBjbGFzcz0iaDUiPiZndDsgPGJy
PgomZ3Q7IDxicj4KJmd0OyBESVNDTEFJTUVSLjxicj4KJmd0OyBUaGlzIGVtYWlsIGFuZCBhbnkg
ZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBhcmUgY29uZmlkZW50aWFsIDxicj4KJmd0OyBhbmQg
aW50ZW5kZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0
byB3aG9tIHRoZXkgPGJyPgomZ3Q7IGFyZSBhZGRyZXNzZWQuIElmIHlvdSBoYXZlIHJlY2VpdmVk
IHRoaXMgZW1haWwgaW4gZXJyb3IgcGxlYXNlIG5vdGlmeSB0aGUgPGJyPgomZ3Q7IHN5c3RlbSBt
YW5hZ2VyLiBUaGlzIG1lc3NhZ2UgY29udGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFu
ZCBpcyA8YnI+CiZndDsgaW50ZW5kZWQgb25seSBmb3IgdGhlIGluZGl2aWR1YWwgbmFtZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgPGJyPgomZ3Q7IHlvdSBzaG91bGQgbm90
IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlIG9yIGNvcHkgdGhpcyBlLW1haWwuIFBsZWFzZSBub3Rp
ZnkgPGJyPgomZ3Q7IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgZS1tYWlsIGlmIHlvdSBoYXZl
IHJlY2VpdmVkIHRoaXMgZS1tYWlsIGJ5IDxicj4KJmd0OyBtaXN0YWtlIGFuZCBkZWxldGUgdGhp
cyBlLW1haWwgZnJvbSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhlIDxicj4KJmd0OyBp
bnRlbmRlZCByZWNpcGllbnQgeW91IGFyZSBub3RpZmllZCB0aGF0IGRpc2Nsb3NpbmcsIGNvcHlp
bmcsIGRpc3RyaWJ1dGluZyA8YnI+CiZndDsgb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFu
Y2Ugb24gdGhlIGNvbnRlbnRzIG9mIHRoaXMgaW5mb3JtYXRpb24gaXMgPGJyPgomZ3Q7IHN0cmlj
dGx5IHByb2hpYml0ZWQuPGJyPgo8L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjxi
ciBjbGVhcj0iYWxsIj48YnI+LS0gPGJyPjxkaXYgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSIgZGF0
YS1zbWFydG1haWw9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRp
cj0ibHRyIj48ZGl2PjxkaXYgZGlyPSJsdHIiPjx0YWJsZSBzdHlsZT0iZm9udC1mYW1pbHk6JnF1
b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2xldHRlci1zcGFjaW5nOm5vcm1hbDt0ZXh0LWluZGVu
dDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3b3JkLXNwYWNpbmc6MHB4IiB3aWR0aD0iMTAwJSIg
Ym9yZGVyPSIwIj48dGJvZHk+PHRyPjx0ZCByb3dzcGFuPSIzIiBzdHlsZT0icGFkZGluZy1sZWZ0
OjVweDtwYWRkaW5nLXJpZ2h0OjVweCIgd2lkdGg9IjEwIiB2YWxpZ249InRvcCIgYWxpZ249Imxl
ZnQiPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiB0YXJnZXQ9Il9ibGFuayI+PGlt
ZyBzcmM9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0L3NpZ2xvZ28ucG5nIiBhbHQ9IlRlc3NhcmVz
IFNBIiB3aWR0aD0iODAiIGhlaWdodD0iODAiIGJvcmRlcj0iMCI+PC9hPjwvdGQ+PHRkIHN0eWxl
PSJwYWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250
LXNpemU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxzcGFuIHN0eWxlPSJmb250LXdl
aWdodDpib2xkO2NvbG9yOnJnYigzNyw4MywxNTUpO2Rpc3BsYXk6aW5saW5lIj5NYXR0aGlldSBC
YWVydHMgfCBSJmFtcDtEIEVuZ2luZWVyPC9zcGFuPjwvdGQ+PC90cj48dHI+PHRkIHN0eWxlPSJw
YWRkaW5nOjBweDtmb250LWZhbWlseTpIZWx2ZXRpY2EsQXJpYWwsc2Fucy1zZXJpZjtmb250LXNp
emU6MTBweCIgaGVpZ2h0PSIxMiIgYWxpZ249ImxlZnQiPjxhIGhyZWY9Im1haWx0bzptYXR0aGll
dS5iYWVydHMlNDB0ZXNzYXJlcy5uZXQiIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApO3RleHQtZGVj
b3JhdGlvbjpub25lO2Rpc3BsYXk6aW5saW5lIiB0YXJnZXQ9Il9ibGFuayI+bWF0dGhpZXUuYmFl
cnRzQHRlc3NhcmVzLm5ldDxicj48L2E+PC90ZD48L3RyPjx0cj48dGQgc3R5bGU9InBhZGRpbmc6
MHB4O2ZvbnQtZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMHB4
IiBhbGlnbj0ibGVmdCI+PHNwYW4gc3R5bGU9ImZvbnQtd2VpZ2h0OmJvbGQ7Y29sb3I6cmdiKDM3
LDgzLDE1NSk7ZGlzcGxheTppbmxpbmUiPlRlc3NhcmVzIFNBIHwgSHlicmlkIEFjY2VzcyBTb2x1
dGlvbnM8YnI+PC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly93d3cudGVzc2FyZXMubmV0IiBzdHlsZT0i
Y29sb3I6cmdiKDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFy
Z2V0PSJfYmxhbmsiPnd3dy50ZXNzYXJlcy5uZXQ8L2E+PHNwYW4+wqA8L3NwYW4+PGJyPjxhIGhy
ZWY9Imh0dHBzOi8vd3d3Lmdvb2dsZS5jb20vbWFwcz9xPTErQXZlbnVlK0plYW4rTW9ubmV0LCsx
MzQ4K090dGlnbmllcy1Mb3V2YWluLWxhLU5ldXZlLCtCZWxnaXVtIiBzdHlsZT0iY29sb3I6cmdi
KDAsMCwwKTt0ZXh0LWRlY29yYXRpb246bm9uZTtkaXNwbGF5OmlubGluZSIgdGFyZ2V0PSJfYmxh
bmsiPjEgQXZlbnVlIEplYW4gTW9ubmV0LCAxMzQ4IExvdXZhaW4tbGEtTmV1dmUsIEJlbGdpdW08
L2E+PC90ZD48L3RyPjwvdGJvZHk+PC90YWJsZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rp
dj48L2Rpdj4KPC9kaXY+PC9kaXY+Cgo8YnI+CjxkaXY+PGJyPjxocj48L2Rpdj48Zm9udCBzaXpl
PSIxIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6VmVyZGFuYSxzYW5zLXNlcmlmO2JhY2tncm91
bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+RElTQ0xBSU1FUi48L3NwYW4+PGJyIHN0eWxlPSJm
b250LWZhbWlseTpWZXJkYW5hLHNhbnMtc2VyaWY7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1
NSwyNTUpIj48Zm9udCBjb2xvcj0iIzAwMDAwMCIgZmFjZT0iVmVyZGFuYSwgc2Fucy1zZXJpZiIg
c3R5bGU9ImJhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+VGhpcyBlbWFpbCBhbmQg
YW55IGZpbGVzIHRyYW5zbWl0dGVkIHdpdGggaXQgYXJlIGNvbmZpZGVudGlhbCBhbmQgaW50ZW5k
ZWQgc29sZWx5IGZvciB0aGUgdXNlIG9mIHRoZSBpbmRpdmlkdWFsIG9yIGVudGl0eSB0byB3aG9t
IHRoZXkgYXJlIGFkZHJlc3NlZC4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlbWFpbCBpbiBl
cnJvciBwbGVhc2Ugbm90aWZ5IHRoZSBzeXN0ZW0gbWFuYWdlci4gVGhpcyBtZXNzYWdlIGNvbnRh
aW5zIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBhbmQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhl
IGluZGl2aWR1YWwgbmFtZWQuIElmIHlvdSBhcmUgbm90IHRoZSBuYW1lZCBhZGRyZXNzZWUgeW91
IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUgb3IgY29weSB0aGlzIGUtbWFpbC4g
UGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IGUtbWFpbCBpZiB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBieSBtaXN0YWtlIGFuZCBkZWxldGUgdGhpcyBlLW1haWwg
ZnJvbSB5b3VyIHN5c3RlbS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCB5
b3UgYXJlIG5vdGlmaWVkIHRoYXQgZGlzY2xvc2luZywgY29weWluZywgZGlzdHJpYnV0aW5nIG9y
IHRha2luZyBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIG9uIHRoZSBjb250ZW50cyBvZiB0aGlzIGlu
Zm9ybWF0aW9uIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuPC9mb250PjwvZm9udD4=
--===============2609213453653917614==--
